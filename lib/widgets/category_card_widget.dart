import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final double height;
  final double width;
  final String categoryName;

  const CategoryCard({
    super.key,
    required this.height,
    required this.width,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
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
    );
  }
}
