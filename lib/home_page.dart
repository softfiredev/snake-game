


import 'package:flutter/material.dart';
import 'package:snakegame/snake_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool dark = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: dark ? Colors.grey[600] : Colors.white,
        body: Center(
        child: Column(
          children: [
            const SizedBox(height: 400,),
            const SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const SnakePage()));
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: 200,
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: dark ? Colors.grey[400]: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            offset: Offset(4.0, 4.0),
                            blurRadius: 15.0,
                            spreadRadius: 1.0),
                        BoxShadow(
                            color: Colors.grey.shade500,
                            offset: Offset(-4.0, -4.0),
                            blurRadius: 15.0,
                            spreadRadius: 1.0),
                      ]),
                  child: Center(
                    child: Text("Start",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                  ),
                ),
              ),
            ),
          ],
        ),
        )
    );
  }
}

