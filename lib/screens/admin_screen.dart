import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../fake_database.dart';
import '../../models/user.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (!authProvider.isAdmin) {
      return Scaffold(
        appBar: AppBar(title: const Text('Admin Panel')),
        body: const Center(child: Text('Access denied: Admins only.')),
      );
    }

    final users = FakeDatabase.getAllUsers();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'List of all registered users:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final User u = users[index];
                  return ListTile(
                    title: Text('${u.firstName} ${u.lastName}'),
                    subtitle: Text(
                      'ID: ${u.id}, Email: ${u.email}, Nick: ${u.nickname}',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
