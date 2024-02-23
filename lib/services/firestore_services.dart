import 'package:emart_app/consts/consts.dart';

class FirestoreServices {
  // get users data
  static getUser(uid) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  // get products according to category
  static getProducts(category) {
    return firestore
        .collection(productsColletion)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  // get cart
  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  // detele document
  static daleteDocument(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  // get all chat messages
  static getChatMessages(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }
  static getAllOrders(){
    return firestore.collection(ordersCollection).where('order_by',isEqualTo: currentUser!.uid).snapshots();
  }

  static getWishlists(){
    return firestore.collection(productsColletion).where('p_wishlist',arrayContains: currentUser!.uid).snapshots();
  }

  static getAllMessages(){
     return firestore
        .collection(chatsCollection)
        .where('fromId',isEqualTo: currentUser!.uid)
        .snapshots();
  }
}
