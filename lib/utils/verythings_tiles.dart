import 'package:flutter/material.dart';

class Everythings extends StatefulWidget {
  const Everythings({super.key});

  @override
  State<Everythings> createState() => _Everythings();
}

class _Everythings extends State<Everythings> {
  @override
  Widget build(BuildContext context) {
    final myheight = MediaQuery.of(context).size.height * 1;
    final mywidth = MediaQuery.of(context).size.width * 1;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mywidth * 0.03),
      child: Container(
        height: myheight * 0.15,
        width: mywidth * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
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
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: mywidth * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("data"),
                      Text("data"),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "4 days ago • More of your videos are\n being looked at more often",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            )),
            Padding(
              padding:
                  EdgeInsets.only(left: mywidth * 0.02, right: mywidth * 0.02),
              child: Container(
                height: myheight * 0.13,
                width: mywidth * 0.2,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
