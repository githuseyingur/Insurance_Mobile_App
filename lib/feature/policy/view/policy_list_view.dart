import 'package:crenno_huseyin_gur/core/constants/color_constants.dart';
import 'package:crenno_huseyin_gur/feature/policy/cubit/policy_cubit.dart';
import 'package:crenno_huseyin_gur/feature/policy/cubit/policy_state.dart';
import 'package:crenno_huseyin_gur/product/helper/number_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class PolicyListView extends StatelessWidget {
  const PolicyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        toolbarHeight: 70.h,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 16.w,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "My Policies",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_none_rounded,
              size: 22.sp,
              color: Colors.black87,
            ),
            onPressed: () {},
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                radius: 18.r,
                backgroundColor: ColorConstants.blueColor,
                child: Text(
                  "HG",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          BlocBuilder<PolicyCubit, PolicyState>(
            buildWhen: (previous, current) =>
                previous.policyState != current.policyState,
            builder: (context, state) {
              if (state.policyState == PolicyStates.loading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.blueColor,
                    strokeWidth: 2.4.w,
                  ),
                );
              } else if (state.policyState == PolicyStates.completed) {
                return ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: state.policyList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        context
                            .read<PolicyCubit>()
                            .getPolicyDetail(state.policyList[index].id!);
                        context.push('/policy_detail', extra: {
                          'policyCubit': context.read<PolicyCubit>()
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 14.h),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: ColorConstants.blueColor.withOpacity(.1),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(
                                _getPolicyIcon(state.policyList[index].type!),
                                color: ColorConstants.blueColor,
                                size: 28.sp,
                              ),
                            ),
                            SizedBox(width: 14.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// TYPE
                                  Text(
                                    state.policyList[index].type!,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  SizedBox(height: 4.h),

                                  /// POLICY NUMBER
                                  Text(
                                    "Policy No: ${state.policyList[index].policyNumber}",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey[600],
                                    ),
                                  ),

                                  SizedBox(height: 8.h),

                                  /// COVERAGE
                                  Text(
                                    "Coverage: \$${numberFormat(state.policyList[index].coverageAmount.toString())}",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),

                                  SizedBox(height: 4.h),

                                  /// DATE RANGE
                                  Text(
                                    "${DateFormat('dd MMM yyyy').format(DateTime.parse(state.policyList[index].startDate!))} - "
                                    "${DateFormat('dd MMM yyyy').format(DateTime.parse(state.policyList[index].endDate!))}",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                /// STATUS
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(.1),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    state.policyList[index].status!,
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ),

                                SizedBox(height: 18.h),

                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16.sp,
                                  color: Colors.grey,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text('Error: ${state.errorMessage}'),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  IconData _getPolicyIcon(String type) {
    switch (type) {
      case "Vehicle":
        return Icons.directions_car;
      case "Health":
        return Icons.favorite;
      case "Home":
        return Icons.home;
      default:
        return Icons.policy;
    }
  }
}
