import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event.dart';
import 'package:evently/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static CollectionReference<Event> getEventsCollection() =>
      FirebaseFirestore.instance.collection('events').withConverter<Event>(
            fromFirestore: (docSnapshot, _) =>
                Event.fromJson(docSnapshot.data()!),
            toFirestore: (event, _) => event.toJson(),
          );
  static CollectionReference<UserModel> getUserCollection() =>
      FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
            fromFirestore: (docSnapshot, _) =>
                UserModel.fromJson(docSnapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

  static Future<void> addEventToFirestore(Event event) async {
    CollectionReference<Event> eventsCollection = getEventsCollection();
    DocumentReference<Event> doc = eventsCollection.doc();
    event.id = doc.id;
    return doc.set(event);
  }

  static Future<List<Event>> getEvents() async {
    CollectionReference<Event> eventsCollection = getEventsCollection();
    QuerySnapshot<Event> querySnapshot =
        await eventsCollection.orderBy('date').get();

    return querySnapshot.docs
        .map(
          (docSnapshot) => docSnapshot.data(),
        )
        .toList();
  }

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    UserModel user = UserModel(
      id: credential.user!.uid,
      name: name,
      email: email,
      favouriteEventIds: [],
    );
    CollectionReference<UserModel> usersCollection = getUserCollection();
    await usersCollection.doc(credential.user!.uid).set(user);
    return user;
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    CollectionReference<UserModel> usersCollection = getUserCollection();

    DocumentSnapshot<UserModel> docsnapshot =
        await usersCollection.doc(credential.user!.uid).get();

    return docsnapshot.data()!;
  }

  static Future<void> logout() => FirebaseAuth.instance.signOut();
}
