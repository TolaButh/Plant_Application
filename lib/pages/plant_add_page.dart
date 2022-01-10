// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:plantapp/core/consts.dart';
import 'package:plantapp/models/plant_model.dart';
import 'package:plantapp/widgets/animation_widget.dart';
import 'package:plantapp/widgets/clipper_widget.dart';

class PlantAddPage extends StatefulWidget {
  final PlantModel plantModel;
  PlantAddPage({required this.plantModel});

  @override
  _PlantAddPageState createState() => _PlantAddPageState();
}

class _PlantAddPageState extends State<PlantAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {  Navigator.of(context).pop();},
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.lightMainColor,
                  AppColors.mainColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          ClipPath(
            clipper: ClipperWidger(),
            child: Container(
              color: AppColors.mainColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Image.asset(
                        "assets/${widget.plantModel.id}.png",
                        height: 60,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          widget.plantModel.type
                              .toString()
                              .replaceFirst("PlantTypeModel.", ""),
                          style: TextStyle(color: Colors.black38),
                        ),
                        Text(
                          // ignore: unnecessary_string_interpolations
                          "${widget.plantModel.name}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        padding: EdgeInsets.all(3),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
             alignment: Alignment.center,
            // ignore: sized_box_for_whitespace
            child: Container(
             
              width: 300,
              child: Image.asset(
                "assets/${widget.plantModel.id}.png",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: AnimationScan(),
          ),
        ],
      ),
    );
  }
}
