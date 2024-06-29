import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class SINGINScreen extends StatefulWidget {
  const SINGINScreen({super.key});

  @override
  State<SINGINScreen> createState() => _SINGINScreenState();
}

class _SINGINScreenState extends State<SINGINScreen> {
  String? _userId;
  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId:
        '312853938836-3ncofuqfnufa86ni89d77j9gkkqrtg77.apps.googleusercontent.com',
    serverClientId:
        '312853938836-md2o3ffm3sre618cpugaufhj3qn7gcjq.apps.googleusercontent.com',
  );

  @override
  void initState() {
    super.initState();
    supabase.auth.onAuthStateChange.listen((data) {
      setState(() {
        _userId = data.session?.user.id;
      });
    });
  }

  Future<void> _signIn() async {
    try {
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }

      await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }

  Future<void> _signOut() async {
    try {
      await googleSignIn.signOut();
      await supabase.auth.signOut();
      setState(() {
        _userId = null;
      });
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_userId ?? 'Not signed in'),
            if (_userId == null)
              ElevatedButton(
                onPressed: _signIn,
                child: const Text('Sign In'),
              )
            else
              ElevatedButton(
                onPressed: _signOut,
                child: const Text('Sign Out'),
              ),
          ],
        ),
      ),
    );
  }
}
