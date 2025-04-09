import 'package:evently/models/user_model.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser;
  void updateCurrentUser(UserModel? user) {
    currentUser = user;
    notifyListeners();
  }

  bool checkIsEventFavourite(String eventId) {
    return currentUser!.favouriteEventIds.contains(eventId);
  }

  void addEventToFavourite(String eventId) {
    currentUser!.favouriteEventIds.add(eventId);
    notifyListeners();
  }

  void removeEventfromFavourite(String eventId) {
    currentUser!.favouriteEventIds.remove(eventId);
    notifyListeners();
  }
}
