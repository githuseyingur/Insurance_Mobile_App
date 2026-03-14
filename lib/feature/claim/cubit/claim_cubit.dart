import 'package:crenno_huseyin_gur/feature/claim/cubit/claim_state.dart';
import 'package:crenno_huseyin_gur/feature/claim/service/claim_service.dart';
import 'package:crenno_huseyin_gur/feature/claim/service/i_claim_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClaimCubit extends Cubit<ClaimState> {
  ClaimCubit() : super(ClaimState.initial()) {
    init();
  }
  final TextEditingController descriptionController = TextEditingController();

  final IClaimService _claimService = ClaimService();
  init() async {}

  Future<void> setIncidentDate(DateTime incidentDate) async {
    emit(state.copyWith(incidentDate: incidentDate));
  }

  Future<void> submitClaim(
      int policyId, String dateTime, String description) async {
    emit(state.copyWith(claimState: ClaimStates.loading));
    var result = _claimService.submitClaim(policyId, dateTime, description);

    if (result != null) {
      emit(
        state.copyWith(
          claimState: ClaimStates.completed,
        ),
      );
    } else {
      emit(state.copyWith(
          claimState: ClaimStates.error,
          errorMessage: "Could not load policy list. Please try again."));
    }
  }
}
