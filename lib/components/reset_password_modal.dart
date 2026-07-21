import 'package:flutter/material.dart';
import 'package:horas_v3/services/auth_service.dart';

class ResetPasswordModal extends StatefulWidget {
  const ResetPasswordModal({super.key});

  @override
  State<ResetPasswordModal> createState() => _ResetPasswordModalState();
}

class _ResetPasswordModalState extends State<ResetPasswordModal> {
  final _keyForm = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Recuperar senha'),
      content: Form(
        key: _keyForm,
        child: TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(labelText: 'Endereço de E-mail'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Por favor, informe um endereço de E-mail válido';
            }
            return null;
          },
        ),
      ),
      actions: <TextButton>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            if (_keyForm.currentState!.validate()) {
              authService.passwordReset(email: _emailController.text).then((
                String? erro,
              ) {
                Navigator.of(context).pop();

                if (erro != null) {
                  final snackBar = SnackBar(content: Text(erro));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  final snackBar = SnackBar(
                    content: Text(
                      'Um link de redefinição de senha foi enviado ao seu email!',
                    ),
                    backgroundColor: Colors.green,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              });
            }
          },
          child: Text('Recuperar senha'),
        ),
      ],
    );
  }
}
