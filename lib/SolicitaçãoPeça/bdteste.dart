import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MyApp());
}

class Dog {
  final int id;
  final String name;
  final String breed;

  Dog({
    required this.id,
    required this.name,
    required this.breed,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'breed': breed,
    };
  }

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, breed: $breed}';
  }
}

class DatabaseHandler {
  late Database _database;

  Future<Database> initializeDB() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'dog_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, breed TEXT)',
        );
      },
      version: 1,
    );
    return _database;
  }

  Future<void> insertDog(Dog dog) async {
    await _database.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Dog>> getDogs() async {
    final List<Map<String, dynamic>> maps = await _database.query('dogs');
    return List.generate(maps.length, (i) {
      return Dog(
        id: maps[i]['id'] as int,
        name: maps[i]['name'] as String,
        breed: maps[i]['breed'] as String,
      );
    });
  }
}

class MyApp extends StatelessWidget {
  final DatabaseHandler databaseHandler = DatabaseHandler();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dog Database',
      home: MyHomePage(databaseHandler: databaseHandler),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final DatabaseHandler databaseHandler;

  MyHomePage({Key? key, required this.databaseHandler}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Dog>> _dogs;

  @override
  void initState() {
    super.initState();
    widget.databaseHandler.initializeDB().whenComplete(() {
      setState(() {
        _dogs = widget.databaseHandler.getDogs();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dog Database'),
      ),
      body: FutureBuilder(
        future: _dogs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final dogs = snapshot.data as List<Dog>;
            return ListView.builder(
              itemCount: dogs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${dogs[index].name} (${dogs[index].breed})'),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDogDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddDogDialog(BuildContext context) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController breedController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Dog'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: breedController,
                decoration: InputDecoration(labelText: 'Breed'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Dog newDog = Dog(
                  id: 0, // You can set a unique ID or let the database handle it
                  name: nameController.text,
                  breed: breedController.text,
                );
                widget.databaseHandler.insertDog(newDog).whenComplete(() {
                  setState(() {
                    _dogs = widget.databaseHandler.getDogs();
                  });
                  Navigator.of(context).pop();
                });
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
