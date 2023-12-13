import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference tweets =
      FirebaseFirestore.instance.collection("tweets");
  Future<void> addTweet(String author, String text, String bodyImageUrl) {
    String nAuthor;
    if (author == "")
      nAuthor = "Formula 1";
    else
      nAuthor = author;
    return tweets.add({
      'author': nAuthor,
      'text': text,
      'bodyImageUrl': bodyImageUrl,
      'date': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getTweetStream() {
    final tweetStream = tweets.orderBy('date', descending: true).snapshots();
    print(tweetStream.runtimeType);
    return tweetStream;
  }
}
