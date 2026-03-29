import 'package:flutter/material.dart';
import 'package:food_draiver/ui/auth/LoginPage.dart';
import 'package:food_draiver/ui/auth/TelRaqPage.dart';
import 'package:food_draiver/ui/pages/OnboardingScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Fr(),
    );
  }
}


class Fr extends StatefulWidget {
  const Fr({super.key});

  @override
  State<Fr> createState() => _FrState();
}

class _FrState extends State<Fr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:           Column(
        children: [
          Container(
            width: 200,
            height: 100,
            color: Colors.red,
          ),
          SingleChildScrollView(

            child: ListView.builder(
                itemCount: 100,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(width: 200,height: 50,color: Colors.blue,),
                );}),
          )
        ],
      )
      ,
    );
  }
}

