import 'package:flutter/material.dart';

class OTPWidget extends StatelessWidget {

  const OTPWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      decoration: InputDecoration(
        hintText: "*",
        counterText: "",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      maxLength: 1,
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
        } else if (value.isEmpty) {
          FocusScope.of(context).previousFocus();
        }
      },
    );
  }
}