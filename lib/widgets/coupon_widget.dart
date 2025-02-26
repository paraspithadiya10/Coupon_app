import 'package:flutter/material.dart';

class CouponWidget extends StatelessWidget {
  const CouponWidget(
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
