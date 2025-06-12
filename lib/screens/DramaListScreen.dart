import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DramaListScreen(),
    );
  }
}

class DramaListScreen extends StatefulWidget {
  @override
  _DramaListScreenState createState() => _DramaListScreenState();
}

class _DramaListScreenState extends State<DramaListScreen> {
  List<dynamic> dramas = [];

  @override
  void initState() {
    super.initState();
    loadDramas();
  }

  Future<void> loadDramas() async {
    String jsonData = await rootBundle.loadString('assets/data/dramas.json');
    setState(() {
      dramas = json.decode(jsonData)["dramas"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(44, 27, 71, 1),

      appBar: AppBar(
        title: Text(
          'Dramas Coreanos',
          style: TextStyle(
            color: Color.fromRGBO(220, 202, 233, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(
          color: Color.fromRGBO(220, 202, 233, 1),
        ),

        backgroundColor: Color.fromRGBO(44, 27, 71, 1),
      ),
      body: dramas.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: dramas.length,
              itemBuilder: (context, index) {
                var drama = dramas[index];
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                    color: Colors.white.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          drama["imagen"]!.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    drama["imagen"],
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(),
                          SizedBox(height: 10),
                          Text(
                            drama["titulo"],
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            drama["descripcion"],
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Capítulos: ${drama["capitulos"]}",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Fecha de estreno: ${drama["fecha_estreno"]}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
