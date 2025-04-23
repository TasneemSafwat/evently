import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/category.dart';

class Event {
  String title;
  String description;
  DateTime dateTime;
  String id;
  Category category;
  String userId;
  String? long;
  String? late;
  String? address;

  Event({
    required this.title,
    required this.description,
    required this.dateTime,
    this.id = '',
    required this.userId,
    required this.category,
    this.long,
    this.late,
    this.address,
  });
  Event.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            userId: json['userId'],
            title: json['title'],
            description: json['description'],
            category: Category.categories
                .firstWhere((Category) => Category.id == json['category']),
            dateTime: (json['date'] as Timestamp).toDate(),
            long: json['long'],
            late: json['late'],
            address: json['address']);
  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'title': title,
        'description': description,
        'category': category.id,
        'date': Timestamp.fromDate(dateTime),
        'long': long,
        'late': late,
        'address': address,
      };
}
