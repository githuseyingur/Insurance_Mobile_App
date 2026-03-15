import 'package:crenno_huseyin_gur/core/constants/color_constants.dart';
import 'package:crenno_huseyin_gur/feature/claim/cubit/claim_cubit.dart';
import 'package:crenno_huseyin_gur/feature/claim/cubit/claim_state.dart';
import 'package:crenno_huseyin_gur/product/helper/snackbar.dart';
import 'package:crenno_huseyin_gur/product/components/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ClaimSubmissionView extends StatelessWidget {
  ClaimSubmissionView({super.key, required this.policyId});
  final int policyId;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Damage Claim",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w900,
                color: Colors.black,
                letterSpacing: -0.5,
              ),
            ),
            Text(
              "Report a new incident",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black45,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: IconButton(
              icon: Icon(
                Icons.help_outline_rounded,
                size: 24.sp,
                color: ColorConstants.blueColor,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: 1.sw,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: ColorConstants.blueColor.withAlpha(24),
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                  color: ColorConstants.blueColor.withAlpha(8),
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
              GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2015),
                    lastDate: DateTime.now(),
                  );

                  if (picked != null) {
                    context.read<ClaimCubit>().setIncidentDate(picked);
                  }
                },
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
                      BlocBuilder<ClaimCubit, ClaimState>(
                        builder: (context, state) {
                          return Text(
                            state.incidentDate == null
                                ? "Select incident date"
                                : DateFormat("yyyy-MM-dd")
                                    .format(state.incidentDate!),
                            style: TextStyle(fontSize: 15.sp),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              TextFormField(
                controller: context.read<ClaimCubit>().descriptionController,
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
              SizedBox(
                width: 1.sw,
                height: 52.h,
                child: BlocConsumer<ClaimCubit, ClaimState>(
                  listenWhen: (previous, current) =>
                      previous.claimState != current.claimState,
                  listener: (context, state) {
                    if (state.claimState == ClaimStates.completed) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(getSnackBar(
                        textColor: Colors.white,
                        bgColor: ColorConstants.greenColor,
                        text: "Claim Submitted Successfuly!",
                      ));
                    } else if (state.claimState == ClaimStates.error) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(getSnackBar(
                        textColor: Colors.white,
                        bgColor: Colors.red,
                        text: state.errorMessage,
                      ));
                    }
                  },
                  builder: (context, state) {
                    return SubmitButton(
                      onPressed: state.claimState == ClaimStates.loading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate() &&
                                  state.incidentDate != null) {
                                context.read<ClaimCubit>().submitClaim(
                                      policyId,
                                      state.incidentDate.toString(),
                                      context
                                          .read<ClaimCubit>()
                                          .descriptionController
                                          .text,
                                    );
                              } else {
                                if (state.incidentDate == null) {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(getSnackBar(
                                    textColor: Colors.white,
                                    bgColor: ColorConstants.orangeColor,
                                    text: "Please select incident date",
                                  ));
                                }
                              }
                            },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
