import 'package:http/http.dart';
import 'package:kampusku/utils/models/user_model.dart';
import 'package:kampusku/utils/repositories/api_proxy_services.dart';

class AuthRepository {
  static Future<UserResponse> checkLogin(UserRequest userRequest) async {
    try {
      Response response = await ApiProxyServices.postAsync("login",
          body: userRequest.toRawJson());
      return UserResponse.fromRawJson(response.body);
    } catch (error) {
      print(error);
    }
  }
}
