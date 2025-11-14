import 'package:survey_app/core/app/app_exports.dart';

class QuestionsListPage extends StatefulWidget {
  final int dosenId;
  final int? matakuliahId;
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
              return const LoadingPage();
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
            showSnackbar(
              context,
              'Terima kasih! Survey berhasil dikirim.',
              AppColor.success,
              SnackBarType.success,
            );
            Future.delayed(Duration(seconds: 0), () {
              GoRouter.of(context).goNamed("/home");
            });
          } else if (state is ResponsesError) {
            setState(() {
              _submitting = false;
            });

            showSnackbar(
              context,
              'Gagal mengirim survey: ${state.message}',
              AppColor.error,
              SnackBarType.fail,
            );
          }
        },
        builder: (context, state) {
          final bool isLoading = state is ResponsesLoading || _submitting;
          final questionsState = context.watch<QuestionsBloc>().state;
          final bool hasQuestions =
              questionsState is QuestionLoadedBySurveyIdState ||
              questionsState is QuestionLoadedAllState;
          if (!hasQuestions) {
            return SizedBox.shrink();
          }
          if (isLoading) {
            return LoadingPage();
          }
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColor.surfaceColor,
              boxShadow: [
                BoxShadow(
                  color: AppColor.primaryColor.withAlpha(10),
                  blurRadius: 4,
                  spreadRadius: 0,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: _submitSurvey,
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
                      ? LoadingPage()
                      : Text("Kirim Survey", style: AppTextStyles.buttonText),
            ),
          );
        },
      ),
    );
  }

  bool _isAllRatingQuestionsAnswered() {
    final questionState = context.read<QuestionsBloc>().state;
    List<QuestionEntity> questions = [];

    if (questionState is QuestionLoadedBySurveyIdState) {
      questions = questionState.questions;
    } else if (questionState is QuestionLoadedAllState) {
      questions = questionState.questions;
    }
    final ratingQuestions = questions.where((q) => q.type == "rating").toList();
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
            color: AppColor.primaryColor.withAlpha(10),
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
            ...questions.map((question) {
              if (question.type == "kritik_saran") {
                _kritikSaranQuestionId = question.id;
              }
              return SurveyQuestionCard(
                key: ValueKey(question.id),
                question: question,
                initialRating: _ratingResponses[question.id],
                onRatingSelected:
                    question.type == "rating"
                        ? (rating) {
                          setState(() {
                            _ratingResponses[question.id] = rating;
                            print(
                              "Saved rating for question ${question.id}: $rating",
                            );
                          });
                        }
                        : null,
                onKritikSaranChanged:
                    question.type == "kritik_saran"
                        ? (text) {
                          print(
                            "Kritik Saran untuk question ${question.id}: $text",
                          );
                        }
                        : null,
                textController:
                    question.type == "kritik_saran"
                        ? _kritikSaranController
                        : null,
              );
            }),
          ],
        );
  }

  void _submitSurvey() {
    if (_currentUser == null) {
      showSnackbar(
        context,
        'Anda perlu login terlebih dahulu',
        AppColor.error,
        SnackBarType.fail,
      );
      return;
    }
    if (!_isAllRatingQuestionsAnswered()) {
      showSnackbar(
        context,
        'Harap jawab semua pertanyaan sebelum mengirim',
        AppColor.warning,
        SnackBarType.alert,
      );
      return;
    }
    setState(() {
      _submitting = true;
    });
    print("Rating responses: $_ratingResponses");

    final responses =
        _ratingResponses.entries.map((entry) {
          return ResponseEntity(
            userId: int.parse(_currentUser!.id!),
            surveyId: widget.surveyId,
            questionId: entry.key,
            nilai: entry.value,
            kritikSaran: null,
          );
        }).toList();
    if (_kritikSaranQuestionId != null) {
      final kritikSaranText = _kritikSaranController.text.trim();
      print("Kritik Saran Question ID: $_kritikSaranQuestionId");
      print("Kritik Saran Text: '$kritikSaranText'");

      if (kritikSaranText.isNotEmpty) {
        responses.add(
          ResponseEntity(
            userId: int.parse(_currentUser!.id!),
            surveyId: widget.surveyId,
            questionId: _kritikSaranQuestionId!,
            kritikSaran: kritikSaranText,
          ),
        );
        print(
          "✅ Kritik saran berhasil ditambahkan ke responses. ID USER: ${_currentUser!.id.toString()}",
        );
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
    context.read<ResponsesBloc>().add(
      CreateMultipleResponsesWithAssesmentEvent(
        responses: responses,
        mahasiswaId: int.parse(_currentUser!.id!),
        mkId: widget.matakuliahId!,
        dosenId: widget.dosenId,
        surveyId: widget.surveyId,
      ),
    );
  }
}
