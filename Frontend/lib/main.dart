import 'package:answe_sheet_checker_grpc/services/submission_list.dart';

import './screens/all_submissions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/add_submission.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => SubmissionList())
    ],
    child: const MyApp(),
  )
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Answer Sheet Submission"),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsetsDirectional.only(top: 80)),
            ListTile(
              title: const Text("Home"),
              textColor: Colors.teal,
              tileColor: Colors.white,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage())),
            ),
            ListTile(
              title: const Text("Add submission"),
              textColor: Colors.teal,
              tileColor: Colors.white,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddSubmission())),
            )
          ],
        ),
      ),
      body: AllSubmissions(),
    );
  }
}