import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pulsezest_testing/CloudFirestore.dart';
import 'package:pulsezest_testing/RealtimeDatabase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'PulseZest Learning',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage()

    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>RealtimeDatabase()));
            }, child: const Text("Real time Database")),
            const SizedBox(height: 10,),
            ElevatedButton(onPressed: (){}, child: const Text("Cloud fireStore"))
          ],
        ),
      ),
    );
  }
}
