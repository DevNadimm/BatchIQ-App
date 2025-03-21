// import 'package:batchiq_app/core/services/notification_service.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class GoogleAuthController extends GetxController {
//   static final instance = Get.find<GoogleAuthController>();
//
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//   String? _errorMessage;
//   String? get errorMessage => _errorMessage;
//
//   bool _isSuccess = false;
//   bool get isSuccess => _isSuccess;
//
//   bool isJoinedBatch = false;
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   /// **Set Loading State**
//   void setGoogleSignInInProgress(bool isLoading) {
//     _isLoading = isLoading;
//     update();
//   }
//
//   /// **Sign In With Google**
//   Future<bool> signInWithGoogle() async {
//     setGoogleSignInInProgress(true);
//     try {
//       await GoogleSignIn().signOut();
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//
//       if (googleUser == null) {
//         return _handleSignInError("You canceled the sign-in process.");
//       }
//
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//       if (googleAuth.accessToken == null || googleAuth.idToken == null) {
//         return _handleSignInError('Unable to retrieve Google credentials. Please try again.');
//       }
//
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       UserCredential userCredential = await _auth.signInWithCredential(credential);
//       User? user = userCredential.user;
//
//       if (user == null) {
//         return _handleSignInError('Could not find your account in our system. Please try again.');
//       }
//
//       // **Check if User Exists in Firestore**
//       final userDoc = await _firestore.collection("Users").doc(user.uid).get();
//       if (userDoc.exists) {
//         final data = userDoc.data() as Map<String, dynamic>;
//         isJoinedBatch = data["batchId"]?.isNotEmpty ?? false;
//
//         // **Subscribe to Notification Topic**
//         if (data["batchId"] != null && data["batchId"].isNotEmpty) {
//           await NotificationService.instance.subscribeToTopic(data["batchId"]);
//         }
//       } else {
//         isJoinedBatch = false;
//       }
//
//       _isSuccess = true;
//       update();
//       return true;
//     } catch (e) {
//       return _handleSignInError(e.toString());
//     } finally {
//       setGoogleSignInInProgress(false);
//     }
//   }
//
//   /// **Sign Up With Google (For New Users)**
//   Future<bool> signUpWithGoogle() async {
//     setGoogleSignInInProgress(true);
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       if (googleUser == null) {
//         return _handleSignInError("Sign-up process was canceled.");
//       }
//
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//       if (googleAuth.accessToken == null || googleAuth.idToken == null) {
//         return _handleSignInError("Google authentication failed.");
//       }
//
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       UserCredential userCredential = await _auth.signInWithCredential(credential);
//       User? user = userCredential.user;
//
//       if (user == null) {
//         return _handleSignInError("User sign-up failed.");
//       }
//
//       // **Check if User Already Exists**
//       final userDoc = await _firestore.collection("Users").doc(user.uid).get();
//       if (!userDoc.exists) {
//         // **Create New User Document**
//         await _firestore.collection('Users').doc(user.uid).set({
//           'name': user.displayName,
//           'email': user.email,
//           'role': 'student',
//           'batchId': "",
//           'createdAt': DateTime.now().toString(),
//         });
//       }
//
//       _isSuccess = true;
//       update();
//       return true;
//     } catch (e) {
//       return _handleSignInError(e.toString());
//     } finally {
//       setGoogleSignInInProgress(false);
//     }
//   }
//
//   /// **Handle Errors**
//   Future<bool> _handleSignInError(String message) async {
//     _isSuccess = false;
//     _errorMessage = message;
//     update();
//     setGoogleSignInInProgress(false);
//     return false;
//   }
// }
