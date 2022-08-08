import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hackaton_flutter/src/entities/offers.dart';
import 'package:hackaton_flutter/src/ui/widgets/custom_text.dart';
import 'package:hackaton_flutter/src/utils/responsive.dart';
import 'package:lottie/lottie.dart';

class OfferContainer extends StatelessWidget {
  const OfferContainer({Key? key, this.onTap, required this.offer})
      : super(key: key);

  final VoidCallback? onTap;
  final Offer offer;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: responsive.wp(80),
        height: responsive.hp(15),
        margin: EdgeInsets.only(bottom: responsive.hp(2)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 6.0,
              spreadRadius: 1,
              color: Colors.black12,
            )
          ],
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.only(left: constraints.maxWidth * 0.05),
                width: constraints.maxWidth * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: offer.title ?? "Sin Titulo",
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.dp(1.8),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.05),
                    CustomText(
                      text: offer.description ?? "Sin descripción",
                      fontSize: responsive.dp(1.3),
                      maxLine: 2,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: constraints.maxHeight * 0.05),
                    SizedBox(
                      width: constraints.maxWidth * .7,
                      child: CustomText(
                        text: offer.company ?? "",
                        fontSize: responsive.dp(1.3),
                        maxLine: 2,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.06),
                    CustomText(
                      text: offer.timePublished ?? "",
                      fontSize: responsive.dp(1.3),
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: constraints.maxWidth * 0.2,
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
              )
            ],
          );
        }),
      ),
    );
  }
}
