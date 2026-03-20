import 'package:flutter/material.dart';

class SaveShareBtn extends StatelessWidget {
  final bool isSaved;
  final VoidCallback saveQuote;
  final VoidCallback shareQuote;
  const SaveShareBtn({
    super.key,
    required this.isSaved,
    required this.saveQuote,
    required this.shareQuote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: saveQuote,
            icon: Icon(
              isSaved ? Icons.favorite : Icons.favorite_outline_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          IconButton(
            onPressed: shareQuote,
            icon: Icon(
              Icons.share_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
