import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event.dart';

class FirebaseService {
  static CollectionReference<Event> getEventsCollection() =>
      FirebaseFirestore.instance.collection('events').withConverter<Event>(
            fromFirestore: (docSnapshot, _) =>
                Event.fromJson(docSnapshot.data()!),
            toFirestore: (event, _) => event.toJson(),
          );

  static Future<void> addEventToFirestore(Event event) async {
    CollectionReference<Event> eventsCollection = getEventsCollection();
    DocumentReference<Event> doc = eventsCollection.doc();
    event.id = doc.id;
    return doc.set(event);
  }

  static Future<List<Event>> getEvents() async {
    CollectionReference<Event> eventsCollection = getEventsCollection();
    QuerySnapshot<Event> querySnapshot = await eventsCollection.get();
    return querySnapshot.docs
        .map(
          (docSnapshot) => docSnapshot.data(),
        )
        .toList();
  }
}
