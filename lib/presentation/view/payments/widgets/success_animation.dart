
import 'package:flutter/material.dart';
import 'package:spark/utils/constants/colors.dart';

class PaymentSuccessAnimation extends StatefulWidget {
  const PaymentSuccessAnimation({Key? key}) : super(key: key);

  @override
  State<PaymentSuccessAnimation> createState() =>
      _PaymentSuccessAnimationState();
}

class _PaymentSuccessAnimationState extends State<PaymentSuccessAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          height: 150,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 50.0, color: Colors.green),
              SizedBox(height: 10.0),
              Text(
                'Payment Successful!',
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
