import 'package:url_launcher/url_launcher.dart';

class UrlController {
  final websiteUrl = Uri.parse('https://www.d-tt.nl/');
  //This method opens a specified website URL in the device's default web browser.
  Future<void> openUrl() async {
    try {
      await launchUrl(websiteUrl);
    } catch (e) {
      print(e);
    }
  }
}
