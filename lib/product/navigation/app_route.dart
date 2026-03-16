import 'package:crenno_huseyin_gur/feature/claim/cubit/claim_cubit.dart';
import 'package:crenno_huseyin_gur/feature/policy/cubit/policy_cubit.dart';
import 'package:crenno_huseyin_gur/feature/claim/view/claim_submission_view.dart';
import 'package:crenno_huseyin_gur/feature/policy/view/policy_detail_view.dart';
import 'package:crenno_huseyin_gur/feature/policy/view/policy_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (context) => PolicyCubit(),
            child: const PolicyView(),
          );
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'policy_detail',
            builder: (BuildContext context, GoRouterState state) {
              return BlocProvider.value(
                value: (state.extra as Map<String, dynamic>)['policyCubit']
                    as PolicyCubit,
                child: PolicyDetailView(),
              );
            },
          ),
          GoRoute(
            path: 'claim_submission',
            builder: (BuildContext context, GoRouterState state) {
              return BlocProvider(
                create: (context) => ClaimCubit(),
                child: ClaimSubmissionView(
                  policyId: state.extra as int,
                ),
              );
            },
          ),
        ],
      ),
    ],
  );
}
