import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();

    askPermission();
    // hello();
  }

  final Telephony telephony = Telephony.instance;
  void askPermission() async {
    bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
  }

  int count = 0;
  bool motion = false;
  bool fire = false;
  bool door = false;
  bool status_Activated = true;
  @override
  Widget build(BuildContext context) {
    // void hello() async {
    telephony.listenIncomingSms(
        onNewMessage: (SmsMessage message) async {
          // if(message.address==''){}
          // {motion: true, fire: false, door: false}
          Map res = jsonDecode(message.body!);
          log(res.toString());
          log((res['fire']).toString());
          setState(() {
            motion = res['motion'];
            fire = res['fire'];
            door = res['door'];
            if (motion || fire || door == false) {
              status_Activated = false;
            } else {
              status_Activated = true;
            }
          });
          log('$motion, $fire, $door');
        },
        listenInBackground: false);
    // JSON
    // }

    // if (count == 0) {
    //   hello();
    //   count++;
    // }
    bool status_fire = true,
        status_motion = false,
        status_door = true,
        status_signal = true;
    return Scaffold(
        body: Stack(children: [
      Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
      ),
      Positioned(
        top: 90,
        height: 330,
        left: 40,
        right: 40,
        child: Container(
          height: 80,
          width: 80,
          child: Stack(
            children: [
              Icon(
                Icons.blur_on_sharp,
                color: (status_fire &&
                        status_door &&
                        status_signal &&
                        status_motion)
                    ? Color.fromARGB(255, 0, 255, 132)
                    : Color.fromARGB(255, 226, 28, 28),
                size: 350,
              ),
              Center(
                child: SizedBox(
                  width: 180,
                  height: 180,
                  child: Image.asset(
                    'assets/mini_project_logo.png',
                    height: 150,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        bottom: 300,
        height: 63,
        left: 110,
        child: Center(
          child: Container(
              height: 450,
              width: 200,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 221, 221, 221),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 0,
                        ),
                        const Text(
                          "SYSTEM ",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(95, 0, 0, 0),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          icon: Icon(Icons.check_circle),
                          iconSize: 40,
                          color: status_Activated == false
                              ? Color.fromARGB(255, 250, 89, 78)
                              : Colors.green,
                          onPressed: (
                              // Navigator.push(context,MaterialPageRoute(Builder: (context) => ))
                              ) {
                            print('send sms');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
      Positioned(
        //1st box
        bottom: 170,
        left: 30,
        right: 200,
        child: Center(
          child: Container(
            height: 110,
            width: 350,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 221, 221, 221),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              child: Column(children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Door Status',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(96, 0, 0, 0),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                IconButton(
                    icon: Icon(Icons.door_back_door_outlined),
                    color: door == false
                        ? Color.fromARGB(255, 250, 89, 78)
                        : Colors.green,
                    iconSize: 50,
                    onPressed: () {
                      print('clciked');
                    })
              ]),
            ),
          ),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Positioned(
        bottom: 170,
        left: 200,
        right: 30,
        child: Center(
          child: Container(
            height: 110,
            width: 350,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 221, 221, 221),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              child: Column(children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Fire Status',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(96, 0, 0, 0),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Icon(
                  Icons.fireplace_rounded,
                  color: fire == false
                      ? Color.fromARGB(255, 250, 89, 78)
                      : Colors.green,
                  size: 50,
                )
              ]),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 50,
        left: 30,
        right: 200,
        child: Center(
          child: Container(
            height: 110,
            width: 350,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 221, 221, 221),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              child: Column(children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Motion Status',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(96, 0, 0, 0),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Icon(
                  Icons.directions_run_outlined,
                  color: motion == false
                      ? Color.fromARGB(255, 250, 89, 78)
                      : Colors.green,
                  size: 50,
                )
              ]),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 50,
        left: 200,
        right: 30,
        child: Center(
          child: Container(
            height: 110,
            width: 350,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 221, 221, 221),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              child: Column(children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Signal',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(96, 0, 0, 0),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                status_signal
                    ? const Icon(
                        Icons.signal_cellular_alt_outlined,
                        color: Colors.green,
                        size: 50,
                      )
                    // ignore: dead_code
                    : const Icon(
                        Icons.signal_cellular_connected_no_internet_0_bar_sharp,
                        color: Colors.red,
                        size: 45,
                      ),
              ]),
            ),
          ),
        ),
      ),
    ]));
  }
}
