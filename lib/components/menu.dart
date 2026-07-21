import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horas_v3/services/auth_service.dart';

class Menu extends StatelessWidget {
  final User user;

  const Menu({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.displayName ?? 'User'),
            accountEmail: Text(user.email ?? 'No email'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.manage_accounts_rounded, size: 48),
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap: () {
              AuthService().logout();
            },
          ),
        ],
      ),
    );
  }
}
