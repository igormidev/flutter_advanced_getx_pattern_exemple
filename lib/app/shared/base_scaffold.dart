import 'package:flutter/material.dart';
import 'package:flutter_good_practices/app/core/utils/extensions.dart';
import 'package:flutter_good_practices/app/core/values/colors.dart';
import 'package:flutter_good_practices/app/modules/apontamentos/apontamentos_controller.dart';
import 'package:flutter_good_practices/app/routes/app_pages.dart';
import 'package:flutter_good_practices/app/shared/custom_text.dart';
import 'package:get/get.dart';

class BaseScaffold extends StatelessWidget {
  final List<Widget> children;
  final Widget? floatingActionButton;

  final FloatingActionButtonLocation? floatingActionButtonLocation;
  const BaseScaffold({
    Key? key,
    required this.children,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.deepPurple),
      ),
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.only(left: 6.0.wp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.0.hp),
              boldText('Selecione a tela', size: 26),
              SizedBox(height: 0.5.hp),
              Divider(endIndent: 6.0.wp),
              SizedBox(height: 0.5.hp),
              TextButton(
                  onPressed: () {
                    Get.offNamed(Routes.APONTAMENTOSSCREEN);
                  },
                  child: boldText('Apontamentos')),
              TextButton(
                  onPressed: () {
                    Get.offNamed(Routes.PEDAGIOSSCREEN);
                  },
                  child: boldText('Pedágios')),
              TextButton(
                  onPressed: () {
                    Get.offNamed(Routes.SUPORTSCREEN);
                  },
                  child: boldText('Suporte')),
            ],
          ),
        ),
      ),
      backgroundColor: backGround,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0.wp),
        child: ListView(
          shrinkWrap: true,
          children: children,
        ),
      ),
    );
  }
}
