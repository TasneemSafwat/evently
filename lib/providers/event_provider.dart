import 'package:evently/firebase_service.dart';
import 'package:evently/models/category.dart';
import 'package:evently/models/event.dart';
import 'package:flutter/material.dart';

class EventProvider with ChangeNotifier {
  List<Event> allEvents = [];
  List<Event> filteredEvent = [];
  List<Event> favouriteEvent = [];
  Category? selectedCategory;

  Future<void> getEvents() async {
    allEvents = await FirebaseService.getEvents();
    changeSelectedCategory(selectedCategory);
  }

  void changeSelectedCategory(Category? category) async {
    selectedCategory = category;
    if (category == null) {
      filteredEvent = allEvents;
    } else {
      filteredEvent =
          allEvents.where((event) => event.category == category).toList();
    }
    notifyListeners();
  }

  Future<void> addToFavourite(String eventId) {
    return FirebaseService.addEventToFavourite(eventId);
  }

  Future<void> removeToFavourite(String eventId) {
    return FirebaseService.removeEventFromFavourite(eventId);
  }

  void filterFavoriteEvents(List<String> favoriteIds) {
    favouriteEvent =
        allEvents.where((event) => favoriteIds.contains(event.id)).toList();
    notifyListeners();
  }
}
