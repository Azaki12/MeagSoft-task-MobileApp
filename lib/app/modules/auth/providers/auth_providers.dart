import 'package:get/get.dart';

import '../../../data/models/auth_models/login_model.dart';
import '../../../data/models/auth_models/signup_models.dart';
import '../../../data/models/global_response_model.dart';
import '../../../data/providers/api_provider.dart';

class AuthProviders extends ApiProvider {
  Future<GlobalResponseModel?> postRegister(SignupRequestModel data) async {
    Response res = await post('users/signup', data.toJson());
    if (res.status.isServerError || res.status.connectionError) {
      return null;
    } else {
      return GlobalResponseModel.fromJson(res.body);
    }
  }

  Future<LoginResponseModel?> postLogin(String? email, String? password) async {
    Response res = await post('users/login', {'email': email, 'password': password});
    if (res.status.isServerError || res.status.connectionError) {
      return null;
    } else {
      return LoginResponseModel.fromJson(res.body);
    }
  }
}
