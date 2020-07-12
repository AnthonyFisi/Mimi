
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tienda_mimi/main.dart';




final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final databaseReference = FirebaseDatabase.instance.reference();
Stream<FirebaseUser> m;


String name;
String email;
String imageUrl;
String token;
String telefono;

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);

  final FirebaseUser user = authResult.user;

  // Checking if email and name is null
  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);

  name = user.displayName;
  email = user.email;
  imageUrl = user.photoUrl;
  token=user.uid;
  telefono=user.phoneNumber;


  // Only taking the first part of the name, i.e., First Name
  if (name.contains(" ")) {
    name = name.substring(0, name.indexOf(" "));
  }

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);
  m=_auth.onAuthStateChanged;

  databaseReference
      .child("Usuarios")
      .child(token)
      .set(
      {
        'nombre':name,
        'correo':email,
        'imagenURL':imageUrl,
        'telefono':telefono

      }
  );

  return user.toString();
}

void signOutGoogle() async {
  statusChange=false;
  await googleSignIn.signOut();

  print("User Sign Out");
}



class SingInWithOtherAccounts {


}