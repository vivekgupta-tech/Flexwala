import 'package:dio/dio.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/banner_model.dart';

abstract class BannerRemoteDataSource {
  Future<BannerModel> getBannerDetails(String categoryId, String childId);
}

class BannerRemoteDataSourceImpl implements BannerRemoteDataSource {
  final Dio client;

  BannerRemoteDataSourceImpl({required this.client});

  @override
  Future<BannerModel> getBannerDetails(String categoryId, String childId) async {
    final formData = FormData.fromMap({
      'cate_id': categoryId,
      'child_id': childId,
    });

    final response = await client.post(
      ApiEndpoints.getBannerDetails,
      data: formData,
    );

    if (response.data['success'] == true) {
      return BannerModel.fromJson(response.data['data']);
    } else {
      throw Exception(response.data['message'] ?? 'Failed to fetch banners');
    }
  }
}
