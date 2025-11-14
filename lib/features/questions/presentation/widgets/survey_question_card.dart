import 'package:survey_app/core/app/app_exports.dart';

class SurveyQuestionCard extends StatefulWidget {
  final QuestionEntity question;
  final Function(int rating)? onRatingSelected;
  final Function(String text)? onKritikSaranChanged;
  final TextEditingController? textController;
  final int? initialRating;

  const SurveyQuestionCard({
    Key? key,
    required this.question,
    this.onRatingSelected,
    this.onKritikSaranChanged,
    this.textController,
    this.initialRating,
  }) : super(key: key);

  @override
  State<SurveyQuestionCard> createState() => _SurveyQuestionCardState();
}

class _SurveyQuestionCardState extends State<SurveyQuestionCard> {
  late int _selectedRating;

  @override
  void initState() {
    super.initState();
    _selectedRating = widget.initialRating ?? 0;
  }

  @override
  void didUpdateWidget(SurveyQuestionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialRating != null &&
        widget.initialRating != _selectedRating) {
      setState(() {
        _selectedRating = widget.initialRating!;
      });
    }
  }

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
          if (widget.question.type == "kritik_saran") _buildKritikSaranInput(),
        ],
      ),
    );
  }

  Widget _buildRatingSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (index) {
        final rating = index + 1;
        return Expanded(
          child: Column(
            children: [
              Radio<int>(
                value: rating,
                groupValue: _selectedRating,
                onChanged: (value) {
                  print(
                    "Radio button changed: Question ID: ${widget.question.id}, Value: $value",
                  );

                  if (value != null) {
                    setState(() {
                      _selectedRating = value;
                    });

                    if (widget.onRatingSelected != null) {
                      widget.onRatingSelected!(value);
                    }
                  }
                },
                activeColor: AppColor.primaryColor,
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.padded,
              ),
              Text("$rating", style: AppTextStyles.bodySmall),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildKritikSaranInput() {
    return TextField(
      controller: widget.textController,
      maxLines: 4,
      onChanged: widget.onKritikSaranChanged,
      decoration: InputDecoration(
        hintText: "Tulis kritik dan saran Anda di sini (opsional)",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColor.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColor.borderColor.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColor.primaryColor),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        filled: true,
        fillColor: AppColor.surfaceColor,
      ),
      style: AppTextStyles.bodyMedium,
    );
  }
}
