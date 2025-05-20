import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_app/core/app/theme/colors/app_color.dart';
import 'package:survey_app/core/app/theme/style/app_text_styles.dart';
import 'package:survey_app/features/questions/domain/entities/question_entity.dart';
import 'package:survey_app/features/questions/presentation/bloc/questions_bloc.dart';
import 'package:survey_app/features/questions/presentation/widgets/survey_question_card.dart';

class QuestionsListPage extends StatefulWidget {
  final int dosenId;
  final int matakuliahId;

  const QuestionsListPage({
    super.key,
    required this.dosenId,
    required this.matakuliahId,
  });

  @override
  State<QuestionsListPage> createState() => _QuestionsListPageState();
}

class _QuestionsListPageState extends State<QuestionsListPage> {
  final Map<int, int> _questionResponses = {};

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void _loadQuestions() {
    // if (widget.surveyId != null) {
    //   context.read<QuestionsBloc>().add(
    //     GetQuestionsBySurveyIdEvent(widget.surveyId!),
    //   );
    // } else {
    //   context.read<QuestionsBloc>().add(GetAllQuestionsEvent());
    // }
    context.read<QuestionsBloc>().add(GetAllQuestionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        title: Row(
          children: [
            Text(
              // widget.surveyTitle ?? "Pertanyaan Survey",
              widget.matakuliahId.toString(),
              style: AppTextStyles.h3,
            ),
            Text(
              // widget.surveyTitle ?? "Pertanyaan Survey",
              widget.dosenId.toString(),
              style: AppTextStyles.h3,
            ),
          ],
        ),
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
      bottomNavigationBar: BlocBuilder<QuestionsBloc, QuestionsState>(
        builder: (context, state) {
          if (state is QuestionLoadedBySurveyIdState ||
              state is QuestionLoadedAllState) {
            return _buildSubmitButton();
          }
          return SizedBox.shrink();
        },
      ),
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
        : SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Jawab pertanyaan berikut:", style: AppTextStyles.h3),
              SizedBox(height: 16.h),
              ...questions.map(
                (question) => SurveyQuestionCard(
                  key: ValueKey(question.id),
                  question: question,
                  onRatingSelected: (rating) {
                    _questionResponses[question.id] = rating;
                  },
                ),
              ),
              SizedBox(height: 80.h), // Space for bottom button
            ],
          ),
        );
  }

  Widget _buildSubmitButton() {
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
        onPressed: _submitSurvey,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Text("Kirim Survey", style: AppTextStyles.buttonText),
      ),
    );
  }

  void _submitSurvey() {
    // Implement survey submission logic here

    // For now, just show success and go back
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Terima kasih! Survey berhasil dikirim.',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.success,
      ),
    );

    // Wait a moment before popping
    Future.delayed(Duration(seconds: 1), () {
      context.pop();
    });
  }
}
