import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String errorText = 'Invalid input';
  bool isError = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textEditingController = TextEditingController();

  Color mycolor(bool isError) {
    if (isError) {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }

  Widget getIcon(bool isError) {
    if (isError) {
      return Icon(Icons.description,color: Colors.red,);
    } else {
      return Icon(
        Icons.description,
        size: 0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: new TextFormField(
                        onTap: () {
                          setState(() {
                            isError = false;
                            mycolor(isError);
                          });
                        },
                        style: TextStyle(color: mycolor(isError)),
                        validator: (value) {
                          if (value.isEmpty) {
                            setState(() {
                              isError = true;
                            });
                            _textEditingController.text = errorText;
                          }

                          return null;
                        },
                        controller: _textEditingController,
                        decoration: new InputDecoration(
                            suffixIcon: getIcon(isError),
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(24.0),
                              ),
                            ),
                            filled: true,
                            hintStyle: new TextStyle(color: Colors.grey[800]),
                            hintText: "Type in your text",
                            fillColor: Colors.white70),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Processing Data')));
                        }
                      },
                      child: Text('Submit'),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
