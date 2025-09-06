import 'dart:math';

import 'package:flutter/material.dart';
import 'package:infosphere/animation/fade_animation.dart';
import 'package:infosphere/models/new_views_models.dart';
import 'package:infosphere/models/top_headlines.dart';
import 'package:infosphere/utils/category_item.dart';
import 'package:infosphere/view/article_screen.dart';
import 'package:infosphere/view/discover_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  
  Widget _CategoriesScroll() {
    List<Map<String, dynamic>> categories = [
      {'name': 'World', 'icon': Icons.public, 'color': Colors.blue},
      {'name': 'Business', 'icon': Icons.business, 'color': Colors.amber},
      {'name': 'Technology', 'icon': Icons.computer, 'color': Colors.purple},
      {'name': 'Science', 'icon': Icons.science, 'color': Colors.green},
      {'name': 'Sports', 'icon': Icons.sports_soccer, 'color': Colors.red},
      {'name': 'Health', 'icon': Icons.health_and_safety, 'color': Colors.teal},
    ];

    return Container(
      margin: EdgeInsets.only(bottom: 24.0),
      height: 50,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryItem(
            categoryName: categories[index]['name'],
            icon: categories[index]['icon'],
            color: categories[index]['color'],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DiscoverScreen()),
              );
            },
          );
        },
      ),
    );
  }

  Widget _RecommendedNews() {
    NewsviewModel headline = NewsviewModel();
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recommended for you',
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
          FutureBuilder<TopHeadlines>(
            future: headline.getTopHeadlines(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // Take only 3 items to display in a vertical list
                final articles = snapshot.data!.articles!.take(3).toList();
                
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: articles.length,
                  separatorBuilder: (context, index) => Divider(height: 16),
                  itemBuilder: (context, index) {
                    var article = articles[index];
                    String formattedDate = 'Date Not Available';
                    if (article.publishedAt != null) {
                      DateTime dateTime = DateTime.parse(article.publishedAt.toString());
                      formattedDate = DateFormat.MMMd().format(dateTime);
                    }
                    
                    return FadeAnimation(
                      1.2,
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArticleScreen(
                                selectedIndex: index,
                                topHeadlines: snapshot.data!,
                                category: "Recommended",
                              ),
                            ),
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    article.urlToImage == null
                                        ? "https://img.freepik.com/premium-vector/error-404-concepts-landing-page_206192-61.jpg?w=1060"
                                        : article.urlToImage.toString(),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article.title == null
                                        ? "Title Not Available"
                                        : article.title.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.public,
                                        size: 12,
                                        color: Colors.grey[600],
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        article.source?.name ?? "Source Not Available",
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        formattedDate,
                                        style: TextStyle(
                                          color: Colors.grey,
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
                    );
                  },
                );
              } else {
                return Center(
                  child: SpinKitCircle(
                    color: Colors.blue[700],
                    size: 30,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
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
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Breaking News',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DiscoverScreen()),
                  );
                },
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
          const SizedBox(height: 12),
          SizedBox(
            height: 230, // Increased height to accommodate content
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
                      if (list![index].publishedAt != null) {
                        DateTime dateTime = DateTime.parse(
                            list[index].publishedAt.toString());
                        formattedDate = DateFormat.MMMd().format(dateTime);
                      }

                      return FadeAnimation(
                        1.2,
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          margin: const EdgeInsets.only(right: 16),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ArticleScreen(
                                    selectedIndex: selectedIndex,
                                    topHeadlines: snapshot.data!,
                                    category: "Breaking news",
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          list[index].urlToImage == null
                                              ? "https://img.freepik.com/premium-vector/error-404-concepts-landing-page_206192-61.jpg?w=1060"
                                              : list[index].urlToImage.toString(),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(  // Using Expanded to prevent overflow
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,  // Use minimum space needed
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: Colors.redAccent.withOpacity(0.1),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  'BREAKING',
                                                  style: TextStyle(
                                                    color: Colors.redAccent,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                formattedDate,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 6),  // Reduced spacing
                                          Expanded(  // Make title take available space
                                            child: Text(
                                              list[index].title == null
                                                  ? "Title Not Available"
                                                  : list[index].title.toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                height: 1.2,  // Reduced line height
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 6),  // Reduced spacing
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.public,
                                                size: 14,
                                                color: Colors.grey[600],
                                              ),
                                              const SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  list[index].source!.name == null
                                                      ? "Source Not Available"
                                                      : list[index].source!.name.toString(),
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 12,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: SpinKitCircle(
                      color: Colors.blue[700],
                      size: 30,
                    ),
                  );
                }
              },
            ),
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
