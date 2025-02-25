import 'package:demo_app/providers/category_provider.dart';
import 'package:demo_app/widgets/category_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    List<String> categoryData;
    int listviewIndex = 0;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 15,
        children: [
          _customAppBarUI(height, width, context),
          Padding(
              padding: EdgeInsets.only(left: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CATEGORIES',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: height * 0.2,
                    child: Consumer<CategoryProvider>(
                      builder: (_, provider, __) {
                        categoryData = provider.getCategoryData();
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryData.length,
                          itemBuilder: (context, index) {
                            listviewIndex = index;
                            return CategoryCard(
                              height: height,
                              width: width,
                              categoryName: categoryData[index],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              )),
          _discoverTitleUI(context),
          _discoverGridViewUI(height, width),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          if (listviewIndex >= 5) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                        title: Text('information'),
                        content: Text(
                            'You have reached the maximum number of categories.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ]));
          } else {
            context.read<CategoryProvider>().addCategoryData();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _customAppBarUI(height, width, context) {
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

  Widget _discoverTitleUI(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Text(
        'DISCOVER',
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Colors.grey),
      ),
    );
  }

  Widget _discoverGridViewUI(height, width) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            crossAxisSpacing: 15,
            mainAxisSpacing: 5,
            childAspectRatio: 0.7,
            children: [
              GridItems(
                  height: height,
                  width: width,
                  discount: 10,
                  brandName: 'Castel Winery',
                  date: 'jun 1 - jun 8',
                  isBelongsTo: true),
              GridItems(
                  height: height,
                  width: width,
                  discount: 15,
                  brandName: 'Pancakes House',
                  date: 'jun 1 - jun 24',
                  isBelongsTo: false),
              GridItems(
                height: height,
                width: width,
                discount: 10,
                brandName: 'Spa Boutique',
                date: 'jun 1 - jun 8',
                isBelongsTo: true,
              ),
              GridItems(
                height: height,
                width: width,
                discount: 15,
                brandName: 'H & M',
                date: 'jun 1 - jun 8',
                isBelongsTo: false,
              ),
              GridItems(
                height: height,
                width: width,
                discount: 5,
                brandName: 'Apple online store',
                date: 'jun 1 - jun 18',
                isBelongsTo: true,
              ),
              GridItems(
                height: height,
                width: width,
                discount: 5,
                brandName: 'Mashya Restaurant',
                date: 'jun 1 - jun 8',
                isBelongsTo: false,
              ),
            ],
          )),
    );
  }
}

class GridItems extends StatelessWidget {
  const GridItems(
      {super.key,
      required this.height,
      required this.width,
      required this.discount,
      required this.brandName,
      required this.date,
      required this.isBelongsTo});

  final double height;
  final double width;
  final double discount;
  final String brandName;
  final String date;
  final bool isBelongsTo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail_Screen');
      },
      child: Card(
        elevation: 4,
        child: Container(
          height: height * 0.3,
          width: width * 0.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.14,
                child: Center(
                  child: Text('[Image Section]'),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$discount% off',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          Icon(Icons.save)
                        ],
                      ),
                      Text(brandName),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(date),
                    Container(
                      width: width * 0.06,
                      height: height * 0.004,
                      color: isBelongsTo ? Colors.green : Colors.red,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
