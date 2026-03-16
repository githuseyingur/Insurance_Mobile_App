import 'package:crenno_huseyin_gur/feature/policy/cubit/policy_state.dart';
import 'package:crenno_huseyin_gur/feature/policy/model/policy_detail_model.dart';
import 'package:crenno_huseyin_gur/feature/policy/model/policy_model.dart';
import 'package:crenno_huseyin_gur/feature/policy/service/i_policy_service.dart';
import 'package:crenno_huseyin_gur/feature/policy/service/policy_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PolicyCubit extends Cubit<PolicyState> {
  PolicyCubit() : super(PolicyState.initial()) {
    init();
  }

  final IPolicyService _policyService = PolicyService();
  TextEditingController searchController = TextEditingController();
  init() async {
    getPolicyList();
  }

  Future<void> getPolicyList() async {
    emit(state.copyWith(policyState: PolicyStates.loading));
    var result = await _policyService.getPolicyList();
    if (result != null) {
      final dataList = result as List<dynamic>;
      final policies = dataList
          .map((e) => PolicyModel.fromJson(e as Map<String, dynamic>))
          .toList();

      emit(
        state.copyWith(
          policyState: PolicyStates.completed,
          policyList: policies,
        ),
      );
    } else {
      emit(state.copyWith(
          policyState: PolicyStates.error,
          errorMessage: "Could not load policy list. Please try again."));
    }
  }

  Future<void> getPolicyDetail(int id) async {
    emit(state.copyWith(policyDetailState: PolicyDetailStates.loading));
    var result = await _policyService.getPolicyDetail(id);
    if (result != null) {
      emit(
        state.copyWith(
          policyDetailState: PolicyDetailStates.completed,
          policyDetail: PolicyDetailModel.fromJson(result),
        ),
      );
    } else {
      emit(state.copyWith(
          policyDetailState: PolicyDetailStates.error,
          errorMessage: "Could not load policy detail. Please try again."));
    }
  }

  void setPolicyId(int policyId) {
    emit(state.copyWith(selectedPolicyId: policyId));
  }
}
