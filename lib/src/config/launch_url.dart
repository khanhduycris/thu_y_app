import 'package:url_launcher/url_launcher.dart';

class LaunchUrl {
  LaunchUrl._();

  static url(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  static email(String email) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $email');
    }
  }

  static phone(String phone) async {
    final Uri uri = Uri(
      scheme: 'tel',
      path: '+84${phone.substring(1, phone.length)}',
    );
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  static sms(String phone, {String? content}) async {
    final Uri uri = Uri(
      scheme: 'sms',
      path: '+84339604406',
      queryParameters: content == null
          ? null
          : <String, String>{
              'body': Uri.encodeComponent(content),
            },
    );
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}
