import 'package:mudawanat_aleibadat/src/core/utils/print.dart';
import 'package:url_launcher/url_launcher_string.dart';

Future<void> openURL(String url) async {
  if (await canLaunchUrlString(url)) {
    await launchUrlString(
      url,
      mode: LaunchMode.externalNonBrowserApplication,
    );
  } else {
    appPrint("cannot launch");
  }
}
