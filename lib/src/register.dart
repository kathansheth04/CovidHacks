import 'package:CovidHacksApp/src/Stats.dart';
import 'package:CovidHacksApp/src/home.dart';
import 'package:CovidHacksApp/src/mainGuidelines.dart';
import 'package:CovidHacksApp/src/login.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(RegisterScreen());
}

class RegisterScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _nameController = TextEditingController();
TextEditingController _stateController = TextEditingController();

class _MyHomePageState extends State<MyHomePage> {
  Future<FirebaseUser> _handleSignUp(String email, String password) async {
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
    print('Signed user up: ');
    uploadData();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MainGuidelineScreen()));
  }

  void uploadData() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    FirebaseDatabase.instance.reference().child(user.uid).set(
        {'companyName': _nameController.text, 'state': _stateController.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              new Container(
                  margin: EdgeInsets.only(top: 30),
                  height: 155.0,
                  width: 95.0,
                  child: Image.asset('lib/src/assets/logo.png')),
              new Container(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Colors.deepOrange),
                    ),
                    border: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.orange, width: 2.0),
                    ),
                    hintText: 'Ex. example123@example.com',
                    prefixIcon: Icon(Icons.mail),
                    labelText: 'Email Address',
                    contentPadding:
                        new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  ),
                  validator: (input) =>
                      input.isEmpty ? 'You must enter an email' : null,
                ),
              ),
              new Container(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _passwordController,
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Colors.deepOrange),
                    ),
                    border: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.orange, width: 2.0),
                    ),
                    hintText: 'Enter your password here',
                    prefixIcon: Icon(Icons.security),
                    labelText: 'Password',
                    contentPadding: new EdgeInsets.fromLTRB(
                      20.0,
                      10.0,
                      20.0,
                      10.0,
                    ),
                  ),
                  obscureText: true,
                  validator: (input) =>
                      input.isEmpty ? 'You must enter a password' : null,
                ),
              ),
              new Container(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Colors.deepOrange),
                    ),
                    border: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.orange, width: 2.0),
                    ),
                    hintText: 'Enter your password here',
                    prefixIcon: Icon(Icons.check_box),
                    labelText: 'Confirm Password',
                    contentPadding: new EdgeInsets.fromLTRB(
                      20.0,
                      10.0,
                      20.0,
                      10.0,
                    ),
                  ),
                  obscureText: true,
                  validator: (input) =>
                      input.isEmpty ? 'You must enter a password' : null,
                ),
              ),
              new Container(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Colors.deepOrange),
                    ),
                    border: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.orange, width: 2.0),
                    ),
                    hintText: 'Enter your company name here',
                    prefixIcon: Icon(Icons.business_center),
                    labelText: 'Company Name',
                    contentPadding: new EdgeInsets.fromLTRB(
                      20.0,
                      10.0,
                      20.0,
                      10.0,
                    ),
                  ),
                  validator: (input) =>
                      input.isEmpty ? 'You must enter a password' : null,
                ),
              ),
              new Container(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _stateController,
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Colors.deepOrange),
                    ),
                    border: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.orange, width: 2.0),
                    ),
                    hintText: 'Location of Company, ex. California',
                    prefixIcon: Icon(Icons.location_on),
                    labelText: 'State',
                    contentPadding: new EdgeInsets.fromLTRB(
                      20.0,
                      10.0,
                      20.0,
                      10.0,
                    ),
                  ),
                  validator: (input) =>
                      input.isEmpty ? 'You must enter a password' : null,
                ),
              ),
              new Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.all(10.0),
                child: RaisedButton.icon(
                    onPressed: () {
                      this._handleSignUp(_emailController.text.trim(),
                          _passwordController.text);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7.0))),
                    label:
                        Text('Log in', style: TextStyle(color: Colors.white)),
                    icon:
                        Icon(Icons.supervised_user_circle, color: Colors.white),
                    padding: const EdgeInsets.all(13.0),
                    textColor: Colors.white,
                    splashColor: Colors.red,
                    color: Colors.transparent),
              ),
              new Container(
                margin:
                    EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 15),
                child: RaisedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/register');
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7.0))),
                    label: Text('Sign up with Google',
                        style: TextStyle(color: Colors.white)),
                    icon: Icon(
                      Icons.explore,
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(13.0),
                    textColor: Colors.white,
                    splashColor: Colors.red,
                    color: Colors.transparent),
              ),
              new InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text(
                  'Sign in with an existing account',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
