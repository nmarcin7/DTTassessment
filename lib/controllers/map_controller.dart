import 'package:url_launcher/url_launcher.dart';

class MapController {
  // This method launches the Google Maps application with specific geographic coordinates
  // (latitude and longitude).
  static Future<void> launchGoogleMaps(
      double latitude, double longitude) async {
    final url = Uri.parse('geo:$latitude,$longitude?q=$latitude,$longitude');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
