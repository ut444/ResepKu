import 'package:flutter/material.dart';
import '../model/resep.dart';
import '../views/home.dart';
import '../views/resep_update.dart';
import '../views/video_detail.dart';
import '../service/resep_service.dart';

class DetailResep extends StatefulWidget {
  final Resep resep;
  const DetailResep({super.key, required this.resep});

  @override
  State<DetailResep> createState() => _DetailResepState();
}

class _DetailResepState extends State<DetailResep> {
  Stream<Resep> getData() async* {
    Resep data = await ResepService().getById(widget.resep.id.toString());
    yield data;
  }

  String _formatNumberedInstructions(String instructions) {
    List<String> lines = instructions.split('\n');
    for (int i = 0; i < lines.length; i++) {
      lines[i] = ' ${i + 1}. ${lines[i]}';
    }
    return lines.join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu),
            SizedBox(
              width: 10,
            ),
            Text(
              'ResepKu',
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: getData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return Text("Data Tidak Ditemukan");
            }
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      offset: Offset(0.0, 0.10),
                      spreadRadius: -6.0),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${snapshot.data.name}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Image(
                    image: NetworkImage("${snapshot.data.images}"),
                    alignment: Alignment.topCenter,
                  ),
                  Align(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Text(
                        "\nDescription",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Align(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Text(
                        "${snapshot.data.description}",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                  Align(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Text(
                        "\nIngredients",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Align(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Text(
                        "• ${snapshot.data.ingredient.replaceAll('\n', '\n• ')}",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Align(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Text(
                        "\nInstruction",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Align(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Text(
                        "${_formatNumberedInstructions(snapshot.data.instruction)}",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                ],
              ),
            );
          },
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [_tombolVideo(), _tombolUbah(), _tombolhapus()],
        )
      ],
    );
  }

  _tombolVideo() {
    return StreamBuilder(
        stream: getData(),
        builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VideoDetail(resep: snapshot.data)));
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.green, fixedSize: Size(60, 40)),
            child: Icon(Icons.ondemand_video_rounded)));
  }

  _tombolUbah() {
    return StreamBuilder(
        stream: getData(),
        builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResepUpdate(resep: snapshot.data)));
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.blue, fixedSize: Size(60, 40)),
            child: Icon(Icons.edit)));
  }

  _tombolhapus() {
    return ElevatedButton(
        onPressed: () {
          AlertDialog alertDialog = AlertDialog(
            content: const Text("Yakin ingin menghapus data ini?"),
            icon: Icon(
              Icons.warning_amber_rounded,
              size: 50,
            ),
            actions: [
              StreamBuilder(
                  stream: getData(),
                  builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
                        onPressed: () async {
                          await ResepService()
                              .hapus(snapshot.data)
                              .then((value) {
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (contect) => HomePage()));
                          });
                        },
                        child: const Text("YA"),
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                      )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("TIDAK"),
                  style: ElevatedButton.styleFrom(primary: Colors.green))
            ],
          );
          showDialog(context: context, builder: (context) => alertDialog);
        },
        style: ElevatedButton.styleFrom(
            primary: Colors.red, fixedSize: Size(60, 40)),
        child: Icon(Icons.delete));
  }
}
