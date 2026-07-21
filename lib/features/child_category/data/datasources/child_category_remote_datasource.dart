import 'package:dio/dio.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/child_category_model.dart';

abstract class ChildCategoryRemoteDataSource {
  Future<List<ChildCategoryModel>> getChildCategories();
}

class ChildCategoryRemoteDataSourceImpl implements ChildCategoryRemoteDataSource {
  final Dio client;

  ChildCategoryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ChildCategoryModel>> getChildCategories() async {
    final response = await client.get(ApiEndpoints.getChildCategories);
    
    if (response.data['success'] == true) {
      final List data = response.data['data'];
      return data.map((json) => ChildCategoryModel.fromJson(json)).toList();
    } else {
      throw Exception(response.data['message'] ?? 'Failed to fetch child categories');
    }
  }
}
