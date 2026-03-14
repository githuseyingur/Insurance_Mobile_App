import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

SnackBar getSnackBar(
    {required Color textColor,
    required Color bgColor,
    required String text,
    int? seconds}) {
  return SnackBar(
    backgroundColor: bgColor,
    shape: Border(
      top: BorderSide(
        width: 0.3.h,
        color: textColor,
      ),
    ),
    duration: Duration(seconds: seconds ?? 3),
    content: Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 12.sp,
        color: textColor,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
    ),
  );
}
