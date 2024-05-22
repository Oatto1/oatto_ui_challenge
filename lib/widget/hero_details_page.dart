import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oatto_ui_challenge/widget/attribute_widget.dart';

import '../model/hero_model.dart';

class HeroDetailsPage extends StatefulWidget {
  final HeroModel hero;

  const HeroDetailsPage(this.hero, {super.key});

  @override
  _HeroDetailsPageState createState() => _HeroDetailsPageState();
}

class _HeroDetailsPageState extends State<HeroDetailsPage> {
  final appBarHeight = 80.0;

  ScrollController? _scrollController;

  double toolbarOpacity = 1.0;

  @override
  void initState() {
    _scrollController = new ScrollController();
    _scrollController!.addListener(() {
      setState(() {
        if (_scrollController!.offset <= appBarHeight) {
          toolbarOpacity =
              (appBarHeight - _scrollController!.offset) / appBarHeight;
        } else {
          toolbarOpacity = 0;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white, // Customizing the color of the back button
          onPressed: () {
            Navigator.pop(context);
          },
          // You can also customize the icon by providing a different icon widget
          // icon: Icon(Icons.arrow_back),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFEE3474),
                Color(0xFFEE3474),
              ],
              begin: Alignment(0.3, -1),
              end: Alignment(-0.8, 1),
            ),
          ),
        ),
        title: Text(
          'Overview',
          style: GoogleFonts.prompt(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            tooltip: 'Comment Icon',
            onPressed: () {},
          ), //IconButton
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFEE3474),
              Color(0xFFF4E342),
            ],
            begin: Alignment(0.3, -1),
            end: Alignment(-0.8, 1),
          ),
        ),
        child: Stack(
          children: [
            ListView(
              controller: _scrollController,
              // padding: EdgeInsets.only(top: appBarHeight),
              children: [
                _HeroDetailsImage(widget.hero),
                _HeroDetailsName(widget.hero.name!),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 12),
                  child: Text(
                    widget.hero.desc!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 28),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AttributeWidget(
                        progress: widget.hero.speed!,
                        child: Image.asset('assets/images/speed.png'),
                      ),
                      AttributeWidget(
                        progress: widget.hero.speed!,
                        child: Image.asset('assets/images/heart-alt.png'),
                      ),
                      AttributeWidget(
                        progress: widget.hero.attack!,
                        child: Image.asset('assets/images/knife.png'),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 28,
                    ),
                    Expanded(
                      child: Container(
                          height: 54,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.white, // Border color
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              backgroundColor: Colors.white.withOpacity(
                                  0), // Background color with opacity
                            ),
                            child: const Text(
                              'Add Favourite',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: Container(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0),
                              ),
                              padding:
                                  EdgeInsets.zero, // Remove default padding
                            ),
                            child: Ink(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFF29758),
                                    Color(0xFFEF5D67),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(80.0)),
                              ),
                              child: Container(
                                constraints: const BoxConstraints(
                                    minWidth: 88.0, minHeight: 36.0),
                                alignment: Alignment.center,
                                child: const Text(
                                  'OK',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 28,
                ),
              ],
            ),
            // SafeArea(
            //   child: Opacity(
            //     opacity: toolbarOpacity,
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         const SizedBox(
            //           width: 18,
            //         ),
            //         IconButton(
            //           icon: const Icon(
            //             Icons.arrow_back_ios,
            //             color: Colors.white,
            //             size: 20,
            //           ),
            //           onPressed: () {
            //             Navigator.of(context).pop();
            //           },
            //         ),
            //         const Text(
            //           'Overview',
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 20,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //         Expanded(
            //             child: Container(
            //           height: appBarHeight,
            //         )),
            //         Container(
            //           width: appBarHeight,
            //           height: appBarHeight,
            //           child: const Icon(
            //             Icons.menu,
            //             color: Colors.white,
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class _HeroDetailsImage extends StatelessWidget {
  final HeroModel hero;

  const _HeroDetailsImage(this.hero);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28.0, left: 28.0, right: 28.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(28)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(28)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: const BorderRadius.all(Radius.circular(28)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: Hero(
                        tag: hero.name!,
                        child: Image.asset(
                          hero.img!,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroDetailsName extends StatelessWidget {
  final String heroName;

  const _HeroDetailsName(this.heroName);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      height: 86,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              heroName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 42,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Text(
                heroName,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.1),
                  fontWeight: FontWeight.bold,
                  fontSize: 56,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
