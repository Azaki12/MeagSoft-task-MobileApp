import 'package:get/get.dart';
import 'package:test_app/app/data/models/profile_models/profile_model/profile_model.dart';

import '../../../data/providers/api_provider.dart';

class ProfileProviders extends ApiProvider {
  // NOTE :- Get Parent Profile
  Future<ProfileModel?> getProfile(String id) async {
    Response res = await get('users/$id');
    if (res.status.isServerError || res.status.connectionError) {
      return null;
    } else {
      return ProfileModel.fromJson(res.body);
    }
  }
}
