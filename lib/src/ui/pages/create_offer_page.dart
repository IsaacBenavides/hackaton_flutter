import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hackaton_flutter/src/controllers/create_offer_controller.dart';
import 'package:hackaton_flutter/src/data/uses_cases/base.dart';
import 'package:hackaton_flutter/src/ui/routes/routes_name.dart';
import 'package:hackaton_flutter/src/ui/widgets/app_bar.dart';
import 'package:hackaton_flutter/src/ui/widgets/custom_text.dart';
import 'package:hackaton_flutter/src/ui/widgets/info_modal.dart';
import 'package:hackaton_flutter/src/ui/widgets/loading.dart';
import 'package:hackaton_flutter/src/ui/widgets/text_form_field.dart';
import 'package:hackaton_flutter/src/utils/responsive.dart';
import 'package:provider/provider.dart';

class CreateOfferPage extends StatefulWidget {
  const CreateOfferPage({Key? key}) : super(key: key);

  @override
  State<CreateOfferPage> createState() => _CreateOfferPageState();
}

class _CreateOfferPageState extends State<CreateOfferPage> {
  _createOffer(BuildContext context) async {
    final CreateOfferController createOfferController =
        Provider.of(context, listen: false);
    openLoader(context);
    try {
      await createOfferController.createOffer();
      // ignore: use_build_context_synchronously
      openInfoModal(context, "Oferta creada", onTap: () {
        closeInfoModal(context);
        Navigator.of(context)
            .pushNamedAndRemoveUntil(RoutesName.allOffers, (route) => false);
      });
    } on UseCaseException catch (e) {
      log(e.message);
      closeLoader(context);
    } on SocketException {
      log("Revise su conexion a internet");
      closeLoader(context);
    } catch (e) {
      log(e.toString());
      log("Error Inesperado. Intente de nuevo mas tarde");
      closeLoader(context);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final CreateOfferController createOfferController =
          Provider.of(context, listen: false);
      createOfferController.initialData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final CreateOfferController createOfferController = Provider.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarCustom(
        titleText: "Crear oferta",
        useBackButton: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: responsive.wp(5)),
              children: [
                TextFormFieldWidget(
                  borderColor: Colors.black,
                  hintText: "Url de la imagen",
                  controller: createOfferController.image,
                ),
                SizedBox(
                  height: responsive.hp(1),
                ),
                TextFormFieldWidget(
                  borderColor: Colors.black,
                  hintText: "Titulo",
                  controller: createOfferController.title,
                ),
                SizedBox(
                  height: responsive.hp(1),
                ),
                TextFormFieldWidget(
                  borderColor: Colors.black,
                  hintText: "Empresa",
                  controller: createOfferController.company,
                ),
                SizedBox(
                  height: responsive.hp(1),
                ),
                TextFormFieldWidget(
                  borderColor: Colors.black,
                  hintText: "Ciudad",
                  controller: createOfferController.city,
                ),
                SizedBox(
                  height: responsive.hp(1),
                ),
                TextFormFieldWidget(
                  borderColor: Colors.black,
                  hintText: "Fecha de la publicacion",
                  readOnly: true,
                  controller: createOfferController.date,
                ),
                SizedBox(
                  height: responsive.hp(1),
                ),
                TextFormFieldWidget(
                  borderColor: Colors.black,
                  hintText: "Descripción",
                  controller: createOfferController.description,
                ),
              ],
            ),
          ),
          SizedBox(
            width: responsive.width,
            height: responsive.hp(12),
            child: LayoutBuilder(builder: (context, constraints) {
              return Center(
                child: GestureDetector(
                  onTap: () => _createOffer(context),
                  child: Container(
                    width: constraints.maxWidth * 0.85,
                    height: constraints.maxHeight * 0.55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color(0xff0c3877),
                        borderRadius: BorderRadius.circular(10)),
                    child: CustomText(
                        text: "Crear",
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: responsive.dp(1.7)),
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
