import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_app/shared/widget/radio_button.dart';

class SurveyPage extends StatelessWidget {
  const SurveyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // context.goNamed('/');
            GoRouter.of(context).pop();
            // Navigator.of(context).pop();
          },
        ),
        title: Text("Survey Page"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                RadioButton(question: "why earth circular?"),
                RadioButton(question: "why earth circular?"),
                RadioButton(question: "why earth circular?"),
                RadioButton(question: "why earth circular?"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
