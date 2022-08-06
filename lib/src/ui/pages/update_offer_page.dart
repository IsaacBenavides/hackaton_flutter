import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hackaton_flutter/src/controllers/update_offer_controller.dart';
import 'package:hackaton_flutter/src/data/uses_cases/base.dart';
import 'package:hackaton_flutter/src/entities/offers.dart';
import 'package:hackaton_flutter/src/ui/routes/routes_name.dart';
import 'package:hackaton_flutter/src/ui/widgets/app_bar.dart';
import 'package:hackaton_flutter/src/ui/widgets/custom_text.dart';
import 'package:hackaton_flutter/src/ui/widgets/info_modal.dart';
import 'package:hackaton_flutter/src/ui/widgets/loading.dart';
import 'package:hackaton_flutter/src/ui/widgets/text_form_field.dart';
import 'package:hackaton_flutter/src/utils/responsive.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class UpdateOfferPage extends StatefulWidget {
  const UpdateOfferPage({Key? key}) : super(key: key);

  @override
  State<UpdateOfferPage> createState() => _UpdateOfferPageState();
}

class _UpdateOfferPageState extends State<UpdateOfferPage> {
  _updateOffer(Offer offer) async {
    final UpdateOfferController updateOfferController =
        Provider.of(context, listen: false);
    openLoader(context);
    try {
      await updateOfferController.updateOffer(offer);
      // ignore: use_build_context_synchronously
      closeLoader(context);
      // ignore: use_build_context_synchronously
      openInfoModal(context, "Oferta actualizada", onTap: () {
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
      final Offer offer = ModalRoute.of(context)!.settings.arguments as Offer;
      final UpdateOfferController updateOfferController =
          Provider.of(context, listen: false);
      updateOfferController.setInitialValues(offer);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Offer offer = ModalRoute.of(context)!.settings.arguments as Offer;
    final Responsive responsive = Responsive.of(context);
    final UpdateOfferController updateOfferController = Provider.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarCustom(
        titleText: "Actualizar oferta",
        useBackButton: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  width: responsive.width,
                  height: responsive.hp(30),
                  child: CachedNetworkImage(
                    key: UniqueKey(),
                    imageUrl: offer.image!,
                    errorWidget: (_, __, ___) => const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    placeholder: (context, url) =>
                        Lottie.asset("assets/animations/loading.json"),
                  ),
                ),
                SizedBox(height: responsive.hp(5)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: responsive.wp(5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormFieldWidget(
                        controller: updateOfferController.title,
                        borderColor: Colors.black,
                        hintText: "Titulo",
                      ),
                      SizedBox(height: responsive.hp(3)),
                      TextFormFieldWidget(
                        hintText: "Descripción",
                        borderColor: Colors.black,
                        controller: updateOfferController.description,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: responsive.width,
            height: responsive.hp(12),
            child: LayoutBuilder(builder: (context, constraints) {
              return Center(
                child: GestureDetector(
                  onTap: () => _updateOffer(offer),
                  child: Container(
                    width: constraints.maxWidth * 0.85,
                    height: constraints.maxHeight * 0.55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color(0xff0c3877),
                        borderRadius: BorderRadius.circular(10)),
                    child: CustomText(
                        text: "Actualizar",
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
