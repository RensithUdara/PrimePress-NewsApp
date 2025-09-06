import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:infosphere/utils/image_container.dart';

// ignore: must_be_immutable
class CustomeNews extends StatelessWidget {
  CustomeNews({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final articles = Article.articles;

    return Row(
      children: [
        ImageContainer(
          width: 80,
          height: 80,
          margin: const EdgeInsets.all(10.0),
          borderRadius: 5,
          imageUrl: "",
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CachedNetworkImage(
                imageUrl:
                    "https://img.freepik.com/premium-vector/error-404-concepts-landing-page_206192-61.jpg?w=1060",
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
                    )),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Title not Available",
                maxLines: 2,
                overflow: TextOverflow.clip,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(width: 5),
                  Text(
                    "Source Not Available",
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    "formattedDate",
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

const spinKit2 = SpinKitFadingCircle(
  size: 40,
  color: Colors.amber,
);
