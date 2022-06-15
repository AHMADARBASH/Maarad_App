import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:maarad_app/models/http_Exceptions.dart';
import 'package:maarad_app/reusable_Components/textformfield.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

// ignore: constant_identifier_names
enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const String routeaName = '/AuthScreen';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   Provider.of<Auth>(context, listen: false).PrintToken();
      // }),
      body: SingleChildScrollView(
        child: Stack(alignment: Alignment.center, children: [
          Column(children: [
            Stack(children: [
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                      child: Image.asset(
                        'images/food2.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                color: Colors.black12,
              ),
            ]),
          ]),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [AuthForm()],
          ),
        ]),
      ),
    );
  }
}

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  //initials vars
  bool _isloading = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _authmode = AuthMode.Login;
  var passInivisiilty = true;

  void passwordInvisiblity() {
    setState(() {
      passInivisiilty = !passInivisiilty;
    });
  }

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    _isloading = false;
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));

    _fadeAnimation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void showErrorDialog({String? message, String? title}) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              content: Text(message!),
              title: Text(
                title!,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('ok'))
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isloading = true;
    });
    if (_authmode == AuthMode.Login) {
      try {
        await Provider.of<Auth>(context, listen: false)
            .login(_usernameController.text, _passwordController.text);
      } on HTTPException catch (e) {
        showErrorDialog(message: e.message, title: 'Error');
        setState(() {
          _isloading = false;
        });
      } catch (e) {
        showErrorDialog(message: 'an Error Occured!', title: 'Error');
        setState(() {
          _isloading = false;
        });
      }
    } else {
      try {
        await Provider.of<Auth>(context, listen: false)
            .signup(_usernameController.text, _passwordController.text);
        showErrorDialog(message: 'Signed up Successfuly', title: 'Sign up');
        setState(() {
          _authmode = AuthMode.Login;
          _isloading = false;
          _usernameController.clear();
          _passwordController.clear();
        });
      } on HTTPException catch (e) {
        showErrorDialog(message: e.message, title: 'Error');
        setState(() {
          _isloading = false;
        });
      } catch (e) {
        showErrorDialog(message: 'an Error Occured!', title: 'Error');
        setState(() {
          _isloading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      _authmode = AuthMode.Login;
                    });
                  },
                  child: Column(
                    children: [
                      Text('Login',
                          style: TextStyle(
                              fontSize: 25,
                              color: _authmode == AuthMode.Login
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.white)),
                      _authmode == AuthMode.Login
                          ? const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Icon(
                                Icons.circle,
                                size: 10,
                              ),
                            )
                          : const Text('')
                    ],
                  )),
              Text(
                '|',
                style: TextStyle(
                    fontSize: 25, color: Theme.of(context).colorScheme.primary),
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      _authmode = AuthMode.Signup;
                    });
                  },
                  child: Column(
                    children: [
                      Text('SignUp',
                          style: TextStyle(
                              fontSize: 25,
                              color: _authmode == AuthMode.Signup
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.white)),
                      _authmode == AuthMode.Signup
                          ? const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Icon(
                                Icons.circle,
                                size: 10,
                              ),
                            )
                          : const Text('')
                    ],
                  )),
            ],
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.linear,
            width: double.infinity,
            height: _authmode == AuthMode.Login
                ? MediaQuery.of(context).size.height * 0.22
                : MediaQuery.of(context).size.height * 0.35,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 10, right: 10, left: 10),
                      //username text field
                      child: defaultTextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter a username';
                          }
                          return null;
                        },
                        context: context,
                        controller: _usernameController,
                        hintText: 'username',
                        inputAction: TextInputAction.next,
                        prefixIcon: const Icon(Icons.person),
                      )),
                  //password form field
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 5),
                      child: defaultTextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (value.length < 8) {
                            return 'Password must be Complex and 8 more characters';
                          }
                          return null;
                        },
                        context: context,
                        isVisiblePassword: passInivisiilty,
                        controller: _passwordController,
                        hintText: 'Password',
                        inputAction: _authmode == AuthMode.Login
                            ? TextInputAction.done
                            : TextInputAction.next,
                        prefixIcon: !passInivisiilty
                            ? const Icon(Icons.lock_open_outlined)
                            : const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: !passInivisiilty
                              ? const Icon(Icons.visibility_off_outlined)
                              : const Icon(Icons.visibility_outlined),
                          onPressed: () {
                            passwordInvisiblity();
                          },
                        ),
                      ),
                    ),
                  ),
                  if (_authmode == AuthMode.Signup)
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: defaultTextFormField(
                              context: context,
                              hintText: 'Confirm Password',
                              inputAction: TextInputAction.done,
                              isVisiblePassword: passInivisiilty,
                              prefixIcon: !passInivisiilty
                                  ? const Icon(Icons.lock_open_outlined)
                                  : const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: !passInivisiilty
                                    ? const Icon(Icons.visibility_off_outlined)
                                    : const Icon(Icons.visibility_outlined),
                                onPressed: () {
                                  passwordInvisiblity();
                                },
                              ),
                              validator: (value) {
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match!';
                                }
                                return null;
                              })),
                    ),
                ]),
              ),
            ),
          ),
          if (_authmode == AuthMode.Login)
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              TextButton(
                onPressed: () {},
                child: const Text('Forgot password?',
                    style: TextStyle(fontSize: 15, color: Colors.white)),
              )
            ]),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          GestureDetector(
            onTap: () {
              _submit();
              Provider.of<Auth>(context, listen: false)
                  .setUser(_usernameController.text);
            },
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 6,
                        color: Colors.grey.withOpacity(0.4),
                        offset: const Offset(-1, 5)),
                  ],
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      const Color(0xffe8db73)
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(550))),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.08,
              child: Center(
                child: _isloading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : _authmode == AuthMode.Login
                        ? const Text(
                            'Login',
                            style: TextStyle(fontSize: 25),
                          )
                        : const Text(
                            'Sign up',
                            style: TextStyle(fontSize: 25),
                          ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
