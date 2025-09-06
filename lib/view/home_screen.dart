import 'dart:math';

import 'package:flutter/material.dart';
import 'package:infosphere/animation/fade_animation.dart';
import 'package:infosphere/models/new_views_models.dart';

import 'package:infosphere/models/top_headlines.dart';
import 'package:infosphere/utils/custom_tag.dart';
import 'package:infosphere/utils/custome_container.dart';
import 'package:infosphere/utils/category_item.dart';
import 'package:infosphere/utils/image_container.dart';
import 'package:infosphere/view/article_screen.dart';

import 'package:infosphere/view/discover_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsviewModel headline = NewsviewModel();
  late Future<TopHeadlines> topHeadlinesFuture;

  @override
  void initState() {
    super.initState();
    topHeadlinesFuture = headline.getTopHeadlines();
  }

  Future<void> _refreshData() async {
    setState(() {
      topHeadlinesFuture = headline.getTopHeadlines();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Text(
              'Info',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              'sphere',
              style: TextStyle(
                color: Colors.blue[700],
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.black87,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.black87,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: Colors.blue[700],
        onRefresh: _refreshData,
        child: ListView(
          padding: EdgeInsets.only(top: 16, bottom: 20),
          children: [
            _CategoriesScroll(),
            _NewsOfTheDay(),
            _BreakingNews(),
            _RecommendedNews(),
          ],
        ),
      ),
    );
  }
}

class _BreakingNews extends StatelessWidget {
  const _BreakingNews({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewsviewModel headline = NewsviewModel();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Breaking News',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DiscoverScreen()));
                  },
                  child: Text('More',
                      style: Theme.of(context).textTheme.bodyLarge)),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 250,
            child: FutureBuilder<TopHeadlines>(
                future: headline.getTopHeadlines(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        int selectedIndex = index;
                        var list = snapshot.data!.articles;
                        String formattedDate = 'Date Not Available';
                        print("object : " + formattedDate);
                        if (list![index].publishedAt != null) {
                          DateTime dateTime = DateTime.parse(
                              list[index].publishedAt.toString());
                          formattedDate = DateFormat.yMMMMd().format(dateTime);
                        }

                        return FadeAnimation(
                          1.2,
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            margin: const EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ArticleScreen(
                                              selectedIndex: selectedIndex,
                                              topHeadlines: snapshot.data!,
                                              category: "Breaking news",
                                            )));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomContainer(
                                    imageurl: list[index].urlToImage == null
                                        ? "https://img.freepik.com/premium-vector/error-404-concepts-landing-page_206192-61.jpg?w=1060"
                                        : list[index].urlToImage.toString(),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    list[index].title == null
                                        ? "Title Not Available"
                                        : list[index].title.toString(),
                                    maxLines: 2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            height: 1.5),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(formattedDate,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                  const SizedBox(height: 5),
                                  Text(
                                      list[index].source!.name == null
                                          ? "Source Not Available"
                                          : list[index].source!.name.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: SpinKitCircle(
                        color: Colors.grey,
                      ),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class _NewsOfTheDay extends StatefulWidget {
  const _NewsOfTheDay({
    Key? key,
  }) : super(key: key);

  @override
  State<_NewsOfTheDay> createState() => _NewsOfTheDayState();
}

class _NewsOfTheDayState extends State<_NewsOfTheDay> {
  @override
  Widget build(BuildContext context) {
    NewsviewModel headline = NewsviewModel();
    final myheight = MediaQuery.sizeOf(context).height * 1;
    final mywidth = MediaQuery.sizeOf(context).width * 1;
    return FadeAnimation(
      1.2,
      SizedBox(
        height: myheight * 0.50,
        child: FutureBuilder<TopHeadlines>(
          future: headline.getTopHeadlines(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final articles = snapshot.data!.articles;
              final random = Random();
              final randomIndex =
                  random.nextInt(articles!.length); // Get a random index
              final randomArticle = articles[randomIndex];
              print("image url = " + randomArticle.urlToImage.toString());
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ArticleScreen(
                                selectedIndex: randomIndex,
                                topHeadlines: snapshot.data!,
                                category: 'News of the Day',
                              )));
                },
                child: ImageContainer(
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  imageUrl: randomArticle.urlToImage == null
                      ? "https://img.freepik.com/premium-vector/error-404-concepts-landing-page_206192-61.jpg?w=1060"
                      : randomArticle.urlToImage.toString(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTag(
                        backgroundColor: Colors.grey.withAlpha(150),
                        children: [
                          Text(
                            'News of the Day',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        randomArticle.title == null
                            ? "Title Not Available"
                            : randomArticle.title.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                height: 1.25,
                                color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: Row(
                          children: [
                            Text(
                              'Learn More',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.arrow_right_alt,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: SpinKitCircle(
                  color: Colors.grey,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
