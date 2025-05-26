import 'package:survey_app/core/app/app_exports.dart';
import 'package:survey_app/features/questions/domain/entities/question_entity.dart';
import 'package:survey_app/features/questions/presentation/bloc/questions_bloc.dart';
import 'package:survey_app/features/questions/presentation/widgets/survey_question_card.dart';
import 'package:survey_app/features/responses/domain/entities/response_entity.dart';
import 'package:survey_app/features/responses/presentation/bloc/responses_bloc.dart';

class QuestionsListPage extends StatefulWidget {
  final int dosenId;
  final int matakuliahId;
  final int surveyId;
  final String? namaMk;
  final String? namaDosen;

  const QuestionsListPage({
    super.key,
    required this.dosenId,
    required this.matakuliahId,
    required this.surveyId,
    this.namaMk,
    this.namaDosen,
  });

  @override
  State<QuestionsListPage> createState() => _QuestionsListPageState();
}

class _QuestionsListPageState extends State<QuestionsListPage> {
  final Map<dynamic, dynamic> _ratingResponses = {};
  // String? kritikSaranText;
  int? _kritikSaranQuestionId;
  final TextEditingController _kritikSaranController = TextEditingController();
  bool _submitting = false;
  UserEntity? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
    _getCurrentUser();
  }

  @override
  void dispose() {
    _kritikSaranController.dispose();
    super.dispose();
  }

  void _getCurrentUser() {
    final authState = context.read<AuthBloc>().state;
    if (authState is Authenticated) {
      _currentUser = authState.user;
    }
  }

  void _loadQuestions() {
    context.read<QuestionsBloc>().add(
      GetQuestionsBySurveyIdEvent(widget.surveyId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        title: Text("Pertanyaan Survey", style: AppTextStyles.h2),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.textPrimary,
            size: 24.sp,
          ),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<QuestionsBloc, QuestionsState>(
          builder: (context, state) {
            if (state is QuestionLoadingState) {
              return _buildLoadingState();
            } else if (state is QuestionErrorState) {
              return _buildErrorState(state.message);
            } else if (state is QuestionLoadedBySurveyIdState) {
              return _buildQuestionsList(state.questions);
            } else if (state is QuestionLoadedAllState) {
              return _buildQuestionsList(state.questions);
            }
            return _buildEmptyState();
          },
        ),
      ),
      bottomNavigationBar: BlocConsumer<ResponsesBloc, ResponsesState>(
        listener: (context, state) {
          if (state is MultipleResponsesCreatedSuccess ||
              state is MultipleResponsesWithAssesmentCreatedSuccess) {
            setState(() {
              _submitting = false;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Terima kasih! Survey berhasil dikirim.',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: AppColor.success,
              ),
            );

            // Tunggu sebentar sebelum kembali
            Future.delayed(Duration(seconds: 1), () {
              context.pop();
            });
          } else if (state is ResponsesError) {
            setState(() {
              _submitting = false;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Gagal mengirim survey: ${state.message}',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: AppColor.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final bool isLoading = state is ResponsesLoading || _submitting;

          // Cek jika state adalah QuestionLoadedBySurveyIdState atau QuestionLoadedAllState
          final questionsState = context.watch<QuestionsBloc>().state;
          final bool hasQuestions =
              questionsState is QuestionLoadedBySurveyIdState ||
              questionsState is QuestionLoadedAllState;

          if (!hasQuestions) {
            return SizedBox.shrink();
          }

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColor.surfaceColor,
              boxShadow: [
                BoxShadow(
                  color: AppColor.primaryColor.withOpacity(0.1),
                  blurRadius: 4,
                  spreadRadius: 0,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed:
                  isLoading || !_isAllRatingQuestionsAnswered()
                      ? null
                      : _submitSurvey,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor,
                disabledBackgroundColor: AppColor.textDisabled,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child:
                  isLoading
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Text("Mengirim...", style: AppTextStyles.buttonText),
                        ],
                      )
                      : Text("Kirim Survey", style: AppTextStyles.buttonText),
            ),
          );
        },
      ),
    );
  }

  // Cek apakah semua pertanyaan rating sudah dijawab
  bool _isAllRatingQuestionsAnswered() {
    final questionState = context.read<QuestionsBloc>().state;
    List<QuestionEntity> questions = [];

    if (questionState is QuestionLoadedBySurveyIdState) {
      questions = questionState.questions;
    } else if (questionState is QuestionLoadedAllState) {
      questions = questionState.questions;
    }

    // Hitung jumlah pertanyaan rating
    final ratingQuestions = questions.where((q) => q.type == "rating").toList();

    // Cek apakah semua pertanyaan rating sudah dijawab
    return ratingQuestions.length == _ratingResponses.length;
  }

  Widget _buildInfoCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.surfaceColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Informasi Survey", style: AppTextStyles.h3),
          12.verticalSpace,
          if (widget.namaMk != null) _infoRow("Mata Kuliah", widget.namaMk!),
          if (widget.namaMk != null) 8.verticalSpace,
          if (widget.namaDosen != null) _infoRow("Dosen", widget.namaDosen!),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100.w,
          child: Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColor.textSecondary,
            ),
          ),
        ),
        Text(": "),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColor.primaryColor),
          SizedBox(height: 16.h),
          Text("Memuat pertanyaan survey...", style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: AppColor.error, size: 48.sp),
            SizedBox(height: 16.h),
            Text(
              "Error",
              style: AppTextStyles.h3.copyWith(color: AppColor.error),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: _loadQuestions,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
              child: Text("Coba Lagi", style: AppTextStyles.buttonText),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.question_answer_outlined,
            color: AppColor.textSecondary,
            size: 48.sp,
          ),
          SizedBox(height: 16.h),
          Text("Tidak ada pertanyaan", style: AppTextStyles.h3),
        ],
      ),
    );
  }

  Widget _buildQuestionsList(List<QuestionEntity> questions) {
    return questions.isEmpty
        ? _buildEmptyState()
        : ListView(
          padding: EdgeInsets.all(16.w),
          children: [
            // Info mata kuliah dan dosen
            if (widget.namaMk != null || widget.namaDosen != null) ...[
              _buildInfoCard(),
              SizedBox(height: 16.h),
            ],

            Text("Jawab pertanyaan berikut:", style: AppTextStyles.h3),
            SizedBox(height: 16.h),

            // Di dalam _buildQuestionsList
            ...questions.map((question) {
              // Jika pertanyaan kritik dan saran, simpan ID-nya
              if (question.type == "kritik_saran") {
                _kritikSaranQuestionId = question.id;
              }

              return SurveyQuestionCard(
                key: ValueKey(question.id),
                question: question,
                initialRating: _ratingResponses[question.id], // Tambahkan ini
                onRatingSelected:
                    question.type == "rating"
                        ? (rating) {
                          setState(() {
                            _ratingResponses[question.id] = rating;
                            print(
                              "Saved rating for question ${question.id}: $rating",
                            ); // Tambahkan log
                          });
                        }
                        : null,
                onKritikSaranChanged:
                    question.type == "kritik_saran"
                        ? (text) {
                          print(
                            "Kritik Saran untuk question ${question.id}: $text",
                          ); // Tambahkan log
                        }
                        : null,
                textController:
                    question.type == "kritik_saran"
                        ? _kritikSaranController
                        : null,
              );
            }),

            SizedBox(height: 80.h), // Space for bottom button
          ],
        );
  }

  // Dalam method _submitSurvey()
  void _submitSurvey() {
    if (_currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Anda perlu login terlebih dahulu',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColor.error,
        ),
      );
      return;
    }

    // Validasi apakah semua pertanyaan rating sudah dijawab
    if (!_isAllRatingQuestionsAnswered()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Harap jawab semua pertanyaan sebelum mengirim',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColor.warning,
        ),
      );
      return;
    }

    setState(() {
      _submitting = true;
    });

    print("Rating responses: $_ratingResponses");

    // Buat list responses dari pertanyaan rating
    final responses =
        _ratingResponses.entries.map((entry) {
          return ResponseEntity(
            userId: 20,
            surveyId: widget.surveyId,
            questionId: entry.key,
            nilai: entry.value,
            kritikSaran: null,
          );
        }).toList();

    // Jika ada pertanyaan kritik dan saran, tambahkan ke responses
    if (_kritikSaranQuestionId != null) {
      final kritikSaranText = _kritikSaranController.text.trim();

      print("Kritik Saran Question ID: $_kritikSaranQuestionId");
      print("Kritik Saran Text: '$kritikSaranText'");

      if (kritikSaranText.isNotEmpty) {
        responses.add(
          ResponseEntity(
            userId: 20,
            surveyId: widget.surveyId,
            questionId: _kritikSaranQuestionId!,
            nilai: 5, // Nilai default untuk pertanyaan kritik_saran
            kritikSaran: kritikSaranText,
          ),
        );
        print("Kritik saran berhasil ditambahkan ke responses");
      }
    }

    print(
      "Mengirim ${responses.length} responses dengan multi-insert dan penilaian dosen...",
    );
    for (int i = 0; i < responses.length; i++) {
      print(
        "Response ${i + 1}/${responses.length} - QuestionID: ${responses[i].questionId}, Nilai: ${responses[i].nilai}, KritikSaran: ${responses[i].kritikSaran}",
      );
    }

    // Gunakan event baru yang menangani multi-insert dan penilaian dosen sekaligus
    context.read<ResponsesBloc>().add(
      CreateMultipleResponsesWithAssesmentEvent(
        responses: responses,
        mahasiswaId: 20,
        mkId: widget.matakuliahId,
        dosenId: widget.dosenId,
        surveyId: widget.surveyId,
      ),
    );
  }

  // // Implementasi manual tanpa menggunakan bloc
  // Future<void> _manualSendResponses() async {
  //   final Dio dio = Dio();
  //   dio.options.headers = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   };

  //   // Buat list responses dari pertanyaan rating
  //   final responses =
  //       _ratingResponses.entries.map((entry) {
  //         return {
  //           'user_id': 20,
  //           'survey_id': widget.surveyId,
  //           'question_id': entry.key,
  //           'nilai': entry.value,
  //         };
  //       }).toList();

  //   // Jika ada kritik dan saran, tambahkan ke responses
  //   if (_kritikSaranQuestionId != null) {
  //     final kritikSaranText = _kritikSaranController.text.trim();
  //     if (kritikSaranText.isNotEmpty) {
  //       responses.add({
  //         'user_id': 20,
  //         'survey_id': widget.surveyId,
  //         'question_id': _kritikSaranQuestionId!,
  //         'nilai': 0,
  //         'kritik_saran': kritikSaranText,
  //       });
  //       print("Kritik saran ditambahkan: $kritikSaranText");
  //     }
  //   }

  //   print("Total ${responses.length} responses akan dikirim");

  //   int successCount = 0;
  //   List<String> errors = [];

  //   // Kirim satu per satu
  //   for (int i = 0; i < responses.length; i++) {
  //     try {
  //       final response = responses[i];
  //       print("Mengirim ${i + 1}/${responses.length}: $response");

  //       final result = await dio.post(
  //         '${dotenv.env['BASE_URL']}/responses',
  //         data: response,
  //       );

  //       print("Response ${i + 1}: ${result.statusCode} - ${result.data}");
  //       successCount++;
  //     } catch (e) {
  //       print("Error saat mengirim response ${i + 1}: $e");
  //       if (e.toString().contains('created successfully')) {
  //         print("Response ${i + 1} berhasil meskipun ada error");
  //         successCount++;
  //       } else {
  //         errors.add("Response ${i + 1}: $e");
  //       }
  //     }

  //     // Tambahkan delay kecil antara requests
  //     await Future.delayed(Duration(milliseconds: 200));
  //   }

  //   setState(() {
  //     _submitting = false;
  //   });

  //   // Tampilkan hasil
  //   if (successCount > 0) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           'Terima kasih! Survey berhasil dikirim ($successCount/${responses.length}).',
  //           style: TextStyle(color: Colors.white),
  //         ),
  //         backgroundColor: AppColor.success,
  //       ),
  //     );

  //     // Tunggu sebentar sebelum pop
  //     Future.delayed(Duration(seconds: 1), () {
  //       context.pop();
  //     });
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           'Gagal mengirim survey: ${errors.join(", ")}',
  //           style: TextStyle(color: Colors.white),
  //         ),
  //         backgroundColor: AppColor.error,
  //       ),
  //     );
  //   }
  // }

  // Future<void> _sendResponsesOneByOne() async {
  //   // Buat list responses dari pertanyaan rating
  //   final responses =
  //       _ratingResponses.entries.map((entry) {
  //         return ResponseEntity(
  //           userId: 1,
  //           surveyId: widget.surveyId,
  //           questionId: entry.key,
  //           nilai: entry.value,
  //           kritikSaran: null, // Kritik saran terpisah
  //         );
  //       }).toList();

  //   // Jika ada pertanyaan kritik dan saran, tambahkan ke responses
  //   if (_kritikSaranQuestionId != null) {
  //     final kritikSaranText = _kritikSaranController.text.trim();

  //     print("Kritik Saran Question ID: $_kritikSaranQuestionId");
  //     print("Kritik Saran Text: '$kritikSaranText'");

  //     if (kritikSaranText.isNotEmpty) {
  //       responses.add(
  //         ResponseEntity(
  //           userId: 1,
  //           surveyId: widget.surveyId,
  //           questionId: _kritikSaranQuestionId!,
  //           nilai: 5, // Nilai default untuk pertanyaan kritik_saran
  //           kritikSaran: kritikSaranText,
  //         ),
  //       );
  //       print("Kritik saran berhasil ditambahkan ke responses");
  //     }
  //   }

  //   print("Mengirim ${responses.length} responses...");
  //   for (int i = 0; i < responses.length; i++) {
  //     print(
  //       "Mengirim response ${i + 1}/${responses.length} - QuestionID: ${responses[i].questionId}, Nilai: ${responses[i].nilai}, KritikSaran: ${responses[i].kritikSaran}",
  //     );
  //   }

  //   // Gunakan metode createBulkResponses di ResponseBloc
  //   // untuk mengirim semua responses sekaligus
  //   context.read<ResponsesBloc>().add(CreateBulkResponsesEvent(responses));
  // }
}
