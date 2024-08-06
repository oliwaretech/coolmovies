import 'package:flutter/material.dart';
import '../styles/styles.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox.square(
        dimension: 40,
        child: CircularProgressIndicator(
          strokeCap: StrokeCap.round,
          color: AppColors.primaryBlue,
          strokeWidth: 5.0,
        ),
      ),
    );
  }
}
