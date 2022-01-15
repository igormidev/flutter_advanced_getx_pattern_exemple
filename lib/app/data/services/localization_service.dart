import 'package:flutter_good_practices/app/core/exceptions/constants_handling.dart';
import 'package:flutter_good_practices/app/core/exceptions/snackbar_error.dart';
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
    // Checa se a localização está ligada no dispositivo
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    try {
      if (!serviceEnabled) {
        //Os serviços de localização não estão habilitados não
        //continue acessando a posição e solicite aos usuários
        //do App que habilitem os serviços de localização.
        throw 'Os serviços de localização está desativado.';
        // Os serviços de localização não estão ativados, não continue
        // acessar a posição e solicitar aos usuários do
        // App to enable the location services.;
      }
    } catch (e) {
      showError(
        error: 'Ligue a localização:',
        details: e.toString(),
      );
      return errorGettingMap;
    }

    // Aqui checa se a permissão foi permitida
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      // As permissões são negadas para sempre,
      // trate-as adequadamente exibindo para o usuário
      // que ele precisa liberar o acesso da localização,
      // agora pelas configurações.
      try {
        throw 'As permissões foram permanentemente negadas. Libere a localização '
            'nas configurações do celular';
      } catch (e) {
        showError(
          error: 'Vá nas configurações e libere a localização pro aplicativo:',
          details: e.toString(),
        );
        return errorGettingMap;
      }
    }

    try {
      if (permission == LocationPermission.denied) {
        //Peça uma segunda vez, se não permitir mostre o erro
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          // As permissões foram negadas, da próxima vez
          // você pode tentar solicitar permissões novamente
          throw 'Permissões de localização foram negadas';
        }
      }
    } catch (e) {
      showError(
        error: 'Ative a localização pro aplicativo:',
        details: e.toString(),
      );
      return errorGettingMap;
    }

    // Se chegou até aqui, as permissões foram garantidas e você
    // pode accesar a localização do usuário.
    try {
      final pos = await Geolocator.getCurrentPosition();
      return {
        'longitude': pos.longitude,
        'latitude': pos.latitude,
      };
    } catch (e) {
      showError(
        error: 'Erro ao buscar localização:',
        details: e.toString(),
      );
      return errorGettingMap;
    }
  }
}
