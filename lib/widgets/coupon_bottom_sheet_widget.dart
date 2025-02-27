import 'package:demo_app/data/preferences/pref_keys.dart';
import 'package:demo_app/providers/coupon_provider.dart';
import 'package:demo_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CouponBottomSheetWidget extends StatefulWidget {
  const CouponBottomSheetWidget({super.key, required this.isCouponUpdate});

  final bool isCouponUpdate;

  @override
  State<CouponBottomSheetWidget> createState() =>
      _CouponBottomSheetWidgetState();
}

class _CouponBottomSheetWidgetState extends State<CouponBottomSheetWidget> {
  final TextEditingController brandNameController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

  String brandName = '';
  String discountPercentage = '';

  bool isBelongsTo = false;
  String dateForUpdate = '';

  DateTimeRange? selectedDate;
  DateTimeRange? pickedDateRange;

  String formateDateRange(DateTimeRange? range) {
    if (range == null) return 'Select range of date';

    List<String> month = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    final startMonth = month[range.start.month - 1];
    final endMonth = month[range.end.month - 1];

    return '$startMonth ${range.start.day} - $endMonth ${range.end.day}';
  }

  @override
  void initState() {
    if (widget.isCouponUpdate) {
      getCoupon();
    }
    super.initState();
  }

  void getCoupon() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    int index = sharedPref.getInt(keyCouponIndex) ?? 0;

    Map<String, dynamic> coupon =
        context.read<CouponProvider>().getCoupon(index);
    brandNameController.text = coupon[keyBrandName];
    discountController.text = coupon[keyDiscount];
    dateForUpdate = coupon[keyDate];
    isBelongsTo = coupon[keyIsBelongsTo];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Container(
      padding: EdgeInsets.only(left: 25, right: 25, top: 10),
      height: height * 0.5 + MediaQuery.of(context).viewInsets.bottom,
      width: width * 1.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.white),
      child: Column(
        children: [
          Container(
            height: 4,
            width: width * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black54,
            ),
          ),
          SizedBox(height: height * 0.03),
          CustomTextFormField(
            controller: brandNameController,
            labelText: 'Brand Name',
            labelColor: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.grey),
          ),
          SizedBox(height: height * 0.03),
          CustomTextFormField(
            controller: discountController,
            labelText: 'Discount %',
            labelColor: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.grey),
          ),
          SizedBox(height: height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.isCouponUpdate
                    ? dateForUpdate
                    : formateDateRange(selectedDate),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              OutlinedButton(
                  onPressed: () async {
                    pickedDateRange = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(2025),
                        lastDate: DateTime(2026),
                        currentDate: DateTime.now());

                    if (pickedDateRange != null) {
                      setState(() {
                        selectedDate = pickedDateRange;
                      });
                    }
                  },
                  child: Text('Pick Date'))
            ],
          ),
          SizedBox(height: height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'belong to clubs/groups',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Switch(
                  value: isBelongsTo,
                  onChanged: (value) {
                    setState(() {
                      isBelongsTo = value;
                    });
                  })
            ],
          ),
          SizedBox(
            height: height * 0.03,
          ),
          SizedBox(
            width: width * 0.9,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(Color(0xff484453))),
                onPressed: () async {
                  if (brandNameController.text.isEmpty ||
                      discountController.text.isEmpty ||
                      selectedDate!.start.month == 0) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('Error'),
                              content: Text('all data is required.'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Ok'))
                              ],
                            ));
                  } else {
                    brandName = brandNameController.text;
                    discountPercentage = discountController.text;

                    if (widget.isCouponUpdate) {
                      SharedPreferences sharedPref =
                          await SharedPreferences.getInstance();
                      int index = sharedPref.getInt(keyCouponIndex) ?? 0;

                      if (context.mounted) {
                        context.read<CouponProvider>().updateCoupon({
                          keyDiscount: discountPercentage,
                          keyBrandName: brandName,
                          keyDate: formateDateRange(selectedDate),
                          keyIsBelongsTo: isBelongsTo
                        }, index);
                      }
                    } else {
                      context.read<CouponProvider>().addCoupon(context, {
                        keyDiscount: discountPercentage,
                        keyBrandName: brandName,
                        keyDate: formateDateRange(selectedDate),
                        keyIsBelongsTo: isBelongsTo
                      });
                    }

                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text(
                  widget.isCouponUpdate ? 'Update' : 'Add',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
