import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:maarad_app/screens/main_screen.dart';
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
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Column(children: [
          Stack(children: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
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
  final _isloading = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _authmode = AuthMode.Login;
  var passInivisiilty = false;

  void passwordInvisiblity() {
    setState(() {
      passInivisiilty = !passInivisiilty;
    });
  }

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    _fadeAnimation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
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
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 6,
                      color: Colors.grey.withOpacity(0.4),
                      offset: const Offset(-1, 5)),
                ],
                //Color(0xffebd300)
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    const Color(0xffe8db73)
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(15))),
            width: double.infinity,
            height: _authmode == AuthMode.Login
                ? MediaQuery.of(context).size.height * 0.22
                : MediaQuery.of(context).size.height * 0.33,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 10, right: 10, left: 10),
                    //username text field
                    child: TextFormField(
                      controller: _usernameController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          hintText: 'Username',
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              )),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Icon(Icons.person_outline),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              )),
                          fillColor: Colors.white,
                          filled: true),
                    ),
                  ),
                  //password form field
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 5),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: !passInivisiilty,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: !passInivisiilty
                                  ? const Icon(Icons.lock_outline)
                                  : const Icon(Icons.lock_open_outlined),
                            ),
                            suffixIcon: IconButton(
                              icon: !passInivisiilty
                                  ? const Icon(Icons.visibility_off_outlined)
                                  : const Icon(Icons.visibility_outlined),
                              onPressed: () {
                                passwordInvisiblity();
                              },
                            ),
                            border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                )),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                )),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                )),
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    ),
                  ),
                  if (_authmode == AuthMode.Signup)
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: TextFormField(
                          validator: _authmode == AuthMode.Signup
                              ? (value) {
                                  if (value != _passwordController.text) {
                                    return 'Passwords do not match!';
                                  }
                                  return null;
                                }
                              : null,
                          enabled: _authmode == AuthMode.Signup,
                          obscureText: !passInivisiilty,
                          decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: !passInivisiilty
                                    ? const Icon(Icons.lock_outline)
                                    : const Icon(Icons.lock_open_outlined),
                              ),
                              suffixIcon: IconButton(
                                icon: !passInivisiilty
                                    ? const Icon(Icons.visibility_off_outlined)
                                    : const Icon(Icons.visibility_outlined),
                                onPressed: () {
                                  passwordInvisiblity();
                                },
                              ),
                              border: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  )),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  )),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  )),
                              fillColor: Colors.white,
                              filled: true),
                        ),
                      ),
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
          if (_authmode == AuthMode.Login)
            GestureDetector(
              onTap: () {
                try {
                  print(_usernameController.text +
                      ' : ' +
                      _passwordController.text);
                  auth.login(
                      _usernameController.text, _passwordController.text);
                  Navigator.of(context).pushNamed(CategoriesScreen.routeName);
                } catch (e) {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            title: const Text('Please check your credentials'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text('ok'))
                            ],
                          ));
                }
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
                child: const Center(
                  child: (Text(
                    'Login',
                    style: TextStyle(fontSize: 25),
                  )),
                ),
              ),
            ),
          if (_authmode == AuthMode.Signup)
            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      const Color(0xffe8db73)
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(550)),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 6,
                        color: Colors.grey.withOpacity(0.4),
                        offset: const Offset(-1, 5)),
                  ],
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.08,
                child: const Center(
                  child: (Text(
                    'Sign up',
                    style: TextStyle(fontSize: 25),
                  )),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
