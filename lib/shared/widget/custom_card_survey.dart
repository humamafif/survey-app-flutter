import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomCardSurvey extends StatelessWidget {
  const CustomCardSurvey({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.goNamed('/survey-form'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(13.0),
        ),
      ),
    );
  }
}
