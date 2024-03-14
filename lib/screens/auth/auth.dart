import 'package:flutter/material.dart';
import 'package:gym_logger_2/models/role.enum.dart';
import 'package:gym_logger_2/screens/auth/auth.service.dart';
import 'package:gym_logger_2/services/user.service.dart';
import 'package:gym_logger_2/widgets/buttons/elevated_button.dart';
import 'package:gym_logger_2/widgets/buttons/text_button.dart';
import 'package:gym_logger_2/widgets/form-controls/dropdown_button_field.dart';
import 'package:gym_logger_2/widgets/form-controls/text_form_field.dart';

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
                          GymTextFormField(
                            label: 'Email Adress',
                            keyboardType: TextInputType.emailAddress,
                            validate: (value) {
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
                          const SizedBox(
                            height: 10,
                          ),
                          GymTextFormField(
                            label: 'Password',
                            obscureText: true,
                            validate: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Password should not be less then 6 symbols!';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _password = value!;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (!_isLogin)
                            GymDropdownButtonField(
                              value: _role,
                              items: [
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
                              onChange: (newValue) {
                                setState(() {
                                  _role = newValue!;
                                });
                              },
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          GymElevatedButton(
                            onPress: _submit,
                            child: Text(_isLogin ? 'Login' : 'Signup'),
                          ),
                          GymTextButton(
                            onPress: () {
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
