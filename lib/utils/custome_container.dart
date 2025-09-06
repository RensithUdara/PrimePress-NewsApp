import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomContainer extends StatelessWidget {
  final String imageurl;

  CustomContainer({
    required this.imageurl,
  });
  @override
  Widget build(BuildContext context) {
    final myheight = MediaQuery.sizeOf(context).height * 1;
    final mywidth = MediaQuery.sizeOf(context).width * 1;

    return Container(
      margin: EdgeInsets.symmetric(vertical: mywidth * 0.01),
      height: myheight * 0.15,
      width: mywidth * 0.7,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            offset: Offset(
              0.0,
              10.0,
            ),
            blurRadius: 10.0,
            spreadRadius: -6.0,
          ),
        ],
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CachedNetworkImage(
              imageUrl: imageurl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              colorBlendMode: BlendMode.multiply,
              color: Colors.black.withOpacity(0.35),
              placeholder: (context, url) => Container(
                    child: spinKit2, // Use your loading indicator here
                  ),
              errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: Colors.red,
                  ))),
    );
  }
}

const spinKit2 = SpinKitFadingCircle(
  size: 40,
  color: Colors.amber,
);
