import 'package:demo_app/data/preferences/pref_keys.dart';
import 'package:demo_app/providers/category_provider.dart';
import 'package:demo_app/widgets/category_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryCard extends StatelessWidget {
  final double height;
  final double width;
  final int categoryIndex;
  final String categoryName;

  const CategoryCard({
    super.key,
    required this.height,
    required this.width,
    required this.categoryIndex,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
      child: GestureDetector(
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
                  sharedPref.setInt(keyCategoryIndex, categoryIndex);

                  if (context.mounted) {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => CategoryBottomSheetWidget(
                              isCategoryUpdate: true,
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
                  context
                      .read<CategoryProvider>()
                      .removeCategory(categoryIndex);
                },
              ),
            ],
          );
        },
        child: Card(
          elevation: 4,
          child: Container(
            height: height * 0.19,
            width: width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.09,
                  child: const Center(
                    child: Text('Image\nSection'),
                  ),
                ),
                const Divider(),
                Text(categoryName)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
