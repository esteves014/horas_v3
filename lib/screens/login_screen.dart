import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:horas_v3/screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlue,
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    FlutterLogo(size: 100),
                    SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(hintText: 'Email'),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(hintText: 'Password'),
                    ),
                    ElevatedButton(onPressed: () => {}, child: Text('Entrar')),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => {},
                      child: Text('Entrar com Google'),
                    ),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        ),
                      },
                      child: Text('Ainda não tem uma conta? Crie uma conta'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn.instance;

    await googleSignIn.initialize();

    final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

    final clientAuth = await googleUser.authorizationClient.authorizeScopes([
      'email',
      'profile',
    ]);

    final credential = GoogleAuthProvider.credential(
      accessToken: clientAuth.accessToken,
      idToken: googleUser.authentication.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
