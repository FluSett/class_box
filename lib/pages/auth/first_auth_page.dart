import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class FirstAuthPage extends StatefulWidget {
  const FirstAuthPage({Key? key}) : super(key: key);

  @override
  FirstAuthPageState createState() => FirstAuthPageState();
}

class FirstAuthPageState extends State<FirstAuthPage> {
  int radioValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.19),
            image: DecorationImage(
              image: AssetImage('assets/images/auth_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BlurryContainer(
            padding: EdgeInsets.only(
              right: kDefaultPadding * 1.5,
              left: kDefaultPadding * 1.5,
              top: kDefaultPadding * 5,
              bottom: kDefaultPadding * 2.5,
            ),
            blur: 4,
            borderRadius: BorderRadius.circular(0),
            child: SafeArea(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'First Auth',
                      style: TextStyle(
                        color: Color(0xFFFbFeFF),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding * 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: radioValue,
                            onChanged: (int? newValue) => setState(() {
                              radioValue = newValue!;
                            }),
                            activeColor: Colors.white,
                          ),
                          Text(
                            'Director',
                            style: TextStyle(
                              color: radioValue == 1
                                  ? Colors.white
                                  : kBlueTextColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Radio(
                            value: 2,
                            groupValue: radioValue,
                            onChanged: (int? newValue) => setState(() {
                              radioValue = newValue!;
                            }),
                            activeColor: Colors.white,
                          ),
                          Text(
                            'Teacher',
                            style: TextStyle(
                              color: radioValue == 2
                                  ? Colors.white
                                  : kBlueTextColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Radio(
                            value: 3,
                            groupValue: radioValue,
                            onChanged: (int? newValue) => setState(() {
                              radioValue = newValue!;
                            }),
                            activeColor: Colors.white,
                          ),
                          Text(
                            'Student',
                            style: TextStyle(
                              color: radioValue == 3
                                  ? Colors.white
                                  : kBlueTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: kDefaultPadding * 2),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    decoration: BoxDecoration(
                      color: kFormFillColor,
                      border: Border.all(width: 1, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(kDefaultRadius),
                    ),
                    child: TextField(
                      //controller: _emailController,
                      style: const TextStyle(
                        fontSize: 14,
                        color: kBlueTextColor,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                        hintStyle: TextStyle(color: kBlueTextColor),
                        icon: Icon(
                          Icons.email,
                          size: 18,
                          color: kBlueTextColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    decoration: BoxDecoration(
                      color: kFormFillColor,
                      border: Border.all(width: 1, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(kDefaultRadius),
                    ),
                    child: TextField(
                      //obscureText: !_isVisible,
                      //controller: _passwordController,
                      style: const TextStyle(
                        fontSize: 14,
                        color: kBlueTextColor,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 14),
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: kBlueTextColor),
                        icon: const Icon(
                          Icons.lock,
                          size: 18,
                          color: kBlueTextColor,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.visibility,
                            color: kBlueTextColor,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 21, 47, 141),
                          shape: const StadiumBorder()),
                      child: const Text(
                        'Log in',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
