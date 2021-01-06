import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coding_test/controllers/home_controller.dart';
import 'package:coding_test/models/image_object.dart';
import 'package:coding_test/routes/auth.dart';
import 'package:coding_test/widgets/horizontal_images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../globals/globals.dart' as globals;

class HomeRoute extends StatefulWidget {
  HomeRoute({Key key}) : super(key: key);

  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  int selectedImage = 0;
  Future<List<ImageObject>> _fetchImages;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _fetchImages = HomeRouteController.getImages(globals.user.userId);
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Scan"),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    CupertinoPageRoute(
                      builder: (ctx) => AuthRoute(),
                    ),
                    (route) => false);
              })
        ],
      ),
      body: FutureBuilder<List<ImageObject>>(
          future: _fetchImages,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              Center(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _fetchImages = HomeRouteController.getImages(
                          FirebaseAuth.instance.currentUser.uid);
                    });
                  },
                  child: Column(
                    children: [
                      Icon(Icons.error),
                      Text("An error occurred, Tap to reload!")
                    ],
                  ),
                ),
              );
            }
            return snapshot.data.isEmpty == true
                ? Center(
                    child: InkWell(
                      onTap: () {
                        //TODO
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.cloud_upload,
                            color: primaryColor,
                            size: 40,
                          ),
                          SizedBox(height: 10),
                          Text('Upload Image'),
                        ],
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        flex: 9,
                        child: Image.network(snapshot.data[0].url),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: HorizontalImageListWidget(
                          selectedImage: selectedImage,
                          onAddNewImage: () async {
                            var image = await HomeRouteController.pickImage(
                                context, globals.user.userId, _scaffoldKey);
                            if (image != null) {
                              setState(() {
                                snapshot.data.add(image);
                                selectedImage = snapshot.data.length;
                              });
                            }
                          },
                          onImageClick: (index) {
                            setState(() {
                              selectedImage = index;
                            });
                          },
                        ),
                      )
                    ],
                  );
          }),
    );
  }
}
