import 'package:flutter/cupertino.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../static.dart';

class AddReviewNotification extends StatefulWidget {
  @override
  _AddReviewNotificationState createState() => _AddReviewNotificationState();
}

class _AddReviewNotificationState extends State<AddReviewNotification> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32),
          child:
                 Row(
                      children: [
                      /*   Container(
                          width: 90,
                          height: 80,
                          color: Colors.red[100],
                          child: Image(
                            image: NetworkImage(
                              products[index].image,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ), */
                        Container(
                          width: 180,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Ya Rab Ya Kariem",
                                  style: TextStyle(
                                    color: Colors.red[900],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    letterSpacing: 1,
                                    height: 2,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                /* Container(
                                  child: RatingBarIndicator(
                                    rating: 2.75,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 15.0,
                                    direction: Axis.horizontal,
                                  ),
                                ), */
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
    );
  }
}