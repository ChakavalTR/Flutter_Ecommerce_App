import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';

class TitleResultWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final int resultCount;
  const TitleResultWidget({
    super.key,
    required this.title,
    this.onTap,
    required this.resultCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
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
            Text(
              '$resultCount results found',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.greyText.withOpacity(0.7),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
