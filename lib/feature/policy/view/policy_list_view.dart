import 'package:crenno_huseyin_gur/core/constants/color_constants.dart';
import 'package:crenno_huseyin_gur/feature/policy/cubit/policy_cubit.dart';
import 'package:crenno_huseyin_gur/feature/policy/cubit/policy_state.dart';
import 'package:crenno_huseyin_gur/feature/policy/widget/profile_menu_tile.dart';
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
        toolbarHeight: 80.h,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 20.w,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "My Policies",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w900,
                color: Colors.black,
                letterSpacing: -0.5,
              ),
            ),
            Text(
              "Manage your active coverage",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black45,
              ),
            ),
          ],
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.notifications_none_rounded,
                  size: 26.sp,
                  color: Colors.black87,
                ),
                onPressed: () {},
              ),
              Positioned(
                top: 20.h,
                right: 12.w,
                child: Container(
                  width: 8.r,
                  height: 8.r,
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 8.w),
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 20.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 40.w,
                            height: 4.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          SizedBox(height: 24.h),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 35.r,
                                backgroundColor: ColorConstants.blueColor,
                                child: Text(
                                  "HG",
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hüseyin Gür",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "huseyin@example.com",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 32.h),
                          ProfileMenuTile(
                            icon: Icons.person_outline_rounded,
                            title: "Account Settings",
                            onTap: () {},
                          ),
                          ProfileMenuTile(
                            icon: Icons.history_rounded,
                            title: "Policy History",
                            onTap: () {},
                          ),
                          ProfileMenuTile(
                            icon: Icons.security_rounded,
                            title: "Privacy & Security",
                            onTap: () {},
                          ),
                          Divider(height: 32.h, color: Colors.grey.shade100),
                          ProfileMenuTile(
                            icon: Icons.logout_rounded,
                            title: "Sign Out",
                            color: Colors.redAccent,
                            onTap: () {},
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstants.blueColor.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: ColorConstants.blueColor,
                    child: Text(
                      "HG",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
                                  Text(
                                    state.policyList[index].type!,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "Policy No: ${state.policyList[index].policyNumber}",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    "Coverage: \$${numberFormat(state.policyList[index].coverageAmount.toString())}",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
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
