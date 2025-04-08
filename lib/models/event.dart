import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/category.dart';

class Event {
  String title;
  String description;
  DateTime dateTime;
  String id;
  Category category;

  Event({
    required this.title,
    required this.description,
    required this.dateTime,
    this.id = '',
    required this.category,
  });
  Event.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            title: json['title'],
            description: json['description'],
            category: Category.categories
                .firstWhere((Category) => Category.id == json['category']),
            dateTime: (json['date'] as Timestamp).toDate());
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category.id,
        'date': Timestamp.fromDate(dateTime),
      };
}
