import 'package:get/get.dart';

import '../../../core/theme/theme.dart';
import '../../../data/models/profile_models/profile_model/data.dart';
import '../../../data/models/profile_models/profile_model/profile_model.dart';
import '../../../data/services/app_services.dart';
import '../providers/profile_providers.dart';

class ProfileController extends GetxController {
  final AppServices appServices = Get.find<AppServices>();
  final ProfileProviders provider = Get.find<ProfileProviders>();
  Rx profileData = ProfileData().obs;

  @override
  onInit() {
    getProfile();
    super.onInit();
  }

  getProfile() async {
    // Ui.loadingDialog();
    ProfileModel? response = await provider.getProfile(appServices.userId!.value);
    if (response == null) {
      Ui.errorGetBar(message: 'Error has been occured, Please try again later');
    } else {
      if (response.status == 'success') {
        profileData.value = response.data!;
      } else {
        Ui.errorGetBar(message: 'Error has been occured, Please try again later');
      }
    }
  }
}
