import 'package:survey_app/core/app/app_exports.dart';

class RadioButton extends StatefulWidget {
  const RadioButton({super.key, required this.question});
  final String question;

  @override
  RadioButtonState createState() => RadioButtonState();
}

class RadioButtonState extends State<RadioButton> {
  int _selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.surfaceColor,
        borderRadius: BorderRadius.circular(10.r),
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.question, style: AppTextStyles.h3),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              return Expanded(
                child: Column(
                  children: [
                    Radio(
                      value: index + 1,
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value as int;
                        });
                        // logic to save the value
                        print(value);
                        print(widget.question);
                      },
                      activeColor: AppColor.primaryColor,
                      visualDensity: VisualDensity.compact,
                    ),
                    Text("${index + 1}", style: AppTextStyles.bodySmall),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
