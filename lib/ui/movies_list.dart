import 'package:codebreaker_assignment/api/api_resource.dart';
import 'package:codebreaker_assignment/api/api_status.dart';
import 'package:codebreaker_assignment/controller.dart/movie_detail_provider.dart';
import 'package:codebreaker_assignment/controller.dart/movie_list_provider.dart';
import 'package:codebreaker_assignment/objects/movie_list_object.dart';
import 'package:codebreaker_assignment/ui/movie_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MoviesListScreen extends StatelessWidget {
  MoviesListScreen({Key key}) : super(key: key);
  GlobalKey _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var controller = Provider.of<MovieListProvider>(context, listen: false);

    controller.getMovies();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Ten Twenty App"),
      ),
      body: Container(
        height: height,
        width: width,
        child: Consumer<MovieListProvider>(builder: (context, snapshot, child) {
          if (snapshot.model == null) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.isConnected == false) {
            return Container(
              child: Center(
                child: Text("Internet connection error..."),
              ),
            );
          } else if (snapshot.model != null) {
            PsResource resource = snapshot.model;

            if (resource.status == PsStatus.SUCCESS) {
              MovieList model = MovieList.fromJson(resource.data);
              return Container(
                child: ListView.builder(
                  itemCount: model.results.length,
                  itemBuilder: (context, index) => myItem(
                      height, width, model.results[index], context, index),
                ),
              );
            } else if (resource.status == PsStatus.ERROR) {
              return Container(
                child: Center(
                  child: Text("Connection Error"),
                ),
              );
            } else {
              return Container();
            }
          } else {
            return Container();
          }
        }),
      ),
    );
  }

  myItem(height, width, Results model, context, index) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                  create: (context) => MovieDetailProvider(),
                  child: MovieDetailScreen(
                    id: model.id,
                  )),
            ));
      },
      child: Padding(
        padding: EdgeInsets.only(
            top: index == 0 ? height * 0.01 : 0, left: width * 0.04),
        child: Container(
          height: height * 0.15,
          width: width,

          //  color: Colors.blue,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //================================ Image Container Use Here ========================\\\
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: width * 0.15,
                      height: height * 0.13,
                      decoration: BoxDecoration(
                          //   color: Colors.blue.withOpacity(0.7),
                          // borderRadius: BorderRadius.circular(15.0),
                          // border: Border.all(color: Colors.blue, width: 2),
                          // boxShadow: [
                          //   BoxShadow(
                          //     offset: Offset(0.0, 0.0),
                          //     blurRadius: 10.0,
                          //     spreadRadius: 5.0,
                          //     color: Color.fromRGBO(196, 196, 196, 1),
                          //   )
                          // ],
                          // image: DecorationImage(
                          //   fit: BoxFit.fill,
                          //   image: NetworkImage(
                          //     "https://image.tmdb.org/t/p/w500${model.posterPath}",
                          //   ),
                          // ),
                          ),
                      child: CachedNetworkImage(
                          imageUrl:
                              "https://image.tmdb.org/t/p/w500${model.posterPath}",
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) {
                            return Container();
                          }),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      // color: Colors.red,
                      height: height * 0.1,
                      child: Padding(
                        padding: EdgeInsets.only(left: width * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                "${model.title}",
                                maxLines: 2,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: height * 0.004),
                              child: Container(
                                child: Text(
                                  "${model.releaseDate}",
                                  maxLines: 1,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: height * 0.005),
                              child: Expanded(
                                child: Container(
                                  width: width,
                                  child: Text(
                                    "${model.adult == true ? "adult" : "Non adult"}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // width: width * 0.22,
                    margin: EdgeInsets.only(left: 2, right: width * 0.05),
                    alignment: Alignment.center,
                    //  color: Colors.red,
                    child: Container(
                      height: height * 0.05,
                      width: width * 0.22,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey)),
                      child: Text(
                        "BOOK",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(left: width * 0.2, right: width * 0.2),
                child: Container(
                    height: height,
                    alignment: Alignment.bottomCenter,
                    child: Divider(height: 20)),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
