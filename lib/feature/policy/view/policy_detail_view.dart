import 'package:crenno_huseyin_gur/core/constants/color_constants.dart';
import 'package:crenno_huseyin_gur/feature/policy/cubit/policy_cubit.dart';
import 'package:crenno_huseyin_gur/feature/policy/cubit/policy_state.dart';
import 'package:crenno_huseyin_gur/feature/policy/widget/detail_row.dart';
import 'package:crenno_huseyin_gur/feature/policy/widget/detail_section.dart';
import 'package:crenno_huseyin_gur/feature/policy/widget/info_card.dart';
import 'package:crenno_huseyin_gur/product/components/submit_button.dart';
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
        toolbarHeight: 80.h,
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: false,
        titleSpacing: 0,
        title: BlocBuilder<PolicyCubit, PolicyState>(
          builder: (context, state) {
            final isLoading =
                state.policyDetailState == PolicyDetailStates.loading;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isLoading ? 'Loading...' : (state.policyDetail.type ?? ""),
                  style: TextStyle(
                    fontSize: isLoading ? 16.sp : 22.sp,
                    fontWeight: isLoading ? FontWeight.w400 : FontWeight.w900,
                    color: Colors.black,
                    letterSpacing: -0.5,
                  ),
                ),
                if (!isLoading)
                  Text(
                    "Policy Details & Coverage",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black45,
                    ),
                  ),
              ],
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.ios_share_rounded,
              size: 22.sp,
              color: ColorConstants.blueColor,
            ),
            onPressed: () {},
          ),
          SizedBox(width: 8.w),
        ],
      ),
      bottomNavigationBar: BlocBuilder<PolicyCubit, PolicyState>(
        builder: (context, state) {
          // Veri yüklenirken veya hata durumunda butonu göstermemek isteyebilirsin
          if (state.policyDetailState != PolicyDetailStates.completed) {
            return const SizedBox.shrink();
          }

          return Container(
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 32.h),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(16),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SubmitButton(
              onPressed: () {
                context.push('/claim_submission', extra: state.policyDetail.id);
              },
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
                strokeWidth: 3.w, // Biraz daha belirgin
              ),
            );
          } else if (state.policyDetailState == PolicyDetailStates.completed) {
            return SingleChildScrollView(
              physics:
                  const BouncingScrollPhysics(), // Daha premium bir kaydırma hissi
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// HEADER CARD (Daha derinlikli ve soft bir görünüm)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24.w), // Biraz daha geniş padding
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xff4A7DFF),
                          Color(0xff335CCF)
                        ], // Daha doygun bir gradyan
                      ),
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff4A7DFF).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.policyDetail.policyNumber!.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12.sp,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.15),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: Colors.white24),
                              ),
                              child: Text(
                                state.policyDetail.status!.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          state.policyDetail.holderName!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w800, // Daha kalın başlık
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Icon(Icons.location_on_rounded,
                                color: Colors.white70, size: 14.sp),
                            SizedBox(width: 4.w),
                            Text(
                              state.policyDetail.metadata!.targetObject!,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  /// COVERAGE INFO (Yan yana kartlar)
                  Row(
                    children: [
                      Expanded(
                        child: InfoCardWidget(
                          title: "Coverage",
                          value:
                              "\$${numberFormat(state.policyDetail.coverageAmount.toString())}",
                          icon: Icons.shield_outlined,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: InfoCardWidget(
                          title: "Premium",
                          value:
                              "\$${numberFormat(state.policyDetail.premium.toString())}",
                          icon: Icons.account_balance_wallet_outlined,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 28.h),

                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Text(
                      "Policy Information",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  DetailSectionWidget(children: [
                    DetailRowWidget(
                        title: "Start Date",
                        value: DateFormat('dd MMM yyyy').format(
                            DateTime.parse(state.policyDetail.startDate!))),
                    DetailRowWidget(
                        title: "End Date",
                        value: DateFormat('dd MMM yyyy').format(
                            DateTime.parse(state.policyDetail.endDate!))),
                    DetailRowWidget(
                        title: "Payment Method",
                        value: state.policyDetail.paymentMethod!),
                    DetailRowWidget(
                      title: "Risk Level",
                      value: state.policyDetail.riskLevel!,
                    ),
                  ]),

                  SizedBox(height: 28.h),

                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Text(
                      "Coverage Details",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Wrap(
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children: state.policyDetail.coverageDetails!
                        .map((detail) => Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0.024.sw, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                    color:
                                        ColorConstants.blueColor.withAlpha(80)),
                              ),
                              child: Text(
                                detail,
                                style: TextStyle(
                                  color: ColorConstants.blueColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ))
                        .toList(),
                  ),

                  SizedBox(height: 28.h),

                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Text(
                      "Additional Information",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  DetailSectionWidget(children: [
                    DetailRowWidget(
                        title: "Location",
                        value: state.policyDetail.metadata!.location!),
                    DetailRowWidget(
                      title: "Agent Code",
                      value: state.policyDetail.metadata!.agentCode!,
                    ),
                  ]),

                  SizedBox(height: 100.h),
                ],
              ),
            );
          } else if (state.policyDetailState == PolicyDetailStates.error) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
