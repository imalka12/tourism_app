import 'package:hive_flutter/hive_flutter.dart';

part 'category.g.dart';

@HiveType(typeId: 1)
class Category extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? image;
  @HiveField(3)
  String? typeKey;
  @HiveField(4)
  String? slug;

  Category({this.id, this.title, this.image, this.typeKey, this.slug});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    typeKey = json['type_key'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'image': image,
      'type_key': typeKey,
      'slug': slug,
    };
  }
}