import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_generator/models/meme_model.dart';

class DetailPage extends StatefulWidget {
  final MemeModel id;
  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final TextEditingController _controller = TextEditingController();
  File? image;
  String title = '';

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? _imagePicked =
        await _picker.pickImage(source: ImageSource.gallery);
    image = File(_imagePicked!.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Meme'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        widget.id.url ?? '',
                      )),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      image != null
                          ? Container(
                              width: 80,
                              height: 80,
                              child: Image.file(
                                image!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : SizedBox(),
                      SizedBox(height: 8),
                      Text(
                        image != null ? title : '',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
                onPressed: () {
                  getImage();
                },
                child: Text(
                  'Tambah Logo',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                ),
                onChanged: (text) {
                  setState(() {
                    title = text;
                  });
                },
              ),
              SizedBox(height: 16),
              image != null && title != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blueAccent),
                          onPressed: () {},
                          child: Text(
                            'Simpan Meme',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 12),
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blueAccent),
                          onPressed: () {},
                          child: Text(
                            'Share Meme',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
