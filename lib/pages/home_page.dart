// ignore_for_file: prefer_const_constructors, unused_field

import 'package:flutter/material.dart';
import 'package:plantapp/core/consts.dart';
import 'package:plantapp/models/plant_model.dart';
import 'package:plantapp/models/plant_type_model.dart';
import 'package:plantapp/pages/plant_add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  late double _offset;

  late List<PlantModel> _plants;
  @override
  void initState() {
    _scrollController = ScrollController();
    _offset = 0.0;

    _plants = PlantModel.plants;
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);

    super.dispose();
  }

  _scrollListener() {
    setState(() {
      if (_scrollController.offset < 75) {
        _offset = _scrollController.offset;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: PlantTypeModel.values.length,
        child: NestedScrollView(
            controller: _scrollController,
            // ignore: duplicate_ignore
            headerSliverBuilder: (context, index) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.white,
                  expandedHeight: 125,
                  pinned: true,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    ),
                  ),
                  actions: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                    )
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsetsDirectional.only(
                      start: 12 + ((_offset / 100) * 60),
                      bottom: 17,
                    ),
                    title: Text(
                      'New Plants',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ];
            },
            body: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                _buildSearchWidget(),
                _buildTabBar(),
                // ignore: prefer_const_literals_to_create_immutables
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      ...PlantTypeModel.values.map((e) {
                        return ListView(
                          padding: EdgeInsets.all(0),
                          // ignore: prefer_const_literals_to_create_immutables
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: SizedBox(
                                height: 300,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _plants.length,
                                  itemBuilder: (context, index) {
                                    return _buildItemSlide(index);
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                "Lastest favorites",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: ListView.builder(
                                padding: EdgeInsets.all(0.0),
                                shrinkWrap: true,
                                itemCount: _plants.length,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return _buildItemLatestFavorite(index);
                                },
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      isScrollable: true,
      indicatorColor: Colors.white,
      labelColor: AppColors.mainColor,
      unselectedLabelColor: Colors.black,
      labelStyle: TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),

      // ignore: prefer_const_literals_to_create_immutables
      tabs: <Widget>[
        ...PlantTypeModel.values.map((e) {
          return Tab(
            text: e.toString().replaceFirst("PlantTypeModel.", ""),
          );
        }),
      ],
    );
  }

  Widget _buildSearchWidget() {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          hintText: "Search",
          // ignore: avoid_unnecessary_containers
          suffixIcon: Container(
            decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            child: Icon(
              Icons.filter_list,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemSlide(int index) {
    // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
    return Container(
      width: 200,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PlantAddPage(
                  plantModel: _plants[index],
                ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                
                Text(
                  _plants[index]
                      .type
                      .toString()
                      .replaceFirst("PlantTypeModel.", ""),
                  style: TextStyle(color: Colors.black38),
                ),
                Text(
                  _plants[index].name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(child: SizedBox()),
                Image.asset("assets/${_plants[index].id}.png"),
                Expanded(
                  child: SizedBox(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          "From",
                          style: TextStyle(color: Colors.black38),
                        ),
                        Text(
                          "${_plants[index].price.toString()} \$",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    // ignore: avoid_unnecessary_containers
                    Container(
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
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemLatestFavorite(int index) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      child: Stack(
        children: <Widget>[
          // ignore: avoid_unnecessary_containers
          Align(
            alignment: Alignment.centerRight,
            // ignore: avoid_unnecessary_containers
            child: Container(
              padding: EdgeInsets.all(4),
              width: 100,
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildFavoriteButton(Icons.add, () {}),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Container(
                    width: 40,
                    height: .5,
                    color: Colors.black,
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  _buildFavoriteButton(Icons.remove, () {}),
                ],
              ),
            ),
          ),
          // ignore: sized_box_for_whitespace
          Container(
            padding: EdgeInsets.all(1),
            margin: EdgeInsets.only(right: 50),
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => PlantAddPage(
                              plantModel: _plants[index],
                            )),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      "assets/${_plants[index].id}.png",
                      height: 60,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        Text(
                          _plants[index]
                              .type
                              .toString()
                              .replaceFirst("PlantTypeModel.", ""),
                        ),
                        Text(
                          // ignore: unnecessary_string_interpolations
                          "${_plants[index].name}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "2",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      // ignore: sized_box_for_whitespace
      child: Container(
        width: 40,
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
