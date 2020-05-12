import 'package:flutter/material.dart';
import 'progress.dart';
import 'util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

// Used for controlling whether the user is loggin or creating an account
enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  String _email = "";
  String _password = "";
  BuildContext pageContext;
  FormType _form = FormType
      .login; // our default setting is to login, and we should switch to creating an account when the user chooses to

  _LoginPageState() {
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
  }

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }

  // Swap in between our two forms, registering and logging in
  void _formChange() async {
    setState(() {
      if (_form == FormType.register) {
        _form = FormType.login;
      } else {
        _form = FormType.register;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    pageContext = context;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/login/Component_BG.png'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildTextFields(),
            SizedBox(
              height: 20,
            ),
            _buildButton(),
            SizedBox(
              height: 50,
            )
          ],
        ),
        alignment: Alignment.bottomCenter,
      ),
    );
  }

  Widget _buildTextFields() {
    return new Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: new Column(
        children: <Widget>[
          new Container(
            child: new TextField(
              controller: _emailFilter,
              style: TextStyle(color: Colors.white),
              decoration: new InputDecoration(
                  labelText: 'Username',
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  )),
            ),
          ),
          new Container(
            child: new TextField(
              controller: _passwordFilter,
              style: TextStyle(color: Colors.white),
              decoration: new InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  )),
              obscureText: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButton() {
    return InkWell(
      onTap: () {
        _loginPressed();
      },
      child: Container(
        width: 312.0,
        height: 40.0,
        alignment: FractionalOffset.center,
        decoration: new BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              getColorFromHex("#1371FC"),
              getColorFromHex("#9FB4E2"),
            ],
            stops: [0.2, 1.0],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
          ),
          borderRadius: new BorderRadius.all(const Radius.circular(30.0)),
        ),
        child: new Text(
          "LOGIN",
          style: new TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }

  // These functions can self contain any user auth logic required, they all have access to _email and _password

  void _loginPressed() {
    print('The user wants to login with $_email and $_password');
    Navigator.push(pageContext, MaterialPageRoute(builder: (context) {
      return Progress();
    }));
  }
}
