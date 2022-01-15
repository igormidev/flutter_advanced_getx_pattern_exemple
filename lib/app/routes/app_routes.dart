import 'package:flutter_good_practices/app/modules/apontamentos/apontamentos_binding.dart';
import 'package:flutter_good_practices/app/modules/apontamentos/views/abastecimento_view.dart';
import 'package:flutter_good_practices/app/modules/apontamentos/views/apontamentos_view.dart';
import 'package:flutter_good_practices/app/modules/apontamentos/views/details_view.dart';
import 'package:flutter_good_practices/app/modules/apontamentos/views/gasto_avulso_view.dart';
import 'package:flutter_good_practices/app/modules/apontamentos/views/pegadio_view.dart';
import 'package:flutter_good_practices/app/modules/rotas/rotas_binding.dart';
import 'package:flutter_good_practices/app/modules/rotas/views/rotas_view.dart';
import 'package:flutter_good_practices/app/modules/suport/suport_binding.dart';
import 'package:flutter_good_practices/app/modules/suport/suport_view.dart';
import 'package:flutter_good_practices/app/routes/app_pages.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.SUPORTSCREEN,
      page: () => const SuportView(),
      binding: SuportBinding(),
    ),
    GetPage(
      name: Routes.APONTAMENTOSSCREEN,
      page: () => const ApontamentosView(),
      binding: ApontamentosBinding(),
    ),
    GetPage(
      name: Routes.ROTASCONSULTA,
      page: () => const RotasConsultaView(),
      binding: RotasBinding(),
    ),
    GetPage(
      name: Routes.PEDAGIOSSCREEN,
      page: () => PedagioView(),
    ),
    GetPage(
      name: Routes.ABASTECIMENTOSSCREEN,
      page: () => AbastecimentoView(),
    ),
    GetPage(
      name: Routes.GASTOAVULSOSCREEN,
      page: () => GastoAvulsoView(),
    ),
  ];
}
