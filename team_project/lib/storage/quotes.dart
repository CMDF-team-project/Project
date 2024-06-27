import 'package:cloud_firestore/cloud_firestore.dart';

class QuoteService {
  final CollectionReference quotesCollection = FirebaseFirestore.instance.collection('quotes');

  Future<String?> getRandomQuote() async {
  QuerySnapshot querySnapshot = await quotesCollection.get();
  if (querySnapshot.docs.isEmpty) {
    return null;
  }
  int randomIndex = DateTime.now().millisecondsSinceEpoch % querySnapshot.docs.length;
  
  Map<String, dynamic>? data = querySnapshot.docs[randomIndex].data() as Map<String, dynamic>?;
  if (data == null || !data.containsKey('text')) {
    return null;
  }
  
  return data['text'] as String?;
}

}
