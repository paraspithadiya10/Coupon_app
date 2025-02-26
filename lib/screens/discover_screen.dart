import 'package:demo_app/providers/category_provider.dart';
import 'package:demo_app/providers/coupon_provider.dart';
import 'package:demo_app/widgets/category_card_widget.dart';
import 'package:demo_app/widgets/coupon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 15,
        children: [
          _searchAppBarUI(height, width, context),
          _categoriesSectionUI(height, width, context),
          _discoverHeaderUI(context),
          _couponGridViewUI(height, width, context),
        ],
      ),
    );
  }

  Widget _searchAppBarUI(height, width, context) {
    return Stack(
      children: [
        Container(
          height: height * 0.1,
          width: width * 1.0,
          color: Color(0xffFAF0FF),
        ),
        SvgPicture.asset(
          'assets/images/home_background_1st_layer.svg',
          fit: BoxFit.fill,
        ),
        AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Card(
            elevation: 4,
            child: SizedBox(
              height: height * 0.04,
              child: TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    labelText: 'Search',
                    labelStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none)),
              ),
            ),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Card(
                  elevation: 4,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('You tapped on map button.')));
                        },
                        icon: Icon(Icons.map)),
                  ),
                )),
          ],
        )
      ],
    );
  }

  Widget _categoriesSectionUI(
      double height, double width, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'CATEGORIES',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                onPressed: () {
                  context.read<CategoryProvider>().addCategoryData(context);
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.2,
            child: Consumer<CategoryProvider>(
              builder: (_, provider, __) {
                final List<String> selectedCategoryData =
                    provider.getSelectedCategoryData();
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: selectedCategoryData.length,
                  itemBuilder: (context, index) => CategoryCard(
                    height: height,
                    width: width,
                    categoryName: selectedCategoryData[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _discoverHeaderUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'DISCOVER',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.grey),
          ),
          IconButton(
              onPressed: () {
                context.read<CouponProvider>().addCoupon(context);
              },
              icon: Icon(Icons.add))
        ],
      ),
    );
  }

  Widget _couponGridViewUI(height, width, context) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: Consumer<CouponProvider>(builder: (_, provider, __) {
            List<Map<String, dynamic>> couponItems = provider.getCoupon();
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 5,
                childAspectRatio: 0.7,
              ),
              itemCount: couponItems.length,
              itemBuilder: (context, index) {
                return CouponWidget(
                  height: height,
                  width: width,
                  discount: couponItems[index]['discount'].toDouble(),
                  brandName: couponItems[index]['brandName'],
                  date: couponItems[index]['date'],
                  isBelongsTo: couponItems[index]['isBelongsTo'],
                );
              },
            );
          })),
    );
  }
}
