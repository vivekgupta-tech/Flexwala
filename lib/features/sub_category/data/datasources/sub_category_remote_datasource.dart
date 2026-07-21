import 'package:dio/dio.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/sub_category_model.dart';

abstract class SubCategoryRemoteDataSource {
  Future<List<SubCategoryModel>> getSubCategories();
}

class SubCategoryRemoteDataSourceImpl implements SubCategoryRemoteDataSource {
  final Dio client;

  SubCategoryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<SubCategoryModel>> getSubCategories() async {
    final response = await client.get(ApiEndpoints.getSubCategories);
    
    if (response.data['success'] == true) {
      final List data = response.data['data'];
      return data.map((json) => SubCategoryModel.fromJson(json)).toList();
    } else {
      throw Exception(response.data['message'] ?? 'Failed to fetch sub-categories');
    }
  }
}
