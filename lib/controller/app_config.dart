import 'package:flutter_example_pages/model/remote/app_config/version/version.dart';
import 'package:flutter_example_pages/model/remote/app_config/version/version_data_source.dart';
import 'package:get/get.dart';

class AppConfigController extends GetxController {
  Future<VersionResponse?> getVersion({
    required String version,
  }) async {
    try {
      var response = await getVersionRemoteDataSource(
        getVersionRequest: VersionRequest(
          version: version,
        ),
      );
      return response;
    } on FormatException {
      return null;
    }
  }
}
