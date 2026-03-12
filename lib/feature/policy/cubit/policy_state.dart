import 'package:crenno_huseyin_gur/feature/policy/model/policy_detail_model.dart';
import 'package:crenno_huseyin_gur/feature/policy/model/policy_model.dart';
import 'package:equatable/equatable.dart';

class PolicyState extends Equatable {
  const PolicyState({
    required this.policyState,
    required this.policyDetailState,
    required this.errorMessage,
    required this.policyList,
    required this.policyDetail,
  });
  factory PolicyState.initial() {
    return PolicyState(
      policyState: PolicyStates.initial,
      policyDetailState: PolicyDetailStates.initial,
      errorMessage: '',
      policyList: [],
      policyDetail: PolicyDetailModel(),
    );
  }

  final PolicyStates policyState;
  final PolicyDetailStates policyDetailState;

  final String errorMessage;
  final List<PolicyModel> policyList;
  final PolicyDetailModel policyDetail;

  @override
  List<Object?> get props => [
        policyState,
        policyDetailState,
        errorMessage,
        policyList,
        policyDetail,
      ];

  PolicyState copyWith({
    PolicyStates? policyState,
    PolicyDetailStates? policyDetailState,
    String? errorMessage,
    List<PolicyModel>? policyList,
    PolicyDetailModel? policyDetail,
  }) {
    return PolicyState(
      policyState: policyState ?? this.policyState,
      policyDetailState: policyDetailState ?? this.policyDetailState,
      errorMessage: errorMessage ?? this.errorMessage,
      policyList: policyList ?? this.policyList,
      policyDetail: policyDetail ?? this.policyDetail,
    );
  }
}

enum PolicyStates {
  initial,
  loading,
  completed,
  error,
}

enum PolicyDetailStates {
  initial,
  loading,
  completed,
  error,
}
