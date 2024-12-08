import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeApp(),
    );
  }
}
class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  int seconds =0,minutes=0,hours=0;
  String digitSecond = "00",digitMinute = "00", digitHours= "00";
  Timer? timer;
  bool started = false;
  List laps = [];

  // creating the stop timer function

  void stop(){
    timer!.cancel();
    setState(() {
      started= false;

    });
  }
  void reset (){
    timer!.cancel();
    setState(() {
      seconds =0;
      minutes =0;
      hours =0;

      digitSecond = "00";
      digitMinute = "00";
      digitHours = "00";
      started = false;
    });
  }
  void addLaps(){
    String lap = "$digitHours:$digitMinute:$digitSecond";
    if(!started== false){
      setState(() {
        laps.add(lap);
      });
    }else{
      setState(() {
        laps.clear();

      });


    }
  }
  void start (){
    started = true;
    timer = Timer.periodic(const Duration(seconds:1), (timer) {
      int localSeconds = seconds + 1 ;
      int localMinute = minutes ;
      int localHour = hours ;
      if(localSeconds>59){
        if(localMinute>59){
          localHour++;
          localMinute=0;
        }else{
          localMinute++;
          localSeconds =0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinute;
        hours = localHour;
        digitSecond = (seconds >= 10)? "$seconds":"0$seconds";
        digitHours = (hours >= 10)? "$hours":"0$hours";
        digitMinute = (minutes >= 10)? "$minutes":"0$minutes";
      });
    }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2757),
      body: SafeArea(
          child: Padding(
              padding:const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    "Stop Watch App ",
                    style: TextStyle(
                      color:  Colors.white,
                      fontSize: 28.9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const Padding(padding:EdgeInsets.all(20.0) ),

                Center(child: Text("$digitHours:$digitMinute:$digitSecond",
                style: const TextStyle(color:Colors.white,
                fontSize: 80, fontWeight: FontWeight.w600,

                ),
                ),),

                Container(
                  height: 400.0,
                  decoration: BoxDecoration(
                    color:  Colors.grey,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListView.builder(
                    itemCount: laps.length,
                    itemBuilder: (context,index){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lap n${index +1}",
                            style:const TextStyle(color: Colors.white,
                              fontSize: 18.00,
                            ),
                          ),
                          Text(
                            "${laps[index]}",
                            style:const TextStyle(color: Colors.white,
                              fontSize: 18.00,
                            ),
                          )
                        ],
                      );
                    },),
                ),

                const Padding(padding:
                EdgeInsets.all(20.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: RawMaterialButton(
                          onPressed: (){
                            (!started)? start():stop();
                          },
                        shape: const StadiumBorder(
                            side: BorderSide(
                                color: Colors.blue
                            ),
                        ),
                          child: Text(
                            (!started)?"Start": "Pause",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                    ),

                    const Padding(padding: EdgeInsets.all(8.0)),

                    IconButton(
                      onPressed: (){
                        addLaps();
                      },
                      icon: const Icon(Icons.flag,
                      color: Colors.white,)
                      ,),

                    const Padding(padding: EdgeInsets.all(8.0)),

                    Expanded(
                      child: RawMaterialButton(
                        onPressed: (){
                          reset();
                        },
                        fillColor: Colors.blue,
                        shape: const StadiumBorder(
                        ),
                        child: const Text(
                          "Reset",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),),
    );
  }
}


