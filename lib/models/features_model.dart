class FeaturesModel {
  FeaturesModel({
    this.id = 0,
    this.category = '',
    this.color = '#e05e48',
    this.icon = 'adb_rounded',
  });

  int id;
  String category;
  String color;
  String icon;

  factory FeaturesModel.fromJson(Map<String, dynamic> json) => FeaturesModel(
        id: json["id"],
        category: json["category"],
        color: json["color"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "color": color,
        "icon": icon,
      };
}
