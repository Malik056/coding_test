import 'package:cached_network_image/cached_network_image.dart';
import 'package:coding_test/models/image_object.dart';
import 'package:flutter/material.dart';

class HorizontalImageListWidget extends StatelessWidget {
  final List<ImageObject> images;
  final void Function() onAddNewImage;
  final int selectedImage;
  final void Function(int) onImageClick;
  const HorizontalImageListWidget(
      {Key key,
      this.images,
      this.onAddNewImage,
      this.onImageClick,
      this.selectedImage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      double height = constraints.biggest.height ?? constraints.maxHeight;
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            images.length,
            (index) => GestureDetector(
              onTap: () => onImageClick(index),
              child: Container(
                decoration: selectedImage == index
                    ? ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                      )
                    : null,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: images[index].url,
                    fadeInDuration: Duration.zero,
                    fadeOutDuration: Duration.zero,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    height: height,
                    width: height,
                  ),
                ),
              ),
            ),
          )..add(
              Center(
                child: FlatButton(
                  onPressed: onAddNewImage,
                  child: Container(
                    width: height,
                    height: height,
                    color: Theme.of(context).primaryColor.withAlpha(100),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add_a_photo),
                        SizedBox(height: 4),
                        Text("Add Image"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ),
      );
    });
  }
}
