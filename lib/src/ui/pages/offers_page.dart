import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hackaton_flutter/src/controllers/offers_controller.dart';
import 'package:hackaton_flutter/src/entities/offers.dart';
import 'package:hackaton_flutter/src/data/uses_cases/base.dart';
import 'package:hackaton_flutter/src/ui/routes/routes_name.dart';
import 'package:hackaton_flutter/src/ui/widgets/app_bar.dart';
import 'package:hackaton_flutter/src/ui/widgets/custom_text.dart';
import 'package:hackaton_flutter/src/ui/widgets/loading.dart';
import 'package:hackaton_flutter/src/ui/widgets/offer_container.dart';
import 'package:hackaton_flutter/src/utils/responsive.dart';
import 'package:provider/provider.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({Key? key}) : super(key: key);

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  _getAllOffers() async {
    openLoader(context);
    final OffersController offersController =
        Provider.of(context, listen: false);
    try {
      await offersController.getAllOffer();
      // ignore: use_build_context_synchronously
      closeLoader(context);
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
      _getAllOffers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final OffersController offersController = Provider.of(context);
    final List<Offer> offers = offersController.allOffers?.offers ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarCustom(
        titleText: "Listado de ofertas",
        useBackButton: false,
      ),
      body: Builder(builder: (context) {
        if (offers.isEmpty) {
          return _EmptyOffers(responsive: responsive);
        } else {
          return _FullOffers(responsive: responsive, offers: offers);
        }
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff0c3877),
        onPressed: () =>
            Navigator.of(context).pushNamed(RoutesName.offerCreate),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _EmptyOffers extends StatelessWidget {
  const _EmptyOffers({
    Key? key,
    required this.responsive,
  }) : super(key: key);

  final Responsive responsive;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
            alignment: Alignment.center,
            child: Image.asset("assets/images/empty.png")),
        SizedBox(height: responsive.hp(5)),
        CustomText(
          text: "No hay ofertas disponibles.",
          fontSize: responsive.dp(2.5),
          fontWeight: FontWeight.bold,
        ),
        CustomText(
          text: "Intente de nuevo más tarde.",
          fontSize: responsive.dp(1.8),
          fontWeight: FontWeight.w600,
        ),
      ],
    ));
  }
}

class _FullOffers extends StatefulWidget {
  const _FullOffers({
    Key? key,
    required this.responsive,
    required this.offers,
  }) : super(key: key);

  final Responsive responsive;
  final List<Offer> offers;

  @override
  State<_FullOffers> createState() => _FullOffersState();
}

class _FullOffersState extends State<_FullOffers> {
  final ScrollController scrollController = ScrollController();

  _loadMore(BuildContext context) async {
    final OffersController offersController =
        Provider.of(context, listen: false);
    openLoader(context);
    try {
      await offersController.loadMoreOffers();
      // ignore: use_build_context_synchronously
      closeLoader(context);
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
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _loadMore(context);
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
          vertical: widget.responsive.hp(2),
          horizontal: widget.responsive.wp(4)),
      itemCount: widget.offers.length,
      itemBuilder: (_, index) {
        return OfferContainer(
          offer: widget.offers[index],
          onTap: () => Navigator.of(context).pushNamed(RoutesName.offerDetails,
              arguments: widget.offers[index]),
        );
      },
    );
  }
}
