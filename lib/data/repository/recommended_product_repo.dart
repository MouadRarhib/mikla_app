import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mikla_project/data/api/Api_client.dart';
import 'package:mikla_project/utils/app_constants.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async {
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URL);
  }
}
