import 'package:flutter/foundation.dart';

import '../model/hero_model.dart';

class OattoModel with ChangeNotifier, DiagnosticableTreeMixin {
  List<HeroModel> heroList = [];
  void createHero(
      {required String name,
      required String desc,
      required String img,
      required double speed,
      required double health,
      required double attack}) {

    HeroModel newHero = HeroModel(
      name: name,
      desc: desc,
      img: img,
      speed: speed,
      health: health,
      attack: attack,
    );

    heroList.add(newHero); // เพิ่มข้อมูลใหม่ลงในรายการ
    notifyListeners(); // แจ้งเตือน listener ว่ามีการเปลี่ยนแปลงใน model
  }
}
