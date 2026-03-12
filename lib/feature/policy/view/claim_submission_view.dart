import 'package:crenno_huseyin_gur/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ClaimSubmissionView extends StatefulWidget {
  const ClaimSubmissionView({super.key});

  @override
  State<ClaimSubmissionView> createState() => _ClaimSubmissionViewState();
}

class _ClaimSubmissionViewState extends State<ClaimSubmissionView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime? _incidentDate;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _incidentDate = picked;
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _incidentDate != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Claim submitted successfully")),
      );
    } else {
      if (_incidentDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select incident date")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.blueColor,
        title: Text(
          "Damage Claim",
          style: TextStyle(fontSize: 18.sp),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              /// HEADER CARD
              Container(
                width: 1.sw,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: ColorConstants.blueColor.withOpacity(.12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Submit Damage Claim",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Provide incident details to submit your claim.",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.h),

              /// INCIDENT DATE
              GestureDetector(
                onTap: _pickDate,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 18.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 22.sp,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        _incidentDate == null
                            ? "Select incident date"
                            : DateFormat("yyyy-MM-dd").format(_incidentDate!),
                        style: TextStyle(fontSize: 15.sp),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                style: TextStyle(fontSize: 15.sp),
                decoration: InputDecoration(
                  labelText: "Incident Description",
                  floatingLabelStyle: TextStyle(
                    color: ColorConstants.blueColor,
                  ),
                  hintText: "Describe what happened...",
                  labelStyle: TextStyle(fontSize: 14.sp),
                  hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide(
                      width: 1,
                      color: ColorConstants.blueColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.w,
                      color: ColorConstants.blueColor,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Description cannot be empty";
                  }
                  return null;
                },
              ),

              SizedBox(height: 32.h),

              /// SUBMIT BUTTON
              SizedBox(
                width: 1.sw,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.blueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Text(
                    "Submit Claim",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
