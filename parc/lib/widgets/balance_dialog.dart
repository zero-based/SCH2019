import 'package:flutter/material.dart';

import 'outlined_text_field.dart';
import 'rounded_button.dart';

class BalanceDialog extends StatelessWidget {
  final VoidCallback onPressed;
  final BuildContext context;
  final TextEditingController amountController;

  BalanceDialog({
    this.context,
    this.onPressed,
    this.amountController,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(24.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        "Recharge",
        textAlign: TextAlign.center,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            SizedBox(height: 8),
            OutlinedTextField(
              text: "Card Number",
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 8),
            OutlinedTextField(
              text: "Security Code",
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 8),
            OutlinedTextField(
              suffixText: "EGP",
              text: "Payment Amount",
              keyboardType: TextInputType.number,
              controller: amountController,
            ),
            SizedBox(height: 16),
            RoundedButton(text: "Done", onPressed: onPressed),
          ],
        ),
      ),
    );
  }
}
