 
import 'package:college_project/login/Regester.dart';
import 'package:college_project/login/homePage.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});
  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool isVisible = false; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.settings, color: Colors.white),
          onPressed: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
                colors: [
                  Colors.blue[400]!,
                  Colors.blue[500]!,
                  Colors.blue[400]!,
                ],
            ),
          ),
        ),
        title: Text(
          "General Settings",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.blue[400]!,
              Colors.blue[500]!,
              Colors.blue[400]!,
            ],
          ),
        ),
        child: Center(
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            opacity: isVisible ? 1.0 : 0.0,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.grey.shade200,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    padding: EdgeInsets.all(14),
                    color: Color.fromARGB(255, 33, 150, 243),
                    onPressed:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Regester()));
                    },
                    child: Text("Edit Register",
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),),
                  SizedBox(height: 20,),
                  MaterialButton(
                    padding: EdgeInsets.all(14),
                    color: Color.fromARGB(255, 33, 150, 243),
                    onPressed:(){
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context)=>homePage()), (route) => false,
                      );
                    },child: Text("Exit!!",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
