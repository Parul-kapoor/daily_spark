import 'package:daily_spark/core/constants/strings.dart';
import 'package:flutter/material.dart';

class ChangeQuoteBtn extends StatelessWidget {
  final VoidCallback onPressed;
  const ChangeQuoteBtn({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8A5CF6),
          foregroundColor: Colors.white,
          elevation: 8,
          shadowColor: Colors.black45,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(AppStrings.changeQuote,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            )),
          ],
        ),
      ),
    );
  }
}
