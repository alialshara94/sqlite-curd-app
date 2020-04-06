import 'package:flutter/material.dart';
import 'package:sqlite_curd_app/database/database.dart';
import 'package:sqlite_curd_app/database/models/database_model.dart';
import 'package:sqlite_curd_app/database/models/result.dart';
import 'package:sqlite_curd_app/database/models/student.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MyDatabase myDatabase = MyDatabase();
  await myDatabase.studentDatabase();
  await myDatabase.resultDatabase();
  await myDatabase
      .insert(Student(sId: 1, sName: 'ali', sAge: 22, sDepartment: 'software'));
  await myDatabase.insert(
      Student(sId: 2, sName: 'ahmed', sAge: 24, sDepartment: 'electron'));
  await myDatabase
      .insert(Student(sId: 3, sName: 'sarah', sAge: 22, sDepartment: 'media'));
  await myDatabase.insert(
      Student(sId: 4, sName: 'hussain', sAge: 23, sDepartment: 'software'));
  await myDatabase.insert(Result(rId: 1, rResult: 'good', sId: 1));
  await myDatabase.insert(Result(rId: 2, rResult: 'very good', sId: 2));
  await myDatabase.insert(Result(rId: 3, rResult: 'pass', sId: 3));
  await myDatabase.insert(Result(rId: 4, rResult: 'good', sId: 4));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MyDatabase myDatabase = MyDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student App'),
      ),
      body: Container(
        child: FutureBuilder(
            future: myDatabase.getAll('students', 'students_db'),
            builder: (BuildContext context,
                AsyncSnapshot<List<DatabaseModel>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(
                    child: Text('Error connection'),
                  );
                  break;
                case ConnectionState.waiting:
                  break;
                case ConnectionState.active:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  break;
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text('Error no data found!'),
                    );
                  }
                  return _drawStudents(context, snapshot.data.cast());
                  break;
                default:
                  return Center(
                    child: Text('Error connection'),
                  );
                  break;
              }
            },
          ),
      ),
    );
  }

  Widget _drawStudents(BuildContext context, List<Student> students) {
    return ListView.builder(
        itemCount: students.length,
        itemBuilder: (BuildContext context, int position) {
          return ListTile(
            title: Text(students[position].sName),
          );
        });
  }
  Widget _drawResults(BuildContext context, List<Result> results) {
    return ListView.builder(
        itemCount: results.length,
        itemBuilder: (BuildContext context, int position) {
          return ListTile(
            title: Text(results[position].rResult),
          );
        });
  }
}
