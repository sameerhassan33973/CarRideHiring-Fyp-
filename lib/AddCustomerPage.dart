// ignore: file_names
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'CustomerHomePage.dart';
import 'LoginPage.dart';

class AddCustomerPage extends StatefulWidget {
  String email;
  AddCustomerPage({Key? key, required this.email}) : super(key: key);

  @override
  State<AddCustomerPage> createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  final _fname = TextEditingController();

  final _lname = TextEditingController();
  bool song = true;
  bool smk = false;
  late SnackBar sb;

  final _phone = TextEditingController();

  final _address = TextEditingController();

  String? _message;

  Future<void> postdata() async {
    var response = await http.post(
        Uri.parse("http://192.168.0.117/Project/api/Customer/addCustomer"),
        body: {
          "fname": _fname.text,
          "lname": _lname.text,
          "address": _address.text,
          "phone": _phone.text,
          "email": widget.email,
        });
    if (response.statusCode == 200) {
      var _messsage = response.body.toString();
      sb = SnackBar(content: Text('$_messsage'));
      ScaffoldMessenger.of(context).showSnackBar(sb);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CustomerHomePage()));
    } else {
      _message = response.body.toString();
      sb = SnackBar(content: Text('$_message'));
      ScaffoldMessenger.of(context).showSnackBar(sb);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CustomerLoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Give Your Information',
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Colors.lightBlueAccent,
                Colors.lightBlue,
                Colors.blueAccent,
              ])),
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            children: [
              SizedBox(
                height: 20.0,
              ),
              Container(
                color: Colors.white,
                child: TextField(
                  controller: _fname,
                  decoration: InputDecoration(
                    hintText: 'First Name',
                    hintStyle: TextStyle(fontSize: 20.0),
                    border: UnderlineInputBorder(),
                    filled: true,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                color: Colors.white,
                child: TextField(
                  controller: _lname,
                  decoration: InputDecoration(
                    hintText: 'LastName',
                    hintStyle: TextStyle(fontSize: 20.0),
                    border: UnderlineInputBorder(),
                    filled: true,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                color: Colors.white,
                child: TextField(
                  controller: _phone,
                  decoration: InputDecoration(
                    hintText: 'Contact No',
                    hintStyle: TextStyle(fontSize: 20.0),
                    border: UnderlineInputBorder(),
                    filled: true,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                color: Colors.white,
                child: TextField(
                  controller: _address,
                  decoration: InputDecoration(
                    hintText: 'Address',
                    hintStyle: TextStyle(fontSize: 20.0),
                    border: UnderlineInputBorder(),
                    filled: true,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Column(
                children: [
                  Divider(
                    color: Colors.white,
                  ),
                  Text("Select Your Habits",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          decoration: TextDecoration.underline)),
                  Row(
                    children: [
                      Text("Do You Smoke?",
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      Checkbox(
                          value: this.smk,
                          onChanged: (smok) {
                            setState(() {
                              this.smk = smok!;
                            });
                          })
                    ],
                  ),
                  Row(
                    children: [
                      Text("Do You Listen Songs?",
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      Checkbox(
                          checkColor: Colors.greenAccent,
                          activeColor: Colors.red,
                          value: this.song,
                          onChanged: (son) {
                            setState(() {
                              this.song = son!;
                              print(song);
                            });
                          })
                    ],
                  ),
                  Divider(color: Colors.white),
                  ButtonTheme(
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_fname.text == "" ||
                            _lname.text == "" ||
                            _phone.text == "" ||
                            _address == "") {
                          sb = SnackBar(
                              content: Text('Empty Fields Are Not Allowed'));
                          ScaffoldMessenger.of(context).showSnackBar(sb);
                        } else {
                          postdata();
                        } //move to verification page to verify email
                      },
                      child: Text(
                        'Sign Up',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Already have an account?',
                        style: TextStyle(fontSize: 10.0),
                      ),
                      TextButton(
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          //Move To Login page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomerLoginPage()),
                          );
                        },
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
