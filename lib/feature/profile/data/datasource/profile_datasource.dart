import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:home_decor/core/data/api_endpoints.dart';
import 'package:home_decor/feature/home/data/exception/exceptions.dart';
import 'package:home_decor/feature/profile/data/models/profile_model.dart';

abstract class ProfileDatasource {
  Future<ProfileModel> getUserDetailsFromAPI();
  Future<bool> setUserDetailsFromAPI(ProfileModel userProfile);
}

class ProfileDatasourceImpl implements ProfileDatasource {
  final Dio dio;

  ProfileDatasourceImpl({required this.dio});

  @override
  Future<ProfileModel> getUserDetailsFromAPI() async {
    log("Calling Top Profile Data Fetch API");
    await Future.delayed(const Duration(seconds: 3));
    final response = await dio.get(ApiEndpoints.profile);
    // print(response.statusCode);
    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      final responseBody = response.data;

      final profileDetails = ProfileModel.fromJson(responseBody['profile']);

      return profileDetails;
    }
  }

  @override
  Future<bool> setUserDetailsFromAPI(ProfileModel userProfile) async {
    log("Setting new User Profile Data From API");

    final response = await dio.put(
      ApiEndpoints.profile,
      data: userProfile.toJson(),
      options: Options(
        receiveTimeout: const Duration(seconds: 120),
        sendTimeout: const Duration(seconds: 120),
      ),
    );

    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      return true;
    }
  }
}
