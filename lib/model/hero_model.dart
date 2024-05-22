class HeroModel {
  String? name;
  String? desc;
  String? img;
  double? speed;
  double? health;
  double? attack;

  HeroModel({
    this.name,
     this.desc,
    this.img,
    this.speed,
    this.health,
    this.attack,
  });

  HeroModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    desc = json['desc'];
    img = json['img'];
    speed = json['speed'] ?? 0;
    health = json['health'] ?? 0;
    attack = json['attack'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['desc'] = desc;
    data['img'] = img;
    data['speed'] = speed;
    data['health'] = health;
    data['attack'] = attack;
    return data;
  }
}
