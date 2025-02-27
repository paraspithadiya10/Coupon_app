// ignore_for_file: use_build_context_synchronously

import 'package:demo_app/data/preferences/pref_keys.dart';
import 'package:demo_app/providers/category_provider.dart';
import 'package:demo_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryBottomSheetWidget extends StatefulWidget {
  const CategoryBottomSheetWidget({super.key, required this.isCategoryUpdate});

  final bool isCategoryUpdate;

  @override
  State<CategoryBottomSheetWidget> createState() =>
      _CategoryBottomSheetWidgetState();
}

class _CategoryBottomSheetWidgetState extends State<CategoryBottomSheetWidget> {
  final TextEditingController categoryNameController = TextEditingController();
  String categoryName = '';

  @override
  void initState() {
    if (widget.isCategoryUpdate) {
      getCategory();
    }
    super.initState();
  }

  void getCategory() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    int index = sharedPref.getInt(keyCategoryIndex) ?? 0;

    categoryName = context.read<CategoryProvider>().getCategoryByIndex(index);
    categoryNameController.text = categoryName;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    final String isCategoryUpdateText =
        widget.isCategoryUpdate ? 'Update' : 'Add';

    return Container(
      padding: EdgeInsets.only(left: 25, right: 25, top: 10),
      height: height * 0.25 + MediaQuery.of(context).viewInsets.bottom,
      width: width * 1.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
            controller: categoryNameController,
            labelText: 'Category',
            labelColor: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: const Color.fromARGB(255, 168, 168, 168)),
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
                  if (categoryNameController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('Error'),
                              content: Text('Category is required.'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Ok'))
                              ],
                            ));
                  } else {
                    if (widget.isCategoryUpdate) {
                      SharedPreferences sharedPref =
                          await SharedPreferences.getInstance();
                      int index = sharedPref.getInt(keyCategoryIndex) ?? 0;

                      context
                          .read<CategoryProvider>()
                          .updateCategory(categoryNameController.text, index);
                    } else {
                      context
                          .read<CategoryProvider>()
                          .addCategoryData(categoryNameController.text);

                      categoryNameController.text = '';
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(
                  isCategoryUpdateText,
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
