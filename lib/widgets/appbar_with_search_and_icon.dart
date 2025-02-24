import 'package:demo_app/widgets/svg_picture_widget.dart';
import 'package:flutter/material.dart';

class AppbarWithSearchAndIcon extends StatelessWidget {
  const AppbarWithSearchAndIcon({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;

    return Stack(
      children: [
        Container(
          height: height * 0.1,
          width: width * 1.0,
          color: Color(0xffFAF0FF),
        ),
        SvgPictureWidget(
          imagePath: 'assets/images/home_background_1st_layer.svg',
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
                child: Icon(
                  icon,
                  size: 35,
                )),
          ],
        )
      ],
    );
  }
}
