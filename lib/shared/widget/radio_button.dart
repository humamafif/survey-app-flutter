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
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.question,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
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
                      activeColor: Colors.green,
                      visualDensity: VisualDensity.compact,
                    ),
                    Text(
                      "${index + 1}",
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    ),
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
