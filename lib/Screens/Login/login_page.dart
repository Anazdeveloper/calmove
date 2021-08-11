import 'package:calmove/Screens/DoctorsList/doctors_list_bloc.dart';
import 'package:calmove/Screens/DoctorsList/doctors_list_page.dart';
import 'package:calmove/UIComponents/app_text.dart';
import 'package:calmove/Screens/Login/login_bloc.dart';
import 'package:calmove/UIComponents/progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }

}

class LoginPageState extends State<LoginPage> {

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final blocprovider = BlocProvider.of<LoginBloc>(context);
    TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 20.0);
    TextStyle linkStyle = TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold);
    return SafeArea (
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          extendBodyBehindAppBar: true,
          body: Container(
            child: SingleChildScrollView(
              child: Form (
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 60.0),
                      child: Container(
                        width: 125.0,
                        height: 125.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/abeerLogo.webp',
                            ),
                            fit: BoxFit.fill
                          )
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        'Welcome!',
                        style: TextStyle(
                          color: Colors.cyan[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: const Text(
                        'Login to your account',
                        style: TextStyle(
                            color: Colors.grey,
                            //fontWeight: FontWeight.bold,
                            //fontSize: 35.0
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 150.0, left: 25.0, right: 25.0),
                      child: TextField(
                        controller: username,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.mail_outlined,
                            color: Colors.cyan,
                          ),
                          labelText: 'Email*',
                          labelStyle: TextStyle(
                            color: Colors.cyan,
                            fontSize: 20.0
                          )
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top:20.0, left: 25.0, right: 25.0),
                      child: TextField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(
                              Icons.lock_outlined,
                              color: Colors.cyan,
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                },
                                icon: const Icon(
                                  Icons.visibility_outlined,
                                  color: Colors.grey,
                                )),
                            labelText: 'Password*',
                            labelStyle: const TextStyle(
                                color: Colors.cyan,
                                fontSize: 20.0
                            )
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 25.0),
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {

                        },
                        child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                            color: Colors.cyan
                        ),
                      ),
                      ),
                    ),
                    BlocListener(
                      bloc: blocprovider,
                      listener: (context, state) {
                        if(state is LoginErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: AppText(text: state.message,maxLines: 2,)));
                        }
                        if(state is LoginSuccessfulState) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: AppText(text: state.message,maxLines: 2,)));
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider(create: (context) => DoctorsListBloc(), child: DoctorsListPage(),)));
                        }
                      },
                      child: BlocBuilder(
                        bloc: blocprovider,
                        builder: (context, state) {
                          if(state is LoginInputIsProcessing) {
                            return Progress();
                          }
                          return Container(
                            constraints: const BoxConstraints.tightFor(width: 350.0, height: 75.0),
                            padding: const EdgeInsets.only(top: 30.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25.0),
                                      )
                                  )
                              ),
                              onPressed: () {
                                blocprovider.add(LoginInputLoaded(username.text, password.text));
                              },
                              child: const Text(
                                'SIGN IN',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: RichText(
                        text: TextSpan(
                          style: defaultStyle,
                          children: <TextSpan>[
                            TextSpan(text: 'Dont have an account?'),
                            TextSpan(
                              text: 'Sign Up',
                              style: linkStyle,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {

                                }
                            )
                          ]
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}