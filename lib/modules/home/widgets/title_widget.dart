import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const TitleWidget({super.key, required this.title, this.onTap});

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
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkBg,
              ),
            ),
            Spacer(),
            if (onTap != null)
              TextButton(
                onPressed: onTap,
                child: Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.primary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
