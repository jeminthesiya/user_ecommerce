import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseHelper {
  static FireBaseHelper fireBaseHelper = FireBaseHelper._();

  FireBaseHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool?> Create({required email, required password}) async {
    return await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      return true;
    }).catchError((e) {
      return false;
    });
  }

  Future<bool?> Check({required email, required password}) async {
    bool? mag;

    return await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        return true;
      },
    ).catchError(
      (e) {
        return false;
      },
    );
    return mag;
  }

  bool Checklogin() {
    User? user = firebaseAuth.currentUser;
    var uid = user?.uid;
    if (uid != null) {
      return true;
    } else {
      return false;
    }
  }

  bool StoreLigin() {
    User? user = firebaseAuth.currentUser;
    return user != null;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  sinhInThroughGoogle() async {
    bool? msg;
    GoogleSignInAccount? user = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await user?.authentication;

    var crd = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await firebaseAuth
        .signInWithCredential(crd)
        .then((value) => msg = true)
        .catchError((e) => msg = false);
    return msg;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> GetData() {
    User? user = firebaseAuth.currentUser;
    var uid = user!.uid;

    return firestore
        .collection("ECommerce")
        .doc("$uid")
        .collection("Product")
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> ReadData() {
    User? user = firebaseAuth.currentUser;
    var uid = user!.uid;

    return firestore
        .collection("ECommerce")
        .doc("$uid")
        .collection("Product")
        .snapshots();
  }

  userData() {
    User? use = firebaseAuth.currentUser;
    String? image = use?.photoURL;
    String? email = use?.email;
    String? name = use?.displayName;
    return {'e1': email, 'name': name, 'img': image};
  }

  void insertitem({
    required Name,
    required Notes,
    required Date,
    required Time,
    required Price,
    required Image,
  }) async {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    await firestore.collection("AddCart").doc("$uid").collection("Cart").add({
      "p_name": Name,
      "p_notes": Notes,
      "p_date": Date,
      "p_time": Time,
      "p_image": Image,
      "p_price": Price,
    });
  }

  void cartitem({
    required Name,
    required Notes,
    required Date,
    required Time,
    required Price,
    required Image,
  }) async {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    await firestore.collection("AddCart").doc("$uid").collection("Cart").add({
      "p_name": Name,
      "p_notes": Notes,
      "p_date": Date,
      "p_time": Time,
      "p_image": Image,
      "p_price": Price,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readitem() {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    return firestore.collection("ECommerce").snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readcartitem() {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    return firestore
        .collection("AddCart")
        .doc("$uid")
        .collection("Cart")
        .snapshots();
  }

  Future<void> deletdata({required key}) async {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    return await firestore
        .collection("AddCart")
        .doc('$uid')
        .collection('Cart')
        .doc('$key')
        .delete();
  }

  ///////////////////////////////////////////////////

  void BuyData({
    required Name,
    required Notes,
    required Date,
    required Time,
    required Price,
    required Image,
  }) async {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    await firestore.collection("Buy").doc("$uid").collection("PBuy").add({
      "p_name": Name,
      "p_notes": Notes,
      "p_date": Date,
      "p_time": Time,
      "p_image": Image,
      "p_price": Price,
    });
  }

  void Buyitem({
    required Name,
    required Notes,
    required Date,
    required Time,
    required Price,
    required Image,
  }) async {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    await firestore.collection("Buy").doc("$uid").collection("PBuy").add({
      "p_name": Name,
      "p_notes": Notes,
      "p_date": Date,
      "p_time": Time,
      "p_image": Image,
      "p_price": Price,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> PBuyitem() {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    return firestore.collection("ECommerce").snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> BuyShowitem() {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    return firestore
        .collection("Buy")
        .doc("$uid")
        .collection("PBuy")
        .snapshots();
  }

  Future<void> BuyDelete({required key}) async {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    return await firestore
        .collection("Buy")
        .doc('$uid')
        .collection('PBuy')
        .doc('$key')
        .delete();
  }
}
