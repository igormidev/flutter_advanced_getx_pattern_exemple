import 'package:flutter_good_practices/data/interfaces/launch_url_interface.dart';
import 'package:url_launcher/url_launcher.dart';

class LauchUrlService implements ILauchUrlInterface {
  @override
  Future<void> lauchUrl(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      //TODO: implementar error ao não conseguir executar a URL
    }

    throw UnimplementedError();
  }
}
