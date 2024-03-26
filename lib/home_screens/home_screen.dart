import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tesis/forUser/my_plants_task.dart';
import 'package:tesis/home_screens/components.dart';
import 'package:tesis/home_screens/details_screen.dart';
import 'package:tesis/home_screens/favorite_screen.dart';
import 'package:tesis/home_screens/firebase_favorites.dart';
import 'package:tesis/loginScreens/common_widgets.dart';
import 'package:tesis/utilis/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final CommonWidgets common = CommonWidgets();
  final HomePage home = HomePage();
  final FirebaseFav firebaseFav = FirebaseFav();

  List<String> favorites = [];

  void _showSnackbar(String message, bool success) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: success ? Colors.green : Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 10,
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              height: 70,
              color: AppColors.primaryColor,
            ),
          ],
        ),
        actions: [
          common.settingButton(context),
        ],
        backgroundColor: AppColors.backGroundColor,
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FavoritesScreen(),
          ),
        ),
        child: const Icon(
          Icons.favorite,
          color: Colors.red,
          size: 40,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        color: AppColors.backGroundColor,
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            common.buildRichText(
              firstText: 'Discover your ',
              firstTextStyle: const TextStyle(
                letterSpacing: 1,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: Colors.black,
                fontFamily: 'Schyler',
              ),
              secondText: 'plants',
              secondTextStyle: const TextStyle(
                letterSpacing: 1,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.black,
                fontFamily: 'Schyler',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyPlantsTask(),
                  ),
                );
              },
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/add.jpg'),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'New in',
                        style: TextStyle(
                          letterSpacing: 1,
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: AppColors.whiteForText,
                          fontFamily: 'Schyler',
                        ),
                      ),
                      common.buildRichText(
                        firstText: 'Create Plans ',
                        firstTextStyle: const TextStyle(
                          letterSpacing: 1,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: AppColors.whiteForText,
                          fontFamily: 'Schyler',
                        ),
                        secondText: "with tesis app",
                        secondTextStyle: const TextStyle(
                          letterSpacing: 1,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: AppColors.whiteForText,
                          fontFamily: 'Schyler',
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Herbs',
              style: TextStyle(
                letterSpacing: 1,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: AppColors.blackForText,
                fontFamily: 'Schyler',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('herbs').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                List<DocumentSnapshot> documents = snapshot.data!.docs;
                List<Widget> containers = [];

                for (int i = 0; i < documents.length; i++) {
                  containers.add(
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetaisOfPlants(
                                imageUrl: documents[i]['imageUrl'],
                                name: documents[i]['name'],
                                details: documents[i]['details'],
                              ),
                            ),
                          ),
                          child: home.buildHorizontalContainerList(
                            1,
                            100,
                            100,
                            BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(documents[i]['imageUrl']),
                                fit: BoxFit.fill,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                bool isFavorite =
                                    favorites.contains(documents[i]['name']);

                                if (isFavorite) {
                                  bool removed =
                                      await firebaseFav.removeFromFavorites(
                                    documents[i]['name'],
                                  );
                                  if (removed) {
                                    setState(() {
                                      favorites.remove(documents[i]['name']);
                                    });
                                    _showSnackbar(
                                        'Removed from favorites', true);
                                  } else {
                                    _showSnackbar(
                                        'Error removing from favorites', false);
                                  }
                                } else {
                                  bool added = await firebaseFav.addToFavorites(
                                    documents[i]['name'],
                                    documents[i]['imageUrl'],
                                    documents[i]['details'],
                                  );
                                  if (added) {
                                    setState(() {
                                      favorites.add(documents[i]['name']);
                                    });
                                    _showSnackbar('Added to favorites', true);
                                  } else {
                                    _showSnackbar(
                                        'Error adding to favorites', false);
                                  }
                                }
                              },
                              icon: Icon(
                                favorites.contains(documents[i]['name'])
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: favorites.contains(documents[i]['name'])
                                    ? Colors.red
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          documents[i]['name'],
                          style: const TextStyle(
                            letterSpacing: 1,
                            fontSize: 15,
                            color: AppColors.primaryColor,
                            fontFamily: 'Schyler',
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: containers,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            common.buildRichText(
              firstText: 'Recomemded for ',
              firstTextStyle: const TextStyle(
                letterSpacing: 1,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: AppColors.blackForText,
                fontFamily: 'Schyler',
              ),
              secondText: 'You',
              secondTextStyle: const TextStyle(
                letterSpacing: 1,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: AppColors.blackForText,
                fontFamily: 'Schyler',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('recomended')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                List<DocumentSnapshot> documents = snapshot.data!.docs;
                List<Widget> containers = [];

                for (int i = 0; i < documents.length; i++) {
                  containers.add(
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetaisOfPlants(
                                imageUrl: documents[i]['imageUrl'],
                                name: documents[i]['name'],
                                details: documents[i]['details'],
                              ),
                            ),
                          ),
                          child: home.buildHorizontalContainerList(
                            1,
                            230,
                            280,
                            BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(documents[i]['imageUrl']),
                                fit: BoxFit.fill,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                bool isFavorite =
                                    favorites.contains(documents[i]['name']);

                                if (isFavorite) {
                                  bool removed =
                                      await firebaseFav.removeFromFavorites(
                                    documents[i]['name'],
                                  );
                                  if (removed) {
                                    setState(() {
                                      favorites.remove(documents[i]['name']);
                                    });
                                    _showSnackbar(
                                        'Removed from favorites', true);
                                  } else {
                                    _showSnackbar(
                                        'Error removing from favorites', false);
                                  }
                                } else {
                                  bool added = await firebaseFav.addToFavorites(
                                    documents[i]['name'],
                                    documents[i]['imageUrl'],
                                    documents[i]['details'],
                                  );
                                  if (added) {
                                    setState(() {
                                      favorites.add(documents[i]['name']);
                                    });
                                    _showSnackbar('Added to favorites', true);
                                  } else {
                                    _showSnackbar(
                                        'Error adding to favorites', false);
                                  }
                                }
                              },
                              icon: Icon(
                                favorites.contains(documents[i]['name'])
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: favorites.contains(documents[i]['name'])
                                    ? Colors.red
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          documents[i]['name'],
                          style: const TextStyle(
                            letterSpacing: 1,
                            fontSize: 15,
                            color: AppColors.primaryColor,
                            fontFamily: 'Schyler',
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: containers,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
