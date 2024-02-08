import 'dart:convert';
import 'dart:developer';

import 'package:app_reciepe/model.dart';
import 'package:app_reciepe/webView.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({super.key, required this.querry});

  final String querry;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isLoading = true;
  List<RecipeModel> recipeList = <RecipeModel>[];

  //Creating Controller for the search button:
  TextEditingController searchController = TextEditingController();

  getRecipe(String query) async {
    // recipeList.clear();
    String url =
        "https://api.edamam.com/search?q=$query&app_id=208672dc&app_key=ecb3a23717cf0d9697cb55c23a74d266&from=0&to=3&calories=591-722&health=alcohol-free";
    http.Response response = await http.get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    //checking for data i.e. coming through the API:
    log(data.toString());

    data['hits'].forEach((element) {
      RecipeModel model = RecipeModel();
      model = RecipeModel.fromMap(element['recipe']);
      recipeList.add(model);
      setState(() {
        isLoading = false;
      });
      log(recipeList.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Search1 init called");
    getRecipe(widget.querry);
    print(widget.querry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xffE89B7D),
              Color(0xffF5DEB4),
            ])),
          ),
          SafeArea(
            child: Column(
              children: [
                //Search bar:
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
                  margin: const EdgeInsets.fromLTRB(5, 1, 5, 2),
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Let's cook something...",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          if ((searchController.text).replaceAll(' ', '') !=
                              '') {
                            // If the text is not blank, perform the search
                            getRecipe(searchController.text);

                            // Clear the search input field
                            // searchController.clear();

                            // Navigate to the same screen with the new query
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Search(
                                  querry: searchController.text,
                                ),
                              ),
                            );
                          }
                        },
                        child: const Icon(
                          Icons.search,
                          size: 40,
                          color: Color(0xffad5389),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,

                  height: 743, // height: MediaQuery.of(context).size.height,

                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        isLoading
                            ? const CircularProgressIndicator()
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: recipeList.length,
                                // -1 because the list starting index is zero and list.length give
                                // result in natural number counting
                                itemBuilder: (context, index) {
                                  return InkWell(
                                      //Implementing the logic to go to webView in Flutter
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => WebView(recipeUrl: recipeList[index].appUrl,),
                                          ),
                                        );
                                      },
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.00),
                                                child: Image.network(
                                                  recipeList[index].appImageUrl,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                ),
                                              ),
                                              Positioned(
                                                top: 365,
                                                bottom: 0,
                                                right: 0,
                                                left: 0,
                                                child: Container(
                                                  height: 30,
                                                  decoration: const BoxDecoration(
                                                      color: Color(0xa5607d8b),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      20.00),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      20.00))),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12,
                                                      vertical: 6),
                                                  child: Text(
                                                    recipeList[index].appLabel,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  right: 0,
                                                  left: 310,
                                                  child: Container(
                                                    height: 30,
                                                    decoration: const BoxDecoration(
                                                        color:
                                                            Color(0xffF2836F),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        20.00),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        20.00))),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .local_fire_department,
                                                          color:
                                                              Color(0xffe8dddd),
                                                        ),
                                                        const SizedBox(
                                                          width: 2,
                                                        ),
                                                        Text(
                                                          recipeList[index]
                                                              .appCalories
                                                              .toStringAsFixed(
                                                                  2),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        )
                                                      ],
                                                    ),
                                                  ))
                                            ],
                                          )));
                                })
                      ],
                    ),
                  ),
                ),

                //Creating a ScrollView List to the Items:
              ],
            ),
          ),
        ],
      ),
    );
  }
}
