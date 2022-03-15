// ignore_for_file: file_names, unnecessary_new, sized_box_for_whitespace, void_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class OnlineConsultation extends StatefulWidget {
  const OnlineConsultation({Key key}) : super(key: key);

  @override
  _OnlineConsultationState createState() => _OnlineConsultationState();
}

class _OnlineConsultationState extends State<OnlineConsultation>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  TextEditingController searchController = TextEditingController();

  // ignore: unused_field
  void initState() {
    tabController = TabController(
      length: 5,
      vsync: this,
      initialIndex: 0,
    );
    super.initState();
  }

  CollectionReference getAllDoctors =
      FirebaseFirestore.instance.collection("doctors");

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: () => Scaffold(
              backgroundColor: HexColor("#f5fcfd"),
              appBar: AppBar(
                backgroundColor: HexColor("#f5fcfd"),
                elevation: 0.0,
                title: Column(
                  children: const [
                    Text(
                      'Hello,',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 15),
                    ),
                    SizedBox(width: 20),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                      ),
                      child: Text('Hagar!',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          )),
                    )
                  ],
                ),
                actions: const [
                  Padding(
                    padding: EdgeInsets.only(
                      right: 33.0,
                      top: 17.0,
                    ),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          'https://scontent.fcai19-2.fna.fbcdn.net/v/t1.6435-9/76756956_541783479990120_7873921895458930688_n.jpg?_nc_cat=109&ccb=1-5&_nc_sid=8bfeb9&_nc_ohc=avbQkIdWqH0AX-2j8k7&_nc_ht=scontent.fcai19-2.fna&oh=00_AT-uuv0Xu24Y69tINFIW6b0YxzFqSZsAzi7x1LmgdOWWiQ&oe=6253E288'),
                    ),
                  )
                ],
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30.0,
                      top: 30.0,
                      right: 30.0,
                    ),
                    child: new Directionality(
                      textDirection: TextDirection.ltr,
                      child: new TextField(
                          controller: searchController,
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                          decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.search, color: HexColor("#898a8a")),
                            filled: true,
                            fillColor: HexColor("#d9e1df"),
                            hintText: 'Search Doctor',
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor("#d9e1df")),
                              borderRadius: new BorderRadius.circular(10.7),
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: HexColor("#d9e1df")),
                                borderRadius: new BorderRadius.circular(10.7)),
                          )),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    padding: const EdgeInsets.only(
                      top: 29,
                      left: 30,
                    ),
                    child: Text(
                      'Doctors',
                      style: TextStyle(
                        color: HexColor("#000000"),
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                          controller: tabController,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          labelPadding:
                              const EdgeInsets.only(left: 20, right: 20),
                          isScrollable: true,
                          tabs: [
                            Tab(text: "Dermatology"),
                            Tab(text: "Dentistry"),
                            Tab(text: "Neurology"),
                            Tab(text: "Orthopedics"),
                            Tab(text: "Ophthalmology"),
                          ]),
                    ),
                  ),
                  Container(
                      width: double.maxFinite,
                      height: 300,
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          //-----------------------
                          Container(
                            padding: const EdgeInsets.only(
                              top: 24,
                              left: 30,
                            ),
                            alignment: AlignmentDirectional.topStart,
                            child: StreamBuilder(
                                stream: getAllDoctors.snapshots(),
                                // ignore: missing_return
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return const Text("Error");
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Text("Waiting");
                                  }
                                  if (snapshot.hasData) {
                                    return Expanded(
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: snapshot.data.docs.length,
                                          itemBuilder: (context, i) {
                                            return Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                      width: 140,
                                                      height: 120,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                '${snapshot.data.docs[i].data()['image']}'),
                                                            fit: BoxFit.fill),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color:
                                                            HexColor('#80B1FE'),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 180,
                                                      height: 90,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2),
                                                            spreadRadius: 2,
                                                            blurRadius: 2,
                                                            offset: const Offset(
                                                                0,
                                                                2), // changes position of shadow
                                                          ),
                                                        ],
                                                        color:
                                                            HexColor('#FFFFFF'),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              top: 14,
                                                            ),
                                                            child: Text(
                                                              '${snapshot.data.docs[i].data()['name']}',
                                                              style: TextStyle(
                                                                color: HexColor(
                                                                    '#000000'),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            '${snapshot.data.docs[i].data()['sr']}',
                                                            style: TextStyle(
                                                              color: HexColor(
                                                                  '#7c7a77'),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  top: 11,
                                                                  left: 27,
                                                                ),
                                                                child: RatingBar
                                                                    .builder(
                                                                  initialRating:
                                                                      4,
                                                                  minRating: 1,
                                                                  itemSize: 15,
                                                                  direction: Axis
                                                                      .horizontal,
                                                                  allowHalfRating:
                                                                      true,
                                                                  itemCount: 5,
                                                                  itemPadding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          4.0),
                                                                  itemBuilder:
                                                                      (context,
                                                                              _) =>
                                                                          const Icon(
                                                                    Icons.star,
                                                                    color: Colors
                                                                        .amber,
                                                                  ),
                                                                  onRatingUpdate:
                                                                      (rating) {
                                                                    // ignore: avoid_print
                                                                    print(
                                                                        rating);
                                                                  },
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  top: 11,
                                                                  left: 10.0,
                                                                ),
                                                                child: InkWell(
                                                                  child: Icon(
                                                                      Icons
                                                                          .arrow_forward_rounded,
                                                                      size:
                                                                          18.0,
                                                                      color: HexColor(
                                                                          '#787575')),
                                                                  onTap: () {},
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(width: 20.0),
                                              ],
                                            );
                                            // Text(
                                            //   '${snapshot.data.docs[i].data()['name']}');
                                          }),
                                    );
                                  }
                                  return Text("Loading");
                                }),
                          ),
                          Container(),
                          Container(),
                          Container(),
                          Container(),
                        ],
                      )),
                ],
              ),
            ));
  }
}
