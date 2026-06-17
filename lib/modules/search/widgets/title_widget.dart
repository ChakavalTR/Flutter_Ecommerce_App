import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const TitleWidget({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 10),
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(),
          if (onTap != null)
            TextButton(
              onPressed: onTap,
              child: Text(
                'Clear All',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
        ],
      ),
    );
  }
}
