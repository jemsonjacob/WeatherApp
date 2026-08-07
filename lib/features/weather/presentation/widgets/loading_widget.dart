import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/animation/Suncloud.json',
        width: 120,
        height: 100,
      ),
    );
  }
}
