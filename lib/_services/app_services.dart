import 'package:dio/dio.dart';

import '../config.dart';
import 'req.dart';

class AppService {
  final Req req = Req();

  // Login
  Future<dynamic> login(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}api/login', data);
  }

  // Signup
  Future<dynamic> signup(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}api/signup', data);
  }

  // getotp
  Future<dynamic> getotp(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}api/getotp', data);
  }

  // verifyOtp
  Future<dynamic> verifyOtp(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}api/verifyOtp', data);
  }

  // verifyOtp
  Future<dynamic> newPassword(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}api/newPassword', data);
  }

  // ✅ Update User Profile (Edit Profile API)
  Future<dynamic> updateUserProfile(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}api/editUserProfile', data);
  }

  // ✅ Update User Profile (Edit Profile API)
  Future<dynamic> deleteUserProfile(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}api/deleteuser', data);
  }

  // ✅ Update User Profile (Edit Profile API)
  Future<dynamic> changepassord(Map<String, dynamic> data) async {
    return await req.post('${Configs.baseUrl}api/change-password', data);
  }

  // ✅ Update User Profile (Edit Profile API)
  Future<dynamic> gervideosbycatagory(String data) async {
    return await req.get('${Configs.baseUrl}api/videos/$data');
  }
  // Upload Image
  Future<dynamic> uploadImage(FormData data) async {
    return await req.postMultipart('${Configs.baseUrl}api/upload', data);
  }
}
