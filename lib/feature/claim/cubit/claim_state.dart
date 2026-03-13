import 'package:equatable/equatable.dart';

class ClaimState extends Equatable {
  const ClaimState({
    required this.claimState,
    required this.errorMessage,
    required this.incidentDate,
  });
  factory ClaimState.initial() {
    return ClaimState(
      claimState: ClaimStates.initial,
      errorMessage: '',
      incidentDate: null,
    );
  }

  final ClaimStates claimState;
  final String errorMessage;
  final DateTime? incidentDate;

  @override
  List<Object?> get props => [
        claimState,
        errorMessage,
        incidentDate,
      ];

  ClaimState copyWith({
    ClaimStates? claimState,
    String? errorMessage,
    DateTime? incidentDate,
  }) {
    return ClaimState(
      claimState: claimState ?? this.claimState,
      errorMessage: errorMessage ?? this.errorMessage,
      incidentDate: incidentDate ?? this.incidentDate,
    );
  }
}

enum ClaimStates {
  initial,
  loading,
  completed,
  error,
}
