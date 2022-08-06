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
import 'package:hackaton_flutter/src/utils/responsive.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class OfferDetailsPage extends StatelessWidget {
  const OfferDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final Offer offer = ModalRoute.of(context)!.settings.arguments as Offer;
    final List<String> features = (offer.features ?? "").split(";");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarCustom(
        titleText: "Detalles de la oferta",
        useBackButton: true,
        actions: [
          _OptionMenu(
            responsive: responsive,
            offer: offer,
          ),
        ],
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
                      CustomText(
                        text: offer.title ?? "",
                        fontSize: responsive.dp(2.5),
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: responsive.hp(.5)),
                      Row(
                        children: [
                          CustomText(
                            text: offer.city ?? "",
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                          CustomText(
                            text: " - ",
                            fontSize: responsive.dp(1.3),
                            color: Colors.grey,
                          ),
                          CustomText(
                            text: offer.timePublished ?? "",
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          )
                        ],
                      ),
                      SizedBox(height: responsive.hp(1)),
                      CustomText(
                        text: offer.company ?? "",
                        fontWeight: FontWeight.bold,
                        fontSize: responsive.dp(1.8),
                      ),
                      Wrap(
                        spacing: responsive.wp(2),
                        children: List.generate(
                            features.length,
                            (index) => Chip(
                                  label: CustomText(
                                    text: features[index],
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  backgroundColor: const Color(0xff0c3877),
                                )),
                      ),
                      SizedBox(
                        height: responsive.hp(2),
                      ),
                      CustomText(
                        text: offer.description ?? "",
                        fontWeight: FontWeight.w500,
                      )
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
                child: Container(
                  width: constraints.maxWidth * 0.85,
                  height: constraints.maxHeight * 0.55,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xff0c3877),
                      borderRadius: BorderRadius.circular(10)),
                  child: CustomText(
                      text: "Aplicar a esta oferta",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.dp(1.7)),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}

class _OptionMenu extends StatelessWidget {
  const _OptionMenu({
    Key? key,
    required this.responsive,
    required this.offer,
  }) : super(key: key);

  final Responsive responsive;
  final Offer offer;

  _deleteOffer(BuildContext context) async {
    final UpdateOfferController updateOfferController =
        Provider.of(context, listen: false);
    openLoader(context);
    try {
      await updateOfferController.deleteOffer(offer);
      // ignore: use_build_context_synchronously
      closeLoader(context);
      // ignore: use_build_context_synchronously
      openInfoModal(context, "Oferta eliminada", onTap: () {
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
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: CustomText(
            text: "Editar",
            fontSize: responsive.dp(1.8),
            fontWeight: FontWeight.bold,
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: CustomText(
            text: "Eliminar",
            fontSize: responsive.dp(1.8),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
      offset: const Offset(0, kToolbarHeight),
      color: Colors.white,
      elevation: 2,
      icon: const Icon(
        Icons.menu,
        color: Colors.black,
      ),
      onSelected: (int value) {
        switch (value) {
          case 1:
            Navigator.of(context)
                .pushNamed(RoutesName.offerUpdate, arguments: offer);
            break;
          case 2:
            openInfoModal(context, "¿Seguro que desea eliminar?",
                closeWithBackButton: true, onTap: () {
              closeInfoModal(context);
              _deleteOffer(context);
            });
            break;
          default:
        }
      },
    );
  }
}
