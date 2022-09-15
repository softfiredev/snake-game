

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SnakePage extends StatefulWidget {
  const SnakePage({Key? key}) : super(key: key);

  @override
  State<SnakePage> createState() => _SnakePageState();
}

class _SnakePageState extends State<SnakePage> {
  List<int> _snake = [45,65,85,105,125];
  int _numberofpixel = 500;

  static var _randomtarget = Random();
  int _target = _randomtarget.nextInt(500);
  void _newtarget(){
    _target = _randomtarget.nextInt(500);
  }
  bool _dark = false;

  void _start() {
    _snake = [45,65,85,105,125];
    Timer.periodic(const Duration(milliseconds: 300), (timer) {
      _updateposition();
      if(die()){
        timer.cancel();
        _showresult();
      }
    });
  }
  var _direction = 'down';
  void _updateposition() {
    setState((){
      switch (_direction) {
        case 'down' :
          if(_snake.last > 480){
            _snake.add(_snake.last + 20 - 500);
          }else {
            _snake.add(_snake.last + 20);
          }
          break;

        case 'up' :
          if(_snake.last < 20){
            _snake.add(_snake.last - 20 + 500);
          }else {
            _snake.add(_snake.last - 20);
          }
          break;

        case 'left' :
          if(_snake.last % 20 == 0){
            _snake.add(_snake.last - 1 + 20);
          }else {
            _snake.add(_snake.last - 1);
          }
          break;

        case 'right' :
          if((_snake.last + 1) % 20 == 0){
            _snake.add(_snake.last + 1 - 20);
          }else {
            _snake.add(_snake.last + 1);
          }
          break;

        default:
      }

      if(_snake.last == _target){
        _newtarget();
      }else{
        _snake.removeAt(0);
      }

    });
  }


  bool die() {
    for(int i = 0 ; i< _snake.length; i++){
      int count = 0;
      for(int k = 0 ; k < _snake.length; k++){
        if(_snake[i] == _snake[k]){
          count += 1;
        }
        if(count == 2){
          return true;
        }
      }
    }
    return false;
  }

  void _showresult() {
    showDialog(context: context,
        builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Game Over"),
        content: Text("Your Score = ${_snake.length - 5}",style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
        actions: [
          InkWell(
            onTap: () {


              _start();
            },
            child: Text("Try again",style: const TextStyle(fontSize: 18, color: Colors.blue),),
          )
        ],
      );
        }
    );
  }

  @override
  void initState() {
    _start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _dark ? Colors.black : Colors.grey.shade500,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          FlutterSwitch(
            value: _dark,
            onToggle: (bool value) {
              setState((){
                _dark = value;
              });
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: GridView.builder(
                  itemCount: _numberofpixel,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 20
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if(_snake.contains(index)){
                      return Center(
                        child: Container(
                          padding: EdgeInsets.all(2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              color: _dark ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    }
                    if(index == _target){
                      return Container(
                        padding: EdgeInsets.all(2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            color: _dark ? Colors.yellow : Colors.red,
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        padding: EdgeInsets.all(2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            color: _dark ? Colors.grey[900] : Colors.white,
                          ),
                        ),
                      );
                    }
                  }
              ),

          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0, right: 20.0,left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 75,
                      height: 75,
                    ),
                    GestureDetector(
                      onTap: (){
                        setState((){
                          _direction = 'left';
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 50,
                          height: 55,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[500],
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade500,
                                    offset: Offset(4.0, 4.0),
                                    blurRadius: 15.0,
                                    spreadRadius: 1.0),
                                BoxShadow(
                                    color: Colors.grey.shade800,
                                    offset: Offset(-4.0, -4.0),
                                    blurRadius: 15.0,
                                    spreadRadius: 1.0),
                              ]),
                          child: Center(
                            child: Icon(
                              Icons.arrow_left_rounded,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 75,
                      height: 75,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState((){
                          _direction = 'up';
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 50,
                          height: 55,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[500],
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade500,
                                    offset: Offset(4.0, 4.0),
                                    blurRadius: 15.0,
                                    spreadRadius: 1.0),
                                BoxShadow(
                                    color: Colors.grey.shade800,
                                    offset: Offset(-4.0, -4.0),
                                    blurRadius: 15.0,
                                    spreadRadius: 1.0),
                              ]),
                          child: Center(
                            child: Icon(
                              Icons.arrow_drop_up_rounded,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 75,
                      height: 75,
                    ),
                    GestureDetector(
                      onTap: (){
                        setState((){
                          _direction = 'down';
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 50,
                          height: 55,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[500],
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade500,
                                    offset: Offset(4.0, 4.0),
                                    blurRadius: 15.0,
                                    spreadRadius: 1.0),
                                BoxShadow(
                                    color: Colors.grey.shade800,
                                    offset: Offset(-4.0, -4.0),
                                    blurRadius: 15.0,
                                    spreadRadius: 1.0),
                              ]),
                          child: Center(
                            child: Icon(
                              Icons.arrow_drop_down_rounded,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 75,
                      height: 75,
                    ),
                      GestureDetector(
              onTap: (){
                setState((){
                  _direction = 'right';
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: 50,
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[500],
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade500,
                            offset: Offset(4.0, 4.0),
                            blurRadius: 15.0,
                            spreadRadius: 1.0),
                        BoxShadow(
                            color: Colors.grey.shade800,
                            offset: Offset(-4.0, -4.0),
                            blurRadius: 15.0,
                            spreadRadius: 1.0),
                      ]),
                  child: Center(
                    child: Icon(
                      Icons.arrow_right_rounded,
                      size: 50,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
                    Container(
                      width: 75,
                      height: 75,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
