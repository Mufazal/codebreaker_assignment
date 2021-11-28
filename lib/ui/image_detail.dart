import 'package:cached_network_image/cached_network_image.dart';
import 'package:codebreaker_assignment/objects/image_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MovieDetailScreen extends StatelessWidget {
  final int id;
  final ImagesListObject model;

  MovieDetailScreen({this.id, this.model});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    // controller.getMovieDetail(id);
    return Material(
      child: SafeArea(
        child: Container(
            height: height,
            width: width,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: height * 0.6,
                    width: width,
                    // color: Colors.red,

                    child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        width: width,
                        imageUrl: "${model.url}",
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) {
                          return Container();
                        })),
                Padding(
                  padding: EdgeInsets.only(
                    top: height * 0.03,
                    left: width * 0.03,
                    right: width * 0.03,
                  ),
                  child: Container(
                    child: Text(
                      "${model.title}",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 19,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
