import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';

class ColorOptionWidget extends StatelessWidget {
  final Color color;
  final bool isSelected;
  const ColorOptionWidget({
    super.key,
    required this.color,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppTheme.primary : Colors.transparent,
          width: 2,
        ),
      ),
      child: isSelected
          ? Icon(Icons.check, color: Colors.white, size: 20)
          : SizedBox.shrink(),
    );
  }
}
