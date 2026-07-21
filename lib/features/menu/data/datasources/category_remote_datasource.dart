import 'package:dio/dio.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final Dio client;

  CategoryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await client.get(ApiEndpoints.getCategories);
    
    if (response.data['success'] == true) {
      final List data = response.data['data'];
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    } else {
      throw Exception(response.data['message'] ?? 'Failed to fetch categories');
    }
  }
}
