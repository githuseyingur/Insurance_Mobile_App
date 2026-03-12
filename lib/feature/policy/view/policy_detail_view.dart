import 'package:crenno_huseyin_gur/core/constants/color_constants.dart';
import 'package:crenno_huseyin_gur/feature/policy/cubit/policy_cubit.dart';
import 'package:crenno_huseyin_gur/feature/policy/cubit/policy_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class PolicyDetailView extends StatelessWidget {
  const PolicyDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: BlocBuilder<PolicyCubit, PolicyState>(
          builder: (context, state) {
            return Text(
              state.policyDetail.type!,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            );
          },
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      floatingActionButton: SizedBox(
        width: 180.w,
        height: 50.h,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstants.blueColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
          ),
          onPressed: () {},
          icon: const Icon(Icons.report_problem),
          label: const Text("Submit Claim"),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: BlocBuilder<PolicyCubit, PolicyState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER CARD
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff4A7DFF), Color(0xff6EA8FF)],
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.policyDetail.policyNumber!,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13.sp,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.2),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              state.policyDetail.status!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        state.policyDetail.holderName!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        state.policyDetail.metadata!.targetObject!,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 18.h),

                /// COVERAGE INFO
                Row(
                  children: [
                    Expanded(
                      child: _infoCard(
                        "Coverage",
                        "\$${state.policyDetail.coverageAmount}",
                        Icons.shield,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _infoCard(
                        "Premium",
                        "\$${state.policyDetail.premium}",
                        Icons.payments,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 18.h),

                /// POLICY INFO
                _sectionTitle("Policy Information"),

                _detailRow(
                    "Start Date",
                    DateFormat('dd MMM yyyy')
                        .format(DateTime.parse(state.policyDetail.startDate!))),

                _detailRow(
                    "End Date",
                    DateFormat('dd MMM yyyy')
                        .format(DateTime.parse(state.policyDetail.endDate!))),

                _detailRow("Payment Method", state.policyDetail.paymentMethod!),

                _detailRow("Risk Level", state.policyDetail.riskLevel!),

                SizedBox(height: 18.h),

                /// COVERAGE DETAILS
                _sectionTitle("Coverage Details"),

                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: List.generate(
                    state.policyDetail.coverageDetails!.length,
                    (index) => Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: ColorConstants.blueColor.withOpacity(.1),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        state.policyDetail.coverageDetails![index],
                        style: TextStyle(
                          color: ColorConstants.blueColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 18.h),

                /// METADATA
                _sectionTitle("Additional Information"),

                _detailRow("Location", state.policyDetail.metadata!.location!),
                _detailRow(
                    "Agent Code", state.policyDetail.metadata!.agentCode!),

                SizedBox(height: 80.h),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _infoCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: ColorConstants.blueColor, size: 26.sp),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  Widget _detailRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey[700],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
