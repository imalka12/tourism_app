import 'package:hive_flutter/hive_flutter.dart';

part 'activity.g.dart';

@HiveType(typeId: 0)
class Activity extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? image;
  @HiveField(3)
  String? activeStatus;
  @HiveField(4)
  String? slug;

  Activity({this.id, this.title, this.image, this.activeStatus, this.slug});

  Activity.fromJson(Map<String, dynamic> json) {
     id = json['id'];
    title = json['title'];
    image = json['image'];
    activeStatus = json['activeStatus'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'image': image,
      'activeStatus': activeStatus,
      'slug': slug,
    };
  }
}
