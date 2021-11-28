import 'package:codebreaker_assignment/api/api_status.dart';
import 'package:codebreaker_assignment/controller.dart/movie_detail_provider.dart';
import 'package:codebreaker_assignment/objects/movie_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:codebreaker_assignment/api/api_resource.dart';
import 'package:codebreaker_assignment/api/api_services.dart';
import 'package:codebreaker_assignment/utils/utils.dart';
import 'package:flutter/cupertino.dart';

class MovieDetailScreen extends StatelessWidget {
  final int id;

  MovieDetailScreen({this.id});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var controller = Provider.of<MovieDetailProvider>(context, listen: false);
    controller.getMovieDetail(id);
    return Material(
      child: SafeArea(
        child: Container(
          height: height,
          width: width,
          child: Consumer<MovieDetailProvider>(
              builder: (context, snapshot, child) {
            String genres;
            if (snapshot.model == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              if (snapshot.model != null) {
                PsResource resource = snapshot.model;

                if (resource.status == PsStatus.SUCCESS) {
                  MovieDetail model = MovieDetail.fromJson(resource.data);
                  genres = "${model.genres.map((e) => e.name)}";

                  genres = genres.replaceAll("(", "").replaceAll(")", "");

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: height * 0.3,
                        // color: Colors.red,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                "https://image.tmdb.org/t/p/w500${model.posterPath}",
                              ),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.03,
                            left: width * 0.05,
                            bottom: height * 0.02),
                        child: Container(
                          child: Text(
                            "${model.originalTitle}",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: width * 0.07, right: width * 0.07),
                        alignment: Alignment.center,
                        //  color: Colors.red,
                        child: Container(
                          height: height * 0.05,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            //   borderRadius: BorderRadius.circular(10),
                            // border: Border.all(color: Colors.black),
                          ),
                          child: Text(
                            "Watch Trailer",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.03, left: width * 0.05),
                        child: Container(
                          child: Text(
                            "Genres",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.005,
                            left: width * 0.05,
                            right: width * 0.05),
                        child: Container(child: Text("$genres")
                            // ListView(
                            //     scrollDirection: Axis.horizontal,
                            //     children: List.generate(
                            //         snapshot.model.genres.length,
                            //         (index) => Text(
                            //               "${snapshot.model.genres[index].name}",
                            //               style: TextStyle(
                            //                   fontSize: 19, fontWeight: FontWeight.bold),
                            //             ))),
                            ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.03, left: width * 0.05),
                        child: Container(
                          child: Text(
                            "Date",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.005, left: width * 0.05),
                        child: Container(
                          child: Text(
                            "${model.releaseDate}",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.03, left: width * 0.05),
                        child: Container(
                          child: Text(
                            "Overview",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.005,
                            left: width * 0.05,
                            right: width * 0.05),
                        child: Container(
                          child: Text(
                            "${model.overview}",
                            maxLines: 8,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(
                    child: Center(
                      child: Text("Connection Error"),
                    ),
                  );
                }
              } else {
                return Container();
              }
            }
          }),
        ),
      ),
    );
  }
}
