import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'layout/add_hero.dart';
import 'model/hero_model.dart';
import 'widget/hero_widget.dart';
import 'provider/oattmodel.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ScrollController? _scrollController;

  double toolbarOpacity = 1.0;

  @override
  void initState() {
    _scrollController = new ScrollController();
    _scrollController?.addListener(() {
      setState(() {
        if (_scrollController!.offset <= 80) {
          toolbarOpacity = (80 - _scrollController!.offset) / 80;
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
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffFF6958),
                Color(0xffFF6958),
              ],
              begin: Alignment(0.3, -1),
              end: Alignment(-0.8, 1),
            ),
          ),
        ),
        title: Text(
          'Oatto Challenge',
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
            onPressed: () {print(Provider.of<OattoModel>(context, listen: false)
                                .heroList);},
          ), //IconButton
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffFF6958),
              Color(0xffC358ED),
            ],
            begin: Alignment(0.3, -1),
            end: Alignment(-0.8, 1),
          ),
        ),
        child: Stack(
          children: [
            Consumer<OattoModel>(
              builder: (context, oattoModel, child) {
                List<HeroModel> heroList = oattoModel.heroList;
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(top: 0, bottom: 40),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: HeroRowWidget(hero: heroList[index]),
                    );
                  },
                  itemCount: heroList.length,
                );
              }
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const AddHero(),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        },
        tooltip: 'Create New Todo',
        child: const Icon(
          Icons.add_shopping_cart,
        ),
      ),
    );
  }
}
