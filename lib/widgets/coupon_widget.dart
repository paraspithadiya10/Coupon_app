import 'package:demo_app/data/preferences/pref_keys.dart';
import 'package:demo_app/providers/coupon_provider.dart';
import 'package:demo_app/widgets/coupon_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CouponWidget extends StatelessWidget {
  const CouponWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.couponIndex,
      required this.discount,
      required this.brandName,
      required this.date,
      required this.isBelongsTo});

  final double height;
  final double width;
  final int couponIndex;
  final String discount;
  final String brandName;
  final String date;
  final bool isBelongsTo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail_Screen');
      },
      onLongPressStart: (LongPressStartDetails details) {
        final RenderBox overlay =
            Overlay.of(context).context.findRenderObject() as RenderBox;
        final RelativeRect position = RelativeRect.fromRect(
          Rect.fromPoints(
            details.globalPosition,
            details.globalPosition,
          ),
          Offset.zero & overlay.size,
        );

        showMenu(
          context: context,
          position: position,
          items: [
            PopupMenuItem(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text('Edit'), Icon(Icons.edit)],
              ),
              onTap: () async {
                SharedPreferences sharedPref =
                    await SharedPreferences.getInstance();
                sharedPref.setInt(keyCouponIndex, couponIndex);

                if (context.mounted) {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => CouponBottomSheetWidget(
                            isCouponUpdate: true,
                          ));
                }
              },
            ),
            PopupMenuItem(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text('Delete'), Icon(Icons.delete)],
              ),
              onTap: () {
                context.read<CouponProvider>().removeCoupon(couponIndex);
              },
            ),
          ],
        );
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
                    spacing: 2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$discount% off',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          Icon(
                            Icons.save,
                            size: 20,
                          )
                        ],
                      ),
                      Text(brandName),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                          color: isBelongsTo ? Colors.green : Colors.red),
                    ),
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
