import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TopChannel extends StatefulWidget {
  const TopChannel({super.key});

  @override
  State<TopChannel> createState() => _TopChannelState();
}

class _TopChannelState extends State<TopChannel> {
  @override
  Widget build(BuildContext context) {
    final myheight = MediaQuery.of(context).size.height * 1;
    final mywidth = MediaQuery.of(context).size.width * 1;
    String url = "assets/logos/news24.png";
    return Container(
      height: 120.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(
              8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                          offset: Offset(
                            1.0,
                            1.0,
                          ),
                        )
                      ],
                      image: new DecorationImage(
                          fit: BoxFit.cover, image: AssetImage(url)),
                    )),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "News24",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      height: 1.4,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

const spinKit2 = SpinKitFadingCircle(
  size: 40,
  color: Colors.amber,
);
