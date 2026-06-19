import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';

class TitleSearchWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const TitleSearchWidget({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkBg,
              ),
            ),
            Spacer(),
            if (onTap != null)
              IconButton(
                onPressed: onTap,
                icon: Icon(Icons.delete, color: AppTheme.danger),
              ),
          ],
        ),
      ),
    );
  }
}
