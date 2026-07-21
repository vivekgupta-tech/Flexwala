import 'package:dio/dio.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/poster_model.dart';

abstract class PosterRemoteDataSource {
  Future<List<PosterModel>> getPosters();
}

class PosterRemoteDataSourceImpl implements PosterRemoteDataSource {
  final Dio client;

  PosterRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PosterModel>> getPosters() async {
    final response = await client.get(ApiEndpoints.getPosters);
    
    if (response.data['success'] == true) {
      final List data = response.data['data'];
      return data.map((json) => PosterModel.fromJson(json)).toList();
    } else {
      throw Exception(response.data['message'] ?? 'Failed to fetch posters');
    }
  }
}
