import 'dart:developer';

import 'package:http/http.dart' as http;

class ApiProxyServices {
  static const _baseUrl = "http://tokokampus.test/api/";
  static Future<http.Response> postAsync(
    String url, {
    Map<String, String> headers,
    String body,
  }) async {
    try {
      // Execute pre-query protocols.
      Stopwatch _stopwatch = Stopwatch()..start();
      log("Started calling POST $url");

      // Execute main query protocols.
      final response = await http.post(
        _baseUrl + url,
        headers: headers,
        body: body,
      );

      // Execute post-query protocols.
      _stopwatch.stop();

      log("Completed! URL:\n(POST)$url\n"
          "Request Body:\n$body\n"
          "Response Time:\n${_stopwatch.elapsed.inMilliseconds} ms\n"
          "Status Code:\n${response?.statusCode}\n"
          "Response Body:\n${response?.body}\n"
          "Message:\n${response.reasonPhrase}");

      // Return the obtained response.
      return response;
    } catch (error, stackTrace) {
      rethrow;
    }
  }
}
