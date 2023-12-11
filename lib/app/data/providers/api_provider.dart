import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

import '../../core/utils/constants.dart';
import '../services/app_services.dart';

class ApiProvider extends GetConnect {
  final AppServices appServices = Get.find<AppServices>();

  @override
  void onInit() {
    super.onInit();
    Get.log('tokkkkkkeeeeeeen :::: ${appServices.accessToken.value}');
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.timeout = const Duration(seconds: 200);
    var headers = {'Authorization': 'Bearer ${appServices.accessToken.value}'};
    httpClient.addAuthenticator<dynamic>((request) async {
      request.headers.addAll(headers);
      requestInterceptor(request);
      return request;
    });
  }

  Future<Request> requestInterceptor(Request request) async {
    return request;
  }
}
