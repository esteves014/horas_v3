import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horas_v3/services/auth_service.dart';

class DeleteAccountModal extends StatefulWidget {
  final User user;

  const DeleteAccountModal({super.key, required this.user});

  @override
  State<DeleteAccountModal> createState() => _DeleteAccountModalState();
}

class _DeleteAccountModalState extends State<DeleteAccountModal> {
  final _keyForm = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Account'),
      content: Form(
        key: _keyForm,
        child: TextFormField(
          controller: _passwordController,
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(labelText: 'Informe sua senha'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Por favor, informe sua senha';
            }
            return null;
          },
        ),
      ),
      actions: <TextButton>[
        TextButton(
          onPressed: () {
            if (_keyForm.currentState!.validate()) {
              authService
                  .loginUser(
                    email: widget.user.email!,
                    password: _passwordController.text,
                  )
                  .then((String? erro) {
                    if (erro != null) {
                      Navigator.pop(context);
                      final snackBar = SnackBar(
                        content: Text(erro),
                        backgroundColor: Colors.red,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                      Navigator.pop(context);

                      authService.deleteAccount(
                        password: _passwordController.text,
                      );
                    }
                  });
            }
          },
          child: const Text('Delete Account'),
        ),
      ],
    );
  }
}
