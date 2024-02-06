import 'package:flutter/material.dart';
import 'package:gym_logger_2/models/role.enum.dart';
import 'package:gym_logger_2/screens/auth/auth.service.dart';
import 'package:gym_logger_2/services/user.service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  String _role = Role.Sportsman.name;
  bool _isLogin = true;

  void _submit() async {
    final isValid = _form.currentState!.validate();
    String? loggedIn;

    if (!isValid) {
      return;
    }

    _form.currentState!.save();

    if (_isLogin) {
      loggedIn = await AuthService().login(_email, _password, context);
    } else {
      Role currentRole =
          _role == Role.Sportsman.name ? Role.Sportsman : Role.Trainer;
      loggedIn =
          await AuthService().signup(_email, _password, currentRole, context);
    }

    if (loggedIn == null) return;

    final user = await UserService().getUser(
      context,
    );
    print(user);
    if (user != null) {
      await Navigator.of(context).pushNamed('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email Adress',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email!';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _email = value!;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Password',
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Password should not be less then 6 symbols!';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _password = value!;
                            },
                          ),
                          if (!_isLogin)
                            DropdownButtonFormField<String?>(
                              value: _role,
                              items: <String>[
                                Role.Sportsman.name,
                                Role.Trainer.name,
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _role = newValue!;
                                });
                              },
                            ),
                          const SizedBox(
                            height: 12,
                          ),
                          ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                            child: Text(_isLogin ? 'Login' : 'Signup'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(_isLogin
                                ? 'Create an account'
                                : 'I have already an account.'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
