import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meme_generator/models/meme_model.dart';
import 'package:meme_generator/page/detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Future<List<MemeModel>> getListMeme() async {
      var dio = Dio();
      String baseUrl = 'https://api.imgflip.com/get_memes';

      final response = await dio.get(baseUrl);

      if(response.statusCode == 200) {
        var data = response.data;
        var result = data['data']['memes'] as List;
        List<MemeModel> listMemeModel =
        result.map((json) => MemeModel.fromJson(json)).toList();
        return listMemeModel;
      } else {
        throw Exception('Gagal memeuat meme');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('MemeGenerator'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.refresh)
          ),
        ],
      ),
      body: FutureBuilder(
        future: getListMeme(),
        builder: (context, AsyncSnapshot<List<MemeModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == null) {
            return Center(
              child: Text('Meme belum ada'),
            );
          }
          if (snapshot.data!.isNotEmpty) {
            return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              MemeModel memeModel = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(id: memeModel)));
                },
                child: Card(
                  color: Colors.grey,
                  child: Image.network(memeModel.url ?? '', fit: BoxFit.cover,),
                ),
              );
            });
          } else {
            return Center(child: Text('Empty'));
          }
        },
      ),
    );
  }
}
