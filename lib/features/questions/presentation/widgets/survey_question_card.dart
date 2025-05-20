import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:survey_app/core/app/theme/colors/app_color.dart';
import 'package:survey_app/core/app/theme/style/app_text_styles.dart';
import 'package:survey_app/features/questions/domain/entities/question_entity.dart';

class SurveyQuestionCard extends StatefulWidget {
  final QuestionEntity question;
  final Function(int rating)? onRatingSelected;

  const SurveyQuestionCard({
    Key? key,
    required this.question,
    this.onRatingSelected,
  }) : super(key: key);

  @override
  State<SurveyQuestionCard> createState() => _SurveyQuestionCardState();
}

class _SurveyQuestionCardState extends State<SurveyQuestionCard> {
  int _selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
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
          Text(
            widget.question.question,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16.h),
          if (widget.question.type == "rating") _buildRatingSelector(),
        ],
      ),
    );
  }

  Widget _buildRatingSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(5, (index) {
        final rating = index + 1;
        return Expanded(
          child: Column(
            children: [
              Radio<int>(
                value: rating,
                groupValue: _selectedRating,
                onChanged: (value) {
                  setState(() {
                    _selectedRating = value!;
                  });
                  if (widget.onRatingSelected != null) {
                    widget.onRatingSelected!(value!);
                  }
                },
                activeColor: AppColor.primaryColor,
                visualDensity: VisualDensity.compact,
              ),
              Text("$rating", style: AppTextStyles.bodySmall),
            ],
          ),
        );
      }),
    );
  }
}
