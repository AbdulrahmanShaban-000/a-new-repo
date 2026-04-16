
import 'package:college_project/login/LoginScreen.dart';
import 'package:flutter/material.dart';

class homePage  extends StatelessWidget {
  const homePage({super.key});

  @override

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.blue[900]!,
                Colors.blue[800]!,
                Colors.blue[400]!,
              ],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Team Work All",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 20),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 23),
                    child: Text(
                      "and we want to go to university and drink coffe and we want to go to university and drink coffe and we want to go to university and drink coffe",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: 50),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        padding: EdgeInsets.all(15),
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Loginscreen()),
                          );
                        },
                        child: Text(
                          "Login!!",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
    );
    }
}
