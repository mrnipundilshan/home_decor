import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:home_decor/core/data/api_endpoints.dart';
import 'package:home_decor/feature/home/data/exception/exceptions.dart';
import 'package:home_decor/feature/profile/data/models/profile_model.dart';

abstract class ProfileDatasource {
  Future<ProfileModel> getUserDetailsFromAPI();
}

class ProfileDatasourceImpl implements ProfileDatasource {
  final Dio dio;

  ProfileDatasourceImpl({required this.dio});

  // my name is

  @override
  Future<ProfileModel> getUserDetailsFromAPI() async {
    log("Calling Top Profile Data Fetch API");
    await Future.delayed(const Duration(seconds: 3));
    final response = await dio.get(ApiEndpoints.profile);
    print(response);
    if (response.statusCode != 200) {
      // print(response.statusCode);
      throw ServerException();
    } else {
      // final responseBody = json.decode(response.data);
      final responseBody = response.data;
      // print(responseBody);
      final profileDetails = ProfileModel.fromJson(responseBody);
      print(responseBody);

      return profileDetails;
    }
  }
}
