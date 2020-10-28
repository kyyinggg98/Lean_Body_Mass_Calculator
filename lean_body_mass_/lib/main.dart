import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(LeanBodyMass());

class LeanBodyMass extends StatefulWidget {
  @override
  _LeanBodyMassState createState() => _LeanBodyMassState();
}

class _LeanBodyMassState extends State<LeanBodyMass> {
  TextEditingController _height_controller = TextEditingController();
  TextEditingController _weight_controller = TextEditingController();

  int _gender = 0;
  int _age = 0;
  String _height = '';
  String _weight = '';
  double eLBMB = 0;
  double eLBMJ = 0;
  double eLBMH = 0;
  double eLBMP = 0;
  String percentageB = '0';
  String percentageJ = '0';
  String percentageH = '0';
  String percentageP = '0';
  String bodyFatB = '0';
  String bodyFatJ = '0';
  String bodyFatH = '0';
  String bodyFatP = '0';

  void _setGender(int value) => setState(() => _gender = value);
  void _setAge(int value) => setState(() => _age = value);
  //Calculate
  void _onPressed() {
    setState(() {
      _height = _height_controller.text;
      _weight = _weight_controller.text;

      if (_age == 0) {
        _petersFormula();
        _boerFormula();
        _jamesFormula();
        _humeFormula();
      } else if (_age == 1) {
        _boerFormula();
        _jamesFormula();
        _humeFormula();
        eLBMP = 0;
        percentageP = '0';
        bodyFatP = '0';
      }
    });
  }

  //Reset Button
  void _resetButton() {
    setState(() {
      _gender = null;
      _age = null;
      _height_controller.clear();
      _weight_controller.clear();
      eLBMJ = 0;
      eLBMH = 0;
      eLBMP = 0;
      percentageB = '0';
      percentageJ = '0';
      percentageH = '0';
      percentageP = '0';
      bodyFatB = '0';
      bodyFatJ = '0';
      bodyFatH = '0';
      bodyFatP = '0';
    });
  }

  //Boer Formula
  void _boerFormula() {
    double height = double.parse(_height);
    double weight = double.parse(_weight);
    double eLBM;

    if (_gender == 0) {
      //gender=male
      eLBM = 0.407 * weight + 0.267 * height - 19.2;
    } else if (_gender == 1) {
      //gender = female
      eLBM = 0.252 * weight + 0.473 * height - 48.3;
    }

    percentageB = (eLBM / weight * 100).toStringAsFixed(0);
    bodyFatB = (100 - (eLBM / weight * 100)).toStringAsFixed(0);
    eLBMB = double.parse(eLBM.toStringAsFixed(1));
  }

  //James Formula
  void _jamesFormula() {
    double height = double.parse(_height);
    double weight = double.parse(_weight);
    double eLBM;
    if (_gender == 0) {
      //gender=male
      eLBM = 1.1 * weight - 128 * (weight / height) * (weight / height);
    } else if (_gender == 1) {
      //gender = female
      eLBM = 1.07 * weight - 148 * (weight / height) * (weight / height);
    }

    percentageJ = (eLBM / weight * 100).toStringAsFixed(0);
    bodyFatJ = (100 - (eLBM / weight * 100)).toStringAsFixed(0);
    eLBMJ = double.parse(eLBM.toStringAsFixed(1));
  }

  //Hume Formula
  void _humeFormula() {
    double height = double.parse(_height);
    double weight = double.parse(_weight);
    double eLBM;
    if (_gender == 0) {
      //gender=male
      eLBM = 0.32810 * weight + 0.33929 * height - 29.5336;
    } else if (_gender == 1) {
      //gender = female
      eLBM = 0.29569 * weight + 0.41813 * height - 43.2933;
    }

    percentageH = (eLBM / weight * 100).toStringAsFixed(0);
    bodyFatH = (100 - (eLBM / weight * 100)).toStringAsFixed(0);
    eLBMH = double.parse(eLBM.toStringAsFixed(1));
  }

