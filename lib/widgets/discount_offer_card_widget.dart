import 'package:flutter/material.dart';

class DiscountOfferCard extends StatelessWidget {
  const DiscountOfferCard({
    super.key,
    required this.discountPercentage,
    required this.imagePath,
    required this.isBelongsTo,
    required this.height,
    required this.width,
  });

  final int discountPercentage;
  final String imagePath;
  final bool isBelongsTo;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: height * 0.008,
            width: width * 0.06,
            color: isBelongsTo ? Color(0xff12E573) : Color(0xffEA0101),
          ),
          Text(
            '$discountPercentage% off',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          Image.asset(imagePath),
          Text(
            'Get discount code',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}
