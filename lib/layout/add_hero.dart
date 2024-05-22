import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oatto_ui_challenge/widget/attribute_widget.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import '../provider/oattmodel.dart';

class AddHero extends StatefulWidget {
  const AddHero({super.key});

  @override
  State<AddHero> createState() => _AddHeroState();
}

class _AddHeroState extends State<AddHero> {
  final TextEditingController name = TextEditingController();
  final TextEditingController desc = TextEditingController();
  final TextEditingController speedController = TextEditingController();
  final TextEditingController healthController = TextEditingController();
  final TextEditingController attackController = TextEditingController();
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool? checkimage;

  final _formKey = GlobalKey<FormState>();

  double speedProgress = 0;
  double healthProgress = 0;
  double attackProgress = 0;

  @override
  void initState() {
    super.initState();

    // Add listeners to the controllers to update the progress values
    speedController.addListener(() {
      setState(() {
        speedProgress = double.tryParse(speedController.text) ?? speedProgress;
      });
    });

    healthController.addListener(() {
      setState(() {
        healthProgress =
            double.tryParse(healthController.text) ?? healthProgress;
      });
    });

    attackController.addListener(() {
      setState(() {
        attackProgress =
            double.tryParse(attackController.text) ?? attackProgress;
      });
    });
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    speedController.dispose();
    healthController.dispose();
    attackController.dispose();
    super.dispose();
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
          'Add Hero',
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
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFF4E342),
        child: ElevatedButton(
          onPressed: () {
            // ตรวจสอบว่า _imageFile เป็น null หรือไม่
            if (_formKey.currentState!.validate() || checkimage == true) {
              // ดำเนินการสร้างผลิตภัณฑ์เมื่อฟอร์มผ่านการตรวจสอบ
              Provider.of<OattoModel>(context, listen: false).createHero(
                name: name.text,
                desc: desc.text,
                img: _imageFile!.path,
                speed: double.parse(speedController.text),
                health: double.parse(healthController.text),
                attack: double.parse(attackController.text),
              );
              QuickAlert.show(
                context: context,
                onConfirmBtnTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                type: QuickAlertType.success,
                text: 'Create Product Completed Successfully!',
                confirmBtnColor: Colors.deepPurple,
                confirmBtnTextStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              );
            } else {
              setState(() {
                checkimage = false;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80.0),
            ),
            padding: EdgeInsets.zero, // Remove default padding
          ),
          child: Ink(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffFF6958),
                  Color(0xffC358ED),
                ],
                begin: Alignment(0.1, -1),
                end: Alignment(-0.9, 1),
              ),
              borderRadius: BorderRadius.all(Radius.circular(80.0)),
            ),
            child: Container(
              constraints:
                  const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
              alignment: Alignment.center,
              child: const Text(
                'Create',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 28.0, left: 28.0, right: 28.0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      child: Stack(
                        children: [
                          Align(
                            child: Container(
                              margin: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(28)),
                              ),
                            ),
                            alignment: Alignment.bottomCenter,
                          ),
                          Align(
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(28)),
                              ),
                            ),
                            alignment: Alignment.bottomCenter,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: const EdgeInsets.only(
                                bottom: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(28)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (_imageFile == null)
                                    InkWell(
                                      onTap: () async {
                                        if (_imageFile == null) {
                                          final XFile? image =
                                              await _picker.pickImage(
                                                  source: ImageSource.gallery);
                                          setState(() {
                                            _imageFile = image!;
                                            checkimage = true;
                                          });
                                        } else {}
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.only(top: 16.0),
                                        child: Center(
                                          child: Icon(
                                            Icons.image,
                                            size: 250,
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: InkWell(
                                        onTap: () async {
                                          final XFile? image =
                                              await _picker.pickImage(
                                                  source: ImageSource.gallery);
                                          setState(() {
                                            _imageFile = image!;
                                            checkimage = true;
                                          });
                                        },
                                        child: SizedBox(
                                          height: 250,
                                          child: Image.file(
                                            File(_imageFile!.path),
                                            width: double.infinity,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (checkimage == false)
                                    const Text(
                                      "Please enter the picture",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w400,
                                      ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 22.0, vertical: 12),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: "Hero Name"),
                    controller: name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a hero name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 22.0, vertical: 12),
                  child: TextFormField(
                    decoration:
                        const InputDecoration(labelText: "Hero Description"),
                    controller: desc,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a hero description';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22.0,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AttributeWidget(
                              progress: speedProgress,
                              child: Image.asset('assets/images/speed.png'),
                            ),
                            TextFormField(
                              controller: speedController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              decoration:
                                  const InputDecoration(labelText: "Speed"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AttributeWidget(
                              progress: healthProgress,
                              child: Image.asset('assets/images/heart-alt.png'),
                            ),
                            TextFormField(
                              controller: healthController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              decoration:
                                  const InputDecoration(labelText: "Health"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AttributeWidget(
                              progress: attackProgress,
                              child: Image.asset('assets/images/knife.png'),
                            ),
                            TextFormField(
                              controller: attackController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              decoration: const InputDecoration(
                                labelText: "Attack",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
