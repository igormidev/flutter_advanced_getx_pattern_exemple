import 'package:flutter_good_practices/app/core/exceptions/snackbar_error.dart';
import 'package:flutter_good_practices/app/data/interfaces/launch_url_interface.dart';
import 'package:url_launcher/url_launcher.dart';

class LauchUrlService implements ILauchUrlInterface {
  @override
  Future<void> lauchUrl(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Url não consegiu ser lançada';
      }
    } catch (e) {
      showError(
          error: 'Erro desconhecido ao enviar mensagem...',
          details: e.toString());
    }
  }
}
