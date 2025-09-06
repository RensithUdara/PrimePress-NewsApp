import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infosphere/models/new_views_models.dart';
import 'package:infosphere/models/top_headlines.dart';
import 'package:infosphere/utils/custom_tag.dart';
import 'package:infosphere/utils/image_container.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleScreen extends StatelessWidget {
  final int selectedIndex; // Add this to store the selected article index
  final TopHeadlines topHeadlines;
  final String category; // Add category as a parameter
  ArticleScreen({
    Key? key,
    required this.selectedIndex,
    required this.topHeadlines,
    required this.category,
  }) : super(key: key);

  NewsviewModel headline = NewsviewModel();

  @override
  Widget build(BuildContext context) {
    // Access the selected article using selectedIndex
    final Articles article = topHeadlines.articles![selectedIndex];

    return FutureBuilder<TopHeadlines>(
        future: headline.getTopHeadlines(),
        builder: (context, snaphsot) {
          if (snaphsot.hasData) {
            return ImageContainer(
              width: double.infinity,
              //  height: double.infinity,
              imageUrl: article.urlToImage == null
                  ? "https://img.freepik.com/premium-vector/error-404-concepts-landing-page_206192-61.jpg?w=1060"
                  : article.urlToImage.toString(),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  iconTheme: const IconThemeData(color: Colors.white),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                extendBodyBehindAppBar: true,
                body: ListView(
                  children: [
                    _NewsHeadline(
                      article: article,
                      cartegory: category,
                    ),
                    _NewsBody(article: article)
                  ],
                ),
              ),
            );
          } else {
            return Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
              child: const Center(
                child: SpinKitCircle(
                  size: 60,
                  color: Colors.grey,
                ),
              ),
            );
          }
        });
  }
}

Future<void> launchUrlStart({required String url}) async {
  if (!await launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView)) {
    throw 'Could not launch $url';
  }
}

class _NewsBody extends StatelessWidget {
  const _NewsBody({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Articles article;

  @override
  Widget build(BuildContext context) {
    String formattedDate = 'Date Not Available';
    if (article.publishedAt != null) {
      DateTime dateTime = DateTime.parse(article.publishedAt.toString());
      formattedDate = DateFormat.yMMMMd().format(dateTime);
    }
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: Colors.white,
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomTag(
                backgroundColor: Colors.black,
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundImage: AssetImage(
                      article.source!.id == null
                          ? "assets/images/error.png"
                          : "assets/logos/${article.source!.id}.png",
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    article.source!.name.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              CustomTag(
                backgroundColor: Colors.grey.shade200,
                children: [
                  const Icon(
                    Icons.timer,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    formattedDate,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            article.title.toString(),
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            article.content.toString(),
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.5),
            maxLines: 3,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: 'Read more',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrlStart(url: article.url.toString());
                        },
                      style: GoogleFonts.lato(
                        color: Colors.blue.shade400,
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          GridView.builder(
              shrinkWrap: true,
              itemCount: 2,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.25,
              ),
              itemBuilder: (context, index) {
                return ImageContainer(
                  width: MediaQuery.of(context).size.width * 0.42,
                  imageUrl: article.urlToImage.toString() ??
                      "https://img.freepik.com/premium-vector/error-404-concepts-landing-page_206192-61.jpg?w=1060",
                  margin: const EdgeInsets.only(right: 5.0, bottom: 5.0),
                );
              })
        ],
      ),
    );
  }
}

class _NewsHeadline extends StatelessWidget {
  const _NewsHeadline({
    Key? key,
    required this.article,
    required this.cartegory,
  }) : super(key: key);

  final Articles article;
  final String cartegory;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          CustomTag(
            backgroundColor: Colors.grey.withAlpha(150),
            children: [
              Text(
                cartegory,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            article.title.toString(),
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.25,
                ),
          ),
        ],
      ),
    );
  }
}
