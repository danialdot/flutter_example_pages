import 'package:flutter_example_pages/model/remote/core.dart';

class VersionRequest {
  final String version;

  VersionRequest({
    required this.version,
  });

  Map<String, dynamic> toJson() => {
        "version": version,
      };
}

class VersionResponse extends ResponseBodyCore {
  final VersionResponseResult result;

  VersionResponse({
    required super.status,
    required super.error,
    required super.timestamp,
    required this.result,
  });

  factory VersionResponse.fromJson(Map<String, dynamic> json) {
    ResponseBodyCore core = ResponseBodyCore.fromJson(json);
    return VersionResponse(
      status: core.status,
      error: core.error,
      timestamp: core.timestamp,
      result: VersionResponseResult.fromJson(json["result"]),
    );
  }
}

class VersionResponseResult {
  final List<VersionDetail> versions;
  final bool updateIsNeeded;

  VersionResponseResult({
    required this.versions,
    required this.updateIsNeeded,
  });

  factory VersionResponseResult.fromJson(Map<String, dynamic> json) {
    final list = json["versions"] as List;
    final resultList = (list).map((e) => VersionDetail.fromJson(e)).toList();

    return VersionResponseResult(updateIsNeeded: json["updateIsNeeded"], versions: resultList);
  }
}

class VersionDetail {
  final String text;
  final String version;
  String? image;
  final bool forced;

  VersionDetail({
    required this.text,
    required this.version,
    required this.image,
    required this.forced,
  });

  factory VersionDetail.fromJson(Map<String, dynamic> json) => VersionDetail(
        text: json["text"].toString(),
        version: json["version"].toString(),
        image: (json["image"] != null) ? json["image"].toString() : null,
        forced: json["forced"],
      );
}
