import 'package:assignment/src/constants/string_constants.dart';

///EndpointConstants - Endpoint Constants are defined here
class EndpointConstants {
  static const String version = '/v2/';
  static const String home =
      '${version}top-headlines?category=business&apiKey=${StringConstants.apiKey}';
}
