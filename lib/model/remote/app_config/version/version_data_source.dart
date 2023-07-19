import 'dart:convert';

import 'package:flutter_example_pages/core/constants.dart';
import 'package:flutter_example_pages/model/remote/app_config/version/version.dart';
import 'package:flutter_example_pages/model/remote/utils.dart';
import 'package:http/http.dart' as http;

Future<VersionResponse> getVersionRemoteDataSource({
  required VersionRequest getVersionRequest,
}) async {
  var url = Uri.parse(CloudflareWorkerUrl.getVersion);
  Map<String, String> headers = await restHeaders();
  var response = await http.post(
    url,
    body: json.encode(getVersionRequest.toJson()),
    headers: headers,
  );
  if (response.statusCode == 200) {
    return VersionResponse.fromJson(json.decode(response.body));
  } else {
    throw FormatException(
      (jsonDecode(response.body))["error"]["message"].toString(),
    );
  }
}
