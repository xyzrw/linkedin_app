import 'package:flutter/material.dart';
import 'package:linkedin_app/utils/consts.dart';
import 'package:linkedin_app/viewmodels/auth_viewmodel.dart';
import 'package:linkedin_app/views/home.dart';
import 'package:provider/provider.dart';

class AuthView extends StatefulWidget {
  final bool isLogin;
  const AuthView({super.key, required this.isLogin});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  // Text controllers
  final _emailController = TextEditingController(text: 'test@test.com');
  final _passwordController = TextEditingController(text: '12345678');
  final _formKey = GlobalKey<FormState>();

  // Toggle bool values
  bool _isObsecure = true;
  bool _rememberMe = true;
  late bool _isLogin;

  // Text styles
  final _defaultTextStyle = TextStyle(color: Colors.grey.shade800);
  final _highlightTextStyle = TextStyle(
    color: Color.fromRGBO(0, 119, 181, 1),
    fontWeight: FontWeight.w500,
  );

  double height(double height) => MediaQuery.of(context).size.height * height;

  // Reusable texspan
  TextSpan _textSpan(String text, {bool highlightText = false}) {
    return TextSpan(
      text: text,
      style: highlightText ? _highlightTextStyle : _defaultTextStyle,
    );
  }

  // Authenticate user
  void _handleAuth(AuthViewmodel authViewModel) {
    if (_formKey.currentState!.validate()) {
      bool isAuth = authViewModel.authUser(
        _isLogin,
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      if (!isAuth) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isLogin ? 'Invalid credentials' : 'Failed to sign up',
            ),
          ),
        );
        return;
      }
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  void initState() {
    _isLogin = widget.isLogin;
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Auth View Model
    final authViewModel = Provider.of<AuthViewmodel>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height(0.12)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                      height: 50,
                      width: 120,
                    ),
                  ],
                ),
              ),
              SizedBox(height: height(0.05)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  _isLogin ? 'Sign In' : 'Join LinkedIn',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height(0.02)),
                            Row(
                              children: [
                                Text(
                                  'Or ',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 16,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isLogin = !_isLogin;
                                    });
                                  },
                                  child: Text(
                                    _isLogin ? 'Join LinkedIn' : 'Sign In',
                                    style: _highlightTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height(0.02)),
                            Center(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(height: 10),
                                    // Email text field
                                    TextFormField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                      ),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Email cannot be empty';
                                        }
                                        final bool emailValid = RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                                        ).hasMatch(value);
                                        if (!emailValid) {
                                          return 'Please enter a correct email';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: height(0.025)),
                                    // Password text field
                                    TextFormField(
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _isObsecure
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _isObsecure = !_isObsecure;
                                            });
                                          },
                                        ),
                                      ),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      obscureText: _isObsecure,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Password cannot be empty';
                                        }
                                        if (value.length < 8) {
                                          return 'Password should have at least 8 characters';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: height(0.035)),
                                    if (_isLogin)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: Checkbox(
                                              value: _rememberMe,
                                              onChanged: (value) {
                                                setState(() {
                                                  _rememberMe = value ?? false;
                                                });
                                              },
                                              activeColor:
                                                  Colors.green.shade800,
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          const Text('Remember me'),
                                        ],
                                      ),
                                    SizedBox(height: height(0.02)),
                                    _isLogin
                                        ? Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: Text(
                                                'Forgot password?',
                                                style: _highlightTextStyle
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        )
                                        : RichText(
                                          text: TextSpan(
                                            children: [
                                              _textSpan(
                                                'By clicking Agree & Join or Continue, you agree to the LinkedIn ',
                                              ),
                                              _textSpan(
                                                'User Agreement, ',
                                                highlightText: true,
                                              ),
                                              _textSpan(
                                                'Privacy Policy',
                                                highlightText: true,
                                              ),
                                              _textSpan(', and '),
                                              _textSpan(
                                                'Cookie Policy',
                                                highlightText: true,
                                              ),
                                              _textSpan(
                                                '. For phone number signups we will send a verification code via SMS.',
                                              ),
                                            ],
                                          ),
                                        ),
                                    SizedBox(height: height(0.05)),
                                    // Authenticate button
                                    SizedBox(
                                      width: double.maxFinite,
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed:
                                            () => _handleAuth(authViewModel),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                primaryColor,
                                              ),
                                          foregroundColor:
                                              WidgetStatePropertyAll(
                                                Colors.white,
                                              ),
                                        ),
                                        child: Text(
                                          _isLogin
                                              ? 'Continue'
                                              : 'Agree & Join',
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
