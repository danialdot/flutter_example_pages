class ResponseError {
  final String code;
  final String message;

  ResponseError({
    required this.code,
    required this.message,
  });

  factory ResponseError.fromJson(Map<String, dynamic> json) => ResponseError(
        code: json["code"].toString(),
        message: json["message"].toString(),
      );
}

class ResponseBodyCore {
   String status;
   ResponseError error;
   DateTime timestamp;

  ResponseBodyCore({
    required this.status,
    required this.error,
    required this.timestamp,
  });

  factory ResponseBodyCore.fromJson(Map<String, dynamic> json) =>
      ResponseBodyCore(
        status: json["status"].toString(),
        error: ResponseError.fromJson(json["error"]),
        timestamp: DateTime.fromMillisecondsSinceEpoch(json["timestamp"]),
      );
}
