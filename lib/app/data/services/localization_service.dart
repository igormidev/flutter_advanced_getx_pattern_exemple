import 'package:flutter_good_practices/app/data/interfaces/localization_interface.dart';
import 'package:geolocator/geolocator.dart';

class LocalizationService implements ILocalizationInterface {
  // Determina a posição atual do usuário
  // When the location services are not enabled or permissions
  // Quando os serviços de localização não estão habilitados ou permissões
  // são negadas, o `Future` retornará um erro.
  @override
  Future<Map<String, double>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Checa se o serviço está habilitado.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      //Os serviços de localização não estão habilitados não
      //continue acessando a posição e solicite aos usuários
      //do App que habilitem os serviços de localização.
      return Future.error('Location services are disabled.');
      // Os serviços de localização não estão ativados, não continue
      // acessar a posição e solicitar aos usuários do
      // App to enable the location services.;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // As permissões foram negadas, da próxima vez
        // você pode tentar solicitar permissões novamente
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // As permissões são negadas para sempre,
      // trate-as adequadamente exibindo para o usuário
      // que ele precisa liberar o acesso da localização,
      // agora pelas configurações.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // Se chegou até aqui, as permissões foram garantidas e você
    // pode accesar a localização do usuário.

    final pos = await Geolocator.getCurrentPosition();
    return {
      'longitude': pos.longitude,
      'latitude': pos.latitude,
    };
  }
}
