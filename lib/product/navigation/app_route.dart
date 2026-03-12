import 'package:crenno_huseyin_gur/feature/policy/cubit/policy_cubit.dart';
import 'package:crenno_huseyin_gur/feature/policy/view/policy_detail_view.dart';
import 'package:crenno_huseyin_gur/feature/policy/view/policy_list_view.dart';
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
            // Provider
            create: (context) => PolicyCubit(),
            child: const PolicyListView(),
          );
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'policy_detail',
            builder: (BuildContext context, GoRouterState state) {
              // Provider value

              return BlocProvider.value(
                value: (state.extra as Map<String, dynamic>)['policyCubit']
                    as PolicyCubit,
                child: PolicyDetailView(),
              );
            },
          ),
        ],
      ),
    ],
  );
}