  //Peters Formula
  void _petersFormula() {
    double height = double.parse(_height);
    double weight = double.parse(_weight);
    double eLBM;

    double eECV = 0.0215 * pow(weight, 0.6469) * pow(height, 0.7236);
    eLBM = 3.8 * eECV;

    percentageP = (eLBM / weight * 100).toStringAsFixed(0);
    bodyFatP = (100 - (eLBM / weight * 100)).toStringAsFixed(0);
    eLBMP = double.parse(eLBM.toStringAsFixed(1));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lean Body Mass',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amberAccent[400],
          title: Text('Lean Body Mass Calculator'),
        ),
        body: Container(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(50, 20, 0, 0),
                  child: new Text(
                    'Gender',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(45, 2, 0, 10),
                child: Row(
                  children: [
                    Container(
                      width: 150,
                      height: 40,
                      child: new RadioListTile(
                        activeColor: Colors.amberAccent[400],
                        value: 0,
                        groupValue: _gender,
                        onChanged: _setGender,
                        title: new Text('Male'),
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 40,
                      child: new RadioListTile(
                        activeColor: Colors.amberAccent[400],
                        value: 1,
                        groupValue: _gender,
                        onChanged: _setGender,
                        title: new Text('Female'),
                      ),
                    ),
                  ],
                ),
              ),

              //_Age
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(50, 10, 0, 0),
                  child: new Text(
                    'Age 14 or younger? ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(45, 5, 0, 5),
                child: Row(
                  children: [
                    Container(
                      width: 150,
                      height: 40,
                      child: new RadioListTile(
                        activeColor: Colors.amberAccent[400],
                        value: 0,
                        groupValue: _age,
                        onChanged: _setAge,
                        title: new Text('Yes'),
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 40,
                      child: new RadioListTile(
                        activeColor: Colors.amberAccent[400],
                        value: 1,
                        groupValue: _age,
                        onChanged: _setAge,
                        title: new Text('No'),
                      ),
                    ),
                  ],
                ),
              ),

              //Height
              Container(
                height: 125,
                // color: Colors.lightGreen,
                margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                      height: 150,
                      width: 150,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                            child: new Text(
                              'Height ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: _height_controller,
                              decoration: InputDecoration(
                                hintText: 'e.g.160',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 5,
                                  ),
                                ),
                              ),
                              autocorrect: true,
                              autofocus: true,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //cm text
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: new Text(
                        'cm',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    //Weight
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      height: 150,
                      width: 150,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                            child: new Text(
                              'Weight ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: _weight_controller,
                              decoration: InputDecoration(
                                hintText: 'e.g. 50',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 5,
                                  ),
                                ),
                              ),
                              autocorrect: true,
                              autofocus: true,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //kg label
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: new Text(
                        'kg',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                  //Calculate button
                  Container(
                    margin: EdgeInsets.fromLTRB(70, 0, 50, 0),
                    child: new RaisedButton(
                      onPressed: _onPressed,
                      child: Text(
                        'Calculate',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      color: Colors.amber,
                    ),
                  ),
                  //Reset button
                  Container(
                    child: new RaisedButton(
                      onPressed: _resetButton,
                      child: Text(
                        'Reset',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
              Container(
                height: 310,
                width: 500,
                // color: Colors.blueAccent[100],
                child: Column(
                  children: [
                    //Result label
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 12),
                      child: new Text(
                        'Result ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    //Title of the Table
                    Row(
                      children: [
                        //Formula label
                        Container(
                          margin: EdgeInsets.fromLTRB(2, 0, 2, 2),
                          alignment: Alignment.center,
                          color: Colors.amber,
                          height: 50,
                          width: 100,
                          child: new Text(
                            'Formula',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //Lean Body Mass label
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 2, 2),
                          alignment: Alignment.center,
                          color: Colors.amber,
                          height: 50,
                          width: 162,
                          child: new Text(
                            "Lean Body Mass",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //Body Fat label
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 2, 2),
                          alignment: Alignment.center,
                          color: Colors.amber,
                          height: 50,
                          width: 122,
                          child: new Text(
                            'Body Fat',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //Boer
                    Row(
                      children: [
                        //Boer label
                        Container(
                          margin: EdgeInsets.fromLTRB(2, 0, 2, 2),
                          alignment: Alignment.center,
                          color: Colors.amber,
                          height: 50,
                          width: 100,
                          child: new Text(
                            'Boer',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //Boer Mass label
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 2, 2),
                          alignment: Alignment.center,
                          color: Colors.amberAccent[100],
                          height: 50,
                          width: 162,
                          child: new Text(
                            "${eLBMB} kg ( ${percentageB}% )",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        //Body Fat Boer
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 2, 2),
                          alignment: Alignment.center,
                          color: Colors.amberAccent[100],
                          height: 50,
                          width: 122,
                          child: new Text(
                            "${bodyFatB}%",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //James
                    Row(
                      children: [
                        //James label
                        Container(
                          margin: EdgeInsets.fromLTRB(2, 0, 2, 2),
                          alignment: Alignment.center,
                          color: Colors.amber,
                          height: 50,
                          width: 100,
                          child: new Text(
                            'James',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //Mass label
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 2, 2),
                          alignment: Alignment.center,
                          color: Colors.amberAccent[100],
                          height: 50,
                          width: 162,
                          child: new Text(
                            "${eLBMJ} kg ( ${percentageJ}% )",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        //Body Fat James
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 2, 2),
                          alignment: Alignment.center,
                          color: Colors.amberAccent[100],
                          height: 50,
                          width: 122,
                          child: new Text(
                            "${bodyFatJ}%",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //Hume
                    Row(
                      children: [
                        //Hume label
                        Container(
                          margin: EdgeInsets.fromLTRB(2, 0, 2, 2),
                          alignment: Alignment.center,
                          color: Colors.amber,
                          height: 50,
                          width: 100,
                          child: new Text(
                            'Hume',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //Mass label Hume
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 2, 2),
                          alignment: Alignment.center,
                          color: Colors.amberAccent[100],
                          height: 50,
                          width: 162,
                          child: new Text(
                            "${eLBMH} kg ( ${percentageH}% )",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        //Body Fat Hume
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 2, 2),
                          alignment: Alignment.center,
                          color: Colors.amberAccent[100],
                          height: 50,
                          width: 122,
                          child: new Text(
                            "${bodyFatH}%",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        //Peters label
                        Container(
                          margin: EdgeInsets.fromLTRB(2, 0, 2, 2),
                          alignment: Alignment.center,
                          color: Colors.amber,
                          height: 50,
                          width: 100,
                          child: new Text(
                            'Peters',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //Mass label Peters
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 2, 2),
                          alignment: Alignment.center,
                          color: Colors.amberAccent[100],
                          height: 50,
                          width: 162,
                          child: new Text(
                            "${eLBMP} kg ( ${percentageP}% )",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        //Body Fat Peter
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 2, 2),
                          alignment: Alignment.center,
                          color: Colors.amberAccent[100],
                          height: 50,
                          width: 122,
                          child: new Text(
                            "${bodyFatP}%",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
