import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:horas_v3/screens/register_screen.dart';
import 'package:horas_v3/components/reset_password_modal.dart';
import 'package:horas_v3/services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  AuthService _authService = AuthService();

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
                    ElevatedButton(
                      onPressed: () =>
                      {
                        _authService
                            .loginUser(
                          email: _emailController.text,
                          password: _passwordController.text,
                        )
                            .then((String? erro) {
                          if (erro != null) {
                            final snackBar = SnackBar(
                              content: Text(erro),
                              backgroundColor: Colors.red,
                            );
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(snackBar);
                          }
                        }),
                      },
                      child: Text('Entrar'),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => {signInWithGoogle()},
                      child: Text('Entrar com Google'),
                    ),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () =>
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        ),
                      },
                      child: Text('Ainda não tem uma conta? Crie uma conta'),
                    ),

                    TextButton(
                      onPressed: () {
                        showDialog(
                            context: context, builder: (BuildContext context) {
                          return ResetPasswordModal();
                        });
                      },
                      child: Text('Esqueci minha senha'),
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
