import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mikla_project/data/api/Api_client.dart';
import 'package:mikla_project/utils/app_constants.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URL);
  }
}
