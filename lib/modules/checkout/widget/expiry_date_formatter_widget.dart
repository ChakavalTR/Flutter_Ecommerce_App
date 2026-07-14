import 'package:flutter/services.dart';

/// Expiry Date Formatter
/// -> 12/28
class ExpiryDateFormatterWidget extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');

    final limitedDigits = digits.length > 4 ? digits.substring(0, 4) : digits;

    String text = '';

    if (limitedDigits.length <= 2) {
      text = limitedDigits;

      if (limitedDigits.length == 2) {
        text += '/';
      }
    } else {
      text = '${limitedDigits.substring(0, 2)}/${limitedDigits.substring(2)}';
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
