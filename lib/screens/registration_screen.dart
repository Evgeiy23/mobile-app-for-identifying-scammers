import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _firstName = '';
  String _lastName = '';
  String _nickname = '';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // First name
                TextFormField(
                  decoration: const InputDecoration(labelText: 'First Name'),
                  onSaved: (val) => _firstName = val?.trim() ?? '',
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                // Last name
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  onSaved: (val) => _lastName = val?.trim() ?? '',
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                // Email/Phone (login)
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email or Phone (login)',
                  ),
                  onSaved: (val) => _email = val?.trim() ?? '',
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter your email or phone';
                    }
                    return null;
                  },
                ),
                // Nick
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nickname'),
                  onSaved: (val) => _nickname = val?.trim() ?? '',
                ),
                // Password
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onSaved: (val) => _password = val?.trim() ?? '',
                  validator: (val) {
                    if (val == null || val.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    final form = _formKey.currentState;
                    if (form != null && form.validate()) {
                      form.save();
                      final success = await authProvider.register(
                        email: _email,
                        password: _password,
                        firstName: _firstName,
                        lastName: _lastName,
                        nickname: _nickname,
                      );
                      if (success) {
                        if (!mounted) return;
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Registration success!')),
                        );
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context); // назад
                      } else {
                        if (!mounted) return;
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('User already exists!')),
                        );
                      }
                    }
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
