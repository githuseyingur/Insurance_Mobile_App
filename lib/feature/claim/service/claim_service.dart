import 'dart:io';
import 'package:crenno_huseyin_gur/feature/claim/service/i_claim_service.dart';
import 'package:crenno_huseyin_gur/product/initial/config/app_environment.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ClaimService extends IClaimService {
  final _dio = Dio();

  @override
  Future<dynamic> submitClaim(
    int policyId,
    String date,
    String description,
  ) async {
    try {
      final response =
          await _dio.post(AppEnvironmentItems.policyUrl.value, data: {
        'policyId': policyId,
        'incidentDate': date,
        'description': description,
      });
      if (response.statusCode == HttpStatus.ok) {
        return response.data;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
