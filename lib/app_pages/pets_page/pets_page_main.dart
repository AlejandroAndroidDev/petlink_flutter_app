import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:petlink_flutter_app/app_pages/pets_page/widget/search_view_filter.dart';
import 'package:petlink_flutter_app/model/pets_model.dart';
import 'package:http/http.dart' as http;

Future<List<Pet>> fetchPets() async {
  final response = await http.get(
      Uri.parse('http://172.30.1.199:8080/petlink/pets/inadoption'),
      headers: {"Content-Type": "application/json"});

  final List body = json.decode(response.body);
  return body.map((e) => Pet.fromJson(e)).toList();
}

class PetsPage extends StatefulWidget {
  const PetsPage({super.key});

  @override
  State<PetsPage> createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  late Future<List<Pet>> petsFuture;

  @override
  void initState() {
    super.initState();
    petsFuture = fetchPets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 228, 229, 228),
        appBar: AppBar(
          title: SearchViewFilterPets(petList: petsFuture),
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColorDark,
          ),
          elevation: 0,
        ),
        body: Center(
          child: FutureBuilder<List<Pet>>(
            future: petsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                final pets = snapshot.data!;
                return buildPets(pets);
              } else {
                return const Text("No data available");
              }
            },
          ),
        ));
  }

  Widget buildPets(List<Pet> pets) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        itemCount: pets.length,
        itemBuilder: (BuildContext context, int index) {
          final pet = pets[index];

          return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffF5F5F5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        placeholder: (context, url) => Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                Theme.of(context).primaryColorDark,
                              ),
                            ),
                          ),
                        ),
                        imageUrl: pet.imgId,
                        width: 120,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          pet.name,
                          style: const TextStyle(
                            fontFamily: 'BalooDa2',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF7B7B7B),
                            fontSize: 19,
                          ),
                        ),
                        Text(
                          pet.breed,
                          style: const TextStyle(
                            fontFamily: 'BalooDa2',
                            color: Color(0xFF7B7B7B),
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          pet.castrated ? "Castrated" : "Not castrated",
                          style: const TextStyle(
                            fontFamily: 'BalooDa2',
                            color: Color(0xFF7B7B7B),
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                  if (pet.inAdoption)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SizedBox(
                        width: 70,
                        height: 30,
                        child: TextButton(
                          onPressed: () => {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xFFE4E5E4),
                            ),
                          ),
                          child: const Text(
                            "Adopt",
                            style: TextStyle(
                              fontFamily: 'BalooDa2',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
