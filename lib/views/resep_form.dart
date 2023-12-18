import 'package:flutter/material.dart';
import 'package:ResepKu/model/resep.dart';
import 'package:ResepKu/service/resep_service.dart';
import 'package:ResepKu/views/resep_detail.dart';

class ResepForm extends StatefulWidget {
  const ResepForm({super.key});

  @override
  State<ResepForm> createState() => _ResepFormState();
}

class _ResepFormState extends State<ResepForm> {
  final _formKey = GlobalKey<FormState>();
  final _idCtrl = TextEditingController();
  final _namaCtrl = TextEditingController();
  final _imagesCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  final _totalTimeCtrl = TextEditingController();
  final _ratingCtrl = TextEditingController();
  final _ingredientCtrl = TextEditingController();
  final _instructionCtrl = TextEditingController();
  final _videoUrlCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah ResepKu"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                _fieldNama(),
                SizedBox(height: 20),
                _fieldImage(),
                SizedBox(height: 20),
                _fieldTime(),
                SizedBox(height: 20),
                _fieldDescription(),
                SizedBox(height: 20),
                _fieldRating(),
                SizedBox(height: 20),
                _fieldIngredient(),
                SizedBox(height: 20),
                _fieldInstruction(),
                SizedBox(height: 20),
                _fieldVideoUrl(),
                SizedBox(height: 20),
                _tombolSimpan(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _fieldNama() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Nama Makanan',
        hintText: 'Masukkan',
        prefixIcon: Icon(Icons.fastfood_rounded,
            size: 25, color: Color.fromARGB(255, 110, 110, 110)),
        border: OutlineInputBorder(),
      ),
      controller: _namaCtrl,
    );
  }

  _fieldImage() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Link Gambar',
        hintText: 'Masukkan',
        prefixIcon: Icon(Icons.image_rounded,
            size: 25, color: Color.fromARGB(255, 110, 110, 110)),
        border: OutlineInputBorder(),
      ),
      controller: _imagesCtrl,
    );
  }

  _fieldTime() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Waktu Memasak",
        hintText: 'Masukkan',
        prefixIcon: Icon(Icons.access_time_rounded,
            size: 25, color: Color.fromARGB(255, 110, 110, 110)),
        border: OutlineInputBorder(),
      ),
      controller: _totalTimeCtrl,
    );
  }

  _fieldDescription() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Tentang Makanan',
        hintText: 'Masukkan',
        prefixIcon: Icon(Icons.description_rounded,
            size: 25, color: Color.fromARGB(255, 110, 110, 110)),
        border: OutlineInputBorder(),
      ),
      controller: _descriptionCtrl,
      maxLines: null,
    );
  }

  _fieldRating() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Rating Makanan",
        hintText: 'Masukkan',
        prefixIcon: Icon(Icons.star_border_rounded,
            size: 25, color: Color.fromARGB(255, 110, 110, 110)),
        border: OutlineInputBorder(),
      ),
      controller: _ratingCtrl,
    );
  }

  _fieldIngredient() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Ingredient",
        hintText: 'Masukkan',
        prefixIcon: Icon(Icons.article_rounded,
            size: 25, color: Color.fromARGB(255, 110, 110, 110)),
        border: OutlineInputBorder(),
      ),
      controller: _ingredientCtrl,
      maxLines: null,
    );
  }

  _fieldInstruction() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Instruction",
        hintText: 'Masukkan',
        prefixIcon: Icon(Icons.integration_instructions_rounded,
            size: 25, color: Color.fromARGB(255, 110, 110, 110)),
        border: OutlineInputBorder(),
      ),
      controller: _instructionCtrl,
      maxLines: null,
    );
  }

  _fieldVideoUrl() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Link Video",
        hintText: 'Masukkan',
        prefixIcon: Icon(Icons.video_collection_rounded,
            size: 25, color: Color.fromARGB(255, 110, 110, 110)),
        border: OutlineInputBorder(),
      ),
      controller: _videoUrlCtrl,
    );
  }

  _tombolSimpan() {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(fixedSize: Size(70, 50)),
          onPressed: () async {
            Resep resep = new Resep(
                id: _idCtrl.text,
                name: _namaCtrl.text,
                images: _imagesCtrl.text,
                totalTime: _totalTimeCtrl.text,
                description: _descriptionCtrl.text,
                rating: _ratingCtrl.text,
                ingredient: _ingredientCtrl.text,
                instruction: _instructionCtrl.text,
                videoUrl: _videoUrlCtrl.text);
            await ResepService().simpan(resep).then((value) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailResep(resep: value)));
            });
          },
          child: Icon(Icons.save_rounded, size: 35)),
    );
  }
}
