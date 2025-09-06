import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:infosphere/animation/fade_animation.dart';
import 'package:infosphere/models/categrious__news_model.dart';
import 'package:infosphere/models/new_views_models.dart';
import 'package:infosphere/models/top_headlines.dart';
import 'package:infosphere/utils/custom_news.dart';
import 'package:infosphere/utils/image_container.dart';
import 'package:infosphere/view/article_screen.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  static const routeName = '/discover';
  @override
  Widget build(BuildContext context) {
    List<String> tabs = [
      'General',
      'Entertainment',
      'Health',
      'Science',
      'Sports',
      'Technology'
    ];

    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [_CategoryNews(tabs: tabs)],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _CategoryNews extends StatefulWidget {
  _CategoryNews({
    Key? key,
    required this.tabs,
  }) : super(key: key);

  List<String> tabs;

  @override
  State<_CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<_CategoryNews> {
  TextEditingController _searchController = TextEditingController();
  Future<TopHeadlines>? searchResults;

  @override
  Widget build(BuildContext context) {
    // final articles = Article.articles;
    NewsviewModel categoryNews = NewsviewModel();

    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Discover',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 5),
              Text(
                'News from all over the world',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _searchController,
                onChanged: (query) {
                  if (query.isNotEmpty) {
                    // Call the API for search results
                    setState(() {
                      searchResults = categoryNews.getCategoryNews(query);
                    });
                  } else {
                    // Show default category news
                    setState(() {
                      searchResults = null;
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              )
            ],
          ),
        ),
        TabBar(
          isScrollable: true,
          indicatorColor: Colors.black,
          tabs: widget.tabs
              .map(
                (tab) => Tab(
                  icon: Text(
                    tab,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: TabBarView(
            children: widget.tabs.map(
              (tab) {
                final dataFuture =
                    searchResults ?? categoryNews.getCategoryNews(tab);

                return FutureBuilder<TopHeadlines>(
                    future: dataFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.articles!.length,
                          itemBuilder: ((context, index) {
                            int selectedIndex = index;
                            var list = snapshot.data!.articles;
                            String formattedDate = 'Date Not Available';
                            print("date : " + formattedDate);
                            if (list![index].publishedAt != null) {
                              DateTime dateTime = DateTime.parse(
                                  list[index].publishedAt.toString());
                              formattedDate =
                                  DateFormat.yMMMMd().format(dateTime);
                            }
                            String imageUrl = list[index].urlToImage.toString();
                            Widget imageWidget;
                            if (imageUrl != null && imageUrl.isNotEmpty) {
                              imageWidget = ImageContainer(
                                width: 80,
                                height: 80,
                                margin: const EdgeInsets.all(10.0),
                                borderRadius: 5,
                                imageUrl: "",
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                    colorBlendMode: BlendMode.multiply,
                                    color: Colors.black.withOpacity(0.35),
                                    placeholder: (context, url) => Container(
                                      child:
                                          spinKit2, // Use your loading indicator here
                                    ),
                                    errorWidget: (context, url, error) =>
                                        CachedNetworkImage(
                                      imageUrl:
                                          "https://img.freepik.com/premium-vector/error-404-concepts-landing-page_206192-61.jpg?w=1060", // Replace with your error image URL
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              imageWidget = ImageContainer(
                                width: 80,
                                height: 80,
                                margin: const EdgeInsets.all(10.0),
                                borderRadius: 5,
                                imageUrl: "",
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://img.freepik.com/premium-vector/error-404-concepts-landing-page_206192-61.jpg?w=1060", // Replace with your error image URL
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                              );
                            }
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ArticleScreen(
                                              selectedIndex: selectedIndex,
                                              topHeadlines: snapshot.data!,
                                              category: tab,
                                            )));
                              },
                              child: FadeAnimation(
                                1.2,
                                Row(
                                  children: [
                                    imageWidget,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            list[index].title == null
                                                ? "Title not Available"
                                                : list[index].title.toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.clip,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              const SizedBox(width: 5),
                                              Text(
                                                list[index].source!.name == null
                                                    ? "Source Not Available"
                                                    : list[index]
                                                        .source!
                                                        .name
                                                        .toString(),
                                                style: const TextStyle(
                                                    fontSize: 10),
                                              ),
                                              const SizedBox(width: 20),
                                              Text(
                                                formattedDate,
                                                style: const TextStyle(
                                                    fontSize: 10),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        );
                      } else {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount:
                                5, // You can adjust the itemCount for the number of shimmer items you want.
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  // Shimmer effect for the image container
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child:
                                            ShimmerBox(width: 80, height: 80)),
                                  ),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ShimmerBox(
                                          width: double.infinity,
                                          height:
                                              18, // Adjust the height as needed
                                        ),
                                        const SizedBox(height: 10),
                                        ShimmerBox(
                                          width: 200,
                                          height:
                                              12, // Adjust the height as needed
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      }
                    });
              },
            ).toList(),
          ),
        )
      ],
    );
  }
}

class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;

  ShimmerBox({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.white,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}

const spinKit2 = SpinKitFadingCircle(
  size: 40,
  color: Colors.amber,
);
