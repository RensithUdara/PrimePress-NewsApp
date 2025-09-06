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
    return FadeAnimation(
      1.2,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today\'s Headlines',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'See all',
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: myheight * 0.40,
              child: FutureBuilder<TopHeadlines>(
                future: headline.getTopHeadlines(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final articles = snapshot.data!.articles;
                    final random = Random();
                    final randomIndex = random.nextInt(articles!.length);
                    final randomArticle = articles[randomIndex];
                    
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArticleScreen(
                                selectedIndex: randomIndex,
                                topHeadlines: snapshot.data!,
                                category: 'News of the Day',
                              ),
                            ),
                          );
                        },
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                          child: Stack(
                            children: [
                              Container(
                                height: double.infinity,
                                width: double.infinity,
                                child: Image.network(
                                  randomArticle.urlToImage == null
                                      ? "https://img.freepik.com/premium-vector/error-404-concepts-landing-page_206192-61.jpg?w=1060"
                                      : randomArticle.urlToImage.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.7),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.blue[700],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'Featured',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      randomArticle.title == null
                                          ? "Title Not Available"
                                          : randomArticle.title.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        height: 1.25,
                                        color: Colors.white,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          color: Colors.white70,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          randomArticle.publishedAt != null
                                              ? DateFormat.yMMMMd().format(DateTime.parse(randomArticle.publishedAt.toString()))
                                              : "Date not available",
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: SpinKitCircle(
                        color: Colors.blue[700],
                        size: 40,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
