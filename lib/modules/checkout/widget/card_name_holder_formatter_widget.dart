import 'package:flutter/services.dart';

/// Card Holder Name Formatter
/// - Automatically converts to UPPERCASE
/// - Allows letters and spaces only
/// - Removes numbers and special characters
class CardNameHolderFormatterWidget extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text.toUpperCase();

    // Keep only A-Z and spaces
    text = text.replaceAll(RegExp(r'[^A-Z. ]'), '');

    // Prevent multiple spaces
    text = text.replaceAll(RegExp(r'\s+'), ' ');

    // Prevent leading spaces
    text = text.trimLeft();

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
