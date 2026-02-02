import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

// ignore: must_be_immutable
class PinInputFeild extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
final String? Function(String?)? validator;

   PinInputFeild({super.key, this.onChanged, this.onCompleted, this.validator});

  bool showError = false;

  @override
  Widget build(BuildContext context) {
    const length = 6;
    const borderColor = Color.fromRGBO(114, 178, 238, 1);
    const errorColor = Color.fromRGBO(255, 234, 238, 1);
    const fillColor = Color.fromRGBO(222, 231, 240, .57);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: GoogleFonts.poppins(
        fontSize: 22,
        color: const Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return SizedBox(
      height: 68,
      child: Pinput(
        length: length,
      //  controller: controller,
        validator:validator,
       // focusNode: focusNode,
        defaultPinTheme: defaultPinTheme,
        onCompleted: onCompleted,
        onChanged: onChanged,
        focusedPinTheme: defaultPinTheme.copyWith(
          height: 68,
          width: 64,
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: borderColor),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            color: errorColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }


}
