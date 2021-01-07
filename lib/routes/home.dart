import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coding_test/controllers/home_controller.dart';
import 'package:coding_test/models/image_object.dart';
import 'package:coding_test/routes/auth.dart';
import 'package:coding_test/widgets/horizontal_images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../globals/globals.dart' as globals;

class HomeRoute extends StatefulWidget {
  HomeRoute({Key key}) : super(key: key);

  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  int selectedImage = 0;
  bool _loading = true;
  bool error = false;
  List<ImageObject> images = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  initialize() async {
    HomeRouteController.getImages(globals.user.userId).then(
      (value) {
        images = value ?? [];
        setState(() {
          error = false;
          _loading = false;
        });
      },
    ).catchError((err) {
      print(err);
      _loading = false;
      error = true;
    });
  }

  @override
  void initState() {
    super.initState();
    initialize();
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
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: Builder(builder: (ctx) {
          if (error) {
            return Center(
              child: InkWell(
                onTap: () {
                  initialize();
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
          return images.isEmpty == true
              ? Center(
                  child: InkWell(
                    onTap: () async {
                      var image = await HomeRouteController.pickImage(
                          context, globals.user.userId, _scaffoldKey);
                      if (image != null) {
                        setState(() {
                          selectedImage = images.length;
                          images.add(image);
                        });
                      }
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
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 9,
                        child: Image.network(images[0].url),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        flex: 2,
                        child: HorizontalImageListWidget(
                          selectedImage: selectedImage,
                          images: images,
                          onAddNewImage: () async {
                            var image = await HomeRouteController.pickImage(
                                context, globals.user.userId, _scaffoldKey);
                            if (image != null) {
                              setState(() {
                                images.add(image);
                                selectedImage = images.length - 1;
                              });
                            }
                          },
                          onImageClick: (index) {
                            setState(() {
                              selectedImage = index;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
