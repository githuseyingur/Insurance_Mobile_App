import 'package:crenno_huseyin_gur/core/constants/color_constants.dart';
import 'package:crenno_huseyin_gur/feature/policy/cubit/policy_cubit.dart';
import 'package:crenno_huseyin_gur/feature/policy/cubit/policy_state.dart';
import 'package:crenno_huseyin_gur/feature/policy/widget/detail_row.dart';
import 'package:crenno_huseyin_gur/feature/policy/widget/info_card.dart';
import 'package:crenno_huseyin_gur/feature/policy/widget/section_title.dart';
import 'package:crenno_huseyin_gur/product/helper/number_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
              state.policyDetailState == PolicyDetailStates.loading
                  ? '...'
                  : state.policyDetail.type!,
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
      floatingActionButton: BlocBuilder<PolicyCubit, PolicyState>(
        builder: (context, state) {
          return SizedBox(
            width: 180.w,
            height: 50.h,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.blueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              onPressed: () {
                context.push('/claim_submission', extra: state.policyDetail.id);
              },
              icon: const Icon(Icons.report_problem),
              label: const Text("Submit Claim"),
            ),
          );
        },
      ),
      body: BlocBuilder<PolicyCubit, PolicyState>(
        builder: (context, state) {
          if (state.policyDetailState == PolicyDetailStates.loading) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorConstants.blueColor,
                strokeWidth: 2.4.w,
              ),
            );
          } else if (state.policyDetailState == PolicyDetailStates.completed) {
            return SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
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
                          child: infoCard(
                            "Coverage",
                            "\$${numberFormat(state.policyDetail.coverageAmount.toString())}",
                            Icons.shield,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: infoCard(
                            "Premium",
                            "\$${numberFormat(state.policyDetail.premium.toString())}",
                            Icons.payments,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 18.h),

                    sectionTitle("Policy Information"),

                    detailRow(
                        "Start Date",
                        DateFormat('dd MMM yyyy').format(
                            DateTime.parse(state.policyDetail.startDate!))),
                    detailRow(
                        "End Date",
                        DateFormat('dd MMM yyyy').format(
                            DateTime.parse(state.policyDetail.endDate!))),
                    detailRow(
                        "Payment Method", state.policyDetail.paymentMethod!),

                    detailRow("Risk Level", state.policyDetail.riskLevel!),

                    SizedBox(height: 18.h),

                    /// COVERAGE DETAILS
                    sectionTitle("Coverage Details"),

                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: List.generate(
                        state.policyDetail.coverageDetails!.length,
                        (index) => Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 6.h),
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
                    sectionTitle("Additional Information"),

                    detailRow(
                        "Location", state.policyDetail.metadata!.location!),
                    detailRow(
                        "Agent Code", state.policyDetail.metadata!.agentCode!),

                    SizedBox(height: 80.h),
                  ],
                ));
          } else if (state.policyDetailState == PolicyDetailStates.error) {
            return Text('Error: ${state.errorMessage}');
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
