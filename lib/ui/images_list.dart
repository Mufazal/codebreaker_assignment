import 'package:codebreaker_assignment/api/api_resource.dart';
import 'package:codebreaker_assignment/api/api_status.dart';
import 'package:codebreaker_assignment/controller.dart/movie_detail_provider.dart';
import 'package:codebreaker_assignment/controller.dart/movie_list_provider.dart';
import 'package:codebreaker_assignment/objects/image_model.dart';
import 'package:codebreaker_assignment/ui/image_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
        title: Text(
          "Images",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
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
              List<ImagesListObject> model =
                  ImagesListObject.getImagesList(resource.list);
              return Container(
                  child: StaggeredGridView.countBuilder(
                      itemCount: model.length,
                      crossAxisCount: 6,
                      crossAxisSpacing: 8,
                      padding: EdgeInsets.all(10),
                      mainAxisSpacing: 8,
                      itemBuilder: (context, index) {
                        return myItem(
                            height, width, model[index], context, index);
                      },
                      staggeredTileBuilder: (index) => StaggeredTile.count(2, 2)
                      // : StaggeredTile.count(1, 1),
                      ));
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

  myItem(height, width, ImagesListObject model, context, index) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                  create: (context) => MovieDetailProvider(),
                  child: MovieDetailScreen(id: model.id, model: model)),
            ));
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          // width: width * 0.15,
          // height: height * 0.13,

          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
                imageUrl: "${model.thumbnailUrl}",
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) {
                  return Container();
                }),
          ),
        ),
      ),
    );
  }
}
