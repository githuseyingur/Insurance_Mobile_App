import 'dart:convert';
import 'dart:io';
import 'package:crenno_huseyin_gur/feature/policy/service/i_policy_service.dart';
import 'package:crenno_huseyin_gur/product/initial/config/app_environment.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PolicyService extends IPolicyService {
  final _dio = Dio();
  @override
  Future<dynamic> getPolicyList() async {
    try {
      final response =
          await _dio.get('${AppEnvironmentItems.policyUrl.value}/policies');
      if (response.statusCode == HttpStatus.ok) {
        return jsonDecode(response.data as String);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<dynamic> getPolicyDetail(int id) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      final response = await _dio.get(AppEnvironmentItems.policyUrl.value,
          queryParameters: {'id': id});

      if (response.statusCode == HttpStatus.ok) {
        return jsonDecode(response.data as String);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
