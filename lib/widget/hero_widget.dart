import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'attribute_widget.dart';
import 'hero_details_page.dart';
import '../model/hero_model.dart';

// Degree / Radians converter
const double degrees2Radians = math.pi / 180.0;
const double radians2Degrees = 180.0 / math.pi;

double degrees(double radians) => radians * radians2Degrees;

double radians(double degrees) => degrees * degrees2Radians;

class HeroRowWidget extends StatelessWidget {
  final HeroModel hero;
  final double rowHeight;

  const HeroRowWidget({
    required this.hero,
    this.rowHeight = 282,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: rowHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.translate(
            offset: Offset(-10, 0),
            child: Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.01)
                ..rotateY(radians(1.5)),
              child: Container(
                height: 216,
                margin: EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(-44, 0),
            child: Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.01)
                ..rotateY(radians(8)),
              child: Container(
                height: 188,
                margin: EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Transform.translate(
                offset: Offset(-10, 0),
                child: Container(
                  child: Hero(
                    tag: hero.name!,
                    child: Image.asset(
                      hero.img!,
                      width: rowHeight,
                      height: rowHeight,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.only(right: 58),
              padding: EdgeInsets.symmetric(vertical: 34),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AttributeWidget(
                    progress: hero.speed!, 
                    child: Image.asset('assets/images/speed.png'),
                  ),
                  AttributeWidget(
                    progress: hero.health!,
                    child: Image.asset('assets/images/heart-alt.png'),
                  ),
                  AttributeWidget(
                    progress: hero.attack!,
                    child: Image.asset('assets/images/knife.png'),
                  ),
                  SizedBox(
                      height: 32,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                                  HeroDetailsPage(hero),
                              transitionsBuilder: (_, animation, __, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                          // Navigator.of(context)
                          //     .push(MaterialPageRoute(builder: (context) {
                          //   return HeroDetailsPage(hero);
                          // }));
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Colors.white, 
                            width: 1,
                          ),
                          backgroundColor: Colors.white.withOpacity(
                              0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Text(
                          'See Details',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
