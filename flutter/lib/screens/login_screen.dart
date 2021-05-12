import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kampusku/screens/home_screen.dart';
import 'package:kampusku/utils/models/user_model.dart';
import 'package:kampusku/utils/repositories/auth_repo.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _secureStorage = FlutterSecureStorage();
  final _formLoginKey = GlobalKey<FormState>();
  bool _obscureText = true;

  TextEditingController _emailEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();

  Future<void> _checkLogin() async {
    try {
      bool isFormValid = _formLoginKey.currentState.validate();
      if (!isFormValid) {
        return;
      }
      _formLoginKey.currentState.save();

      UserRequest _userRequest = UserRequest(
        email: _emailEditingController.text,
        password: _passwordEditingController.text,
      );

      UserResponse response = await AuthRepository.checkLogin(_userRequest);

      if (response == null) {
        await _secureStorage.write(
            key: "userData", value: response.toRawJson());
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      }
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            foregroundDecoration: BoxDecoration(
              color: Colors.transparent.withOpacity(0.5),
            ),
            child: Image.asset(
              "assets/login.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Form(
            key: _formLoginKey,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  SizedBox(
                    height: 200,
                  ),
                  Card(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _emailEditingController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Type your email here...",
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _passwordEditingController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Type your password here...",
                              prefixIcon: Icon(Icons.lock_outline),
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(
                                  _obscureText
                                      ? Icons.remove_red_eye
                                      : Icons.remove_red_eye_outlined,
                                ),
                              ),
                            ),
                            textInputAction: TextInputAction.done,
                            obscureText: _obscureText,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          RaisedButton(
                            color: Colors.blueAccent,
                            onPressed: () async => _checkLogin(),
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
