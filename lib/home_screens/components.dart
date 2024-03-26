import 'package:flutter/material.dart';

class HomePage {
  // intro info
  Widget buildTextWidget(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

//  GARDEN CONTAINERS

  Widget gardenContainer({
    required String text,
    required IconData iconData,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          IconButton(
            icon: Icon(
              iconData,
              color: const Color.fromARGB(255, 2, 52, 14),
            ),
            iconSize: 40,
            color: const Color.fromARGB(255, 2, 52, 14),
            onPressed: onPressed,
            padding: EdgeInsets.zero,
          ),
          const SizedBox(height: 8),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

// horizontal container
  Widget buildHorizontalContainerList(
    int itemCount,
    double width,
    double height,
    BoxDecoration decoration,
    iconbutton,
  ) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                width: width,
                decoration: decoration,
              ),
              Positioned(
                bottom: -13,
                right: -8,
                child: iconbutton,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildVerticalContainerList(
      int itemCount, double width, double height, BoxDecoration decoration) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: width,
            decoration: decoration,
          );
        },
      ),
    );
  }
}
