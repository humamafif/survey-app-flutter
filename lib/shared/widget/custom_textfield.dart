import 'package:survey_app/core/app/app_export.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.isPassword = false,
    this.controller,
    this.labelText,
  });
  final String? hintText;
  final String? labelText;
  final bool isPassword;
  final TextEditingController? controller;

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late bool _isPassword;

  @override
  void initState() {
    super.initState();
    _isPassword = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText ?? ""),
        4.verticalSpace,
        TextField(
          cursorColor: Colors.grey,
          obscureText: _isPassword,
          controller: widget.controller,
          decoration: InputDecoration(
            suffixIcon:
                widget.isPassword
                    ? IconButton(
                      icon: Icon(
                        _isPassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPassword = !_isPassword;
                        });
                      },
                    )
                    : null,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontStyle: FontStyle.italic,
              fontSize: 14,
            ),
            filled: true,
            fillColor: Colors.grey.withValues(alpha: 0.2),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
