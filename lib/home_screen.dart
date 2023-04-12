import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_flutter_app/pokemons_details.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //List pokedex1;
  var pokemonapi =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  late List pokedex = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      // if the value is true the view is compleatly mounted
      fetchPokemonData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF264653),
                Color(0xFF2a9d8f),
                Color(0xFFe9c46a),
                Color(0xFFf4a261),
                Color(0xFFe76f51)
              ]),
        ),
      ),
      Positioned(
          top: 70,
          left: 20,
          child: Container(
              width: width * 0.9,
              height: height * 0.07,
              color: Color(0xFF0E3311).withOpacity(0.3),
              child: Image.asset(
                'images/pokemons.png',
              ))),
      Positioned(
        top: 140,
        bottom: 0,
        width: width,
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemCount: pokedex.length,
                itemBuilder: (context, index) {
                  var type = pokedex[index]['type'][0];
                  return InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: type == 'Grass'
                              ? Colors.teal
                              : type == "Fire"
                                  ? Colors.red
                                  : type == "Water"
                                      ? Colors.lightBlue
                                      : type == "Bug"
                                          ? Colors.purpleAccent
                                          : type == "Psychic"
                                              ? Colors.deepPurple
                                              : type == "Electric"
                                                  ? Colors.deepOrangeAccent
                                                  : type == "Poison"
                                                      ? Colors.deepPurpleAccent
                                                      : type == "Normal"
                                                          ? Colors.indigo
                                                          : type == "Ground"
                                                              ? Colors.brown
                                                              : type == "Rock"
                                                                  ? Colors.cyan
                                                                  : Colors.pink,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Stack(children: [
                          Positioned(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 8.0, top: 20, bottom: 4),
                              child: Text(
                                pokedex[index]['name'],
                                //textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 45,
                            left: 20,
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.black12,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, top: 5, bottom: 4),
                                child: Text(
                                  type.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 50,
                              right: 25,
                              child: CachedNetworkImage(
                                imageUrl: pokedex[index]['img'],
                                height: 130,
                                fit: BoxFit.fitHeight,
                              )),
                        ]),
                      ),
                    ),
                    onTap: () {
                      //TODO Navigate to detail screen describe each pokemon :)
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PokemonDetails(
                                  pokemonDetail: pokedex[index],
                                  color: type == 'Grass'
                                      ? Colors.teal
                                      : type == "Fire"
                                          ? Colors.red
                                          : type == "Water"
                                              ? Colors.lightBlue
                                              : type == "Bug"
                                                  ? Colors.purpleAccent
                                                  : type == "Psychic"
                                                      ? Colors.deepPurple
                                                      : type == "Electric"
                                                          ? Colors
                                                              .deepOrangeAccent
                                                          : type == "Poison"
                                                              ? Colors
                                                                  .deepPurpleAccent
                                                              : type == "Normal"
                                                                  ? Colors
                                                                      .indigo
                                                                  : type ==
                                                                          "Ground"
                                                                      ? Colors
                                                                          .brown
                                                                      : type ==
                                                                              "Rock"
                                                                          ? Colors
                                                                              .cyan
                                                                          : Colors
                                                                              .pink,
                                  tag: index)));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ]));
  }

  void fetchPokemonData() {
    var url = Uri.https('raw.githubusercontent.com',
        '/Biuni/PokemonGO-Pokedex/master/pokedex.json');
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var decodedJsonData = jsonDecode(value.body);
        // print(decodedJsonData);
        pokedex = decodedJsonData['pokemon'];
        // print(pokedex[0]['name']);
        setState(() {});
      }
    });
  }
}
