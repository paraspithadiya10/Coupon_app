import 'package:demo_app/widgets/discount_offer_card_widget.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Color(0xff005FDA),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(context),
            _buildHeaderSection(context),
            SizedBox(height: height * 0.07),
            _buildStoreInfoSection(context, width, height),
            SizedBox(height: height * 0.03),
            _buildDiscountDescription(context),
            SizedBox(height: height * 0.03),
            _buildDiscountCodeButton(context),
            SizedBox(height: height * 0.03),
            _buildRelatedDiscountsSection(context, height, width),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 50.0),
      child: Row(
        children: [
          Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          Text(
            'ADIDAS',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image.asset(
            'assets/images/adidas_logo.png',
            height: 200,
            width: 200,
          ),
        ),
        Center(
          child: Text(
            '10% off',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }

  Widget _buildStoreInfoSection(
      BuildContext context, double width, double height) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Clothing Store',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white)),
              Text('Jun 1 - Jun 8',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white)),
            ],
          ),
          Container(
            width: width * 0.4,
            height: height * 0.035,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white)),
            child: Center(
                child: Text(
              'Save for Later',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.white),
            )),
          )
        ],
      ),
    );
  }

  Widget _buildDiscountDescription(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          'Get 10% off with lls 200 purchase. This discount is only available for _____ members. click the link below to get the discount code.',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ));
  }

  Widget _buildDiscountCodeButton(BuildContext context) {
    return Center(
      child: Text(
        'Get discount code',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Colors.white,
            decoration: TextDecoration.underline,
            decorationColor: Colors.white,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildRelatedDiscountsSection(
      BuildContext context, double height, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'You also have discounts with:',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: height * 0.03),
        DiscountOfferCard(
          discountPercentage: 5,
          imagePath: 'assets/images/logo-hvr 2.png',
          isBelongsTo: true,
          height: height,
          width: width,
        ),
        SizedBox(height: height * 0.03),
        DiscountOfferCard(
          discountPercentage: 5,
          imagePath: 'assets/images/visa-logo 2.png',
          isBelongsTo: false,
          height: height,
          width: width,
        ),
      ],
    );
  }
}
