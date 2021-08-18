import 'dart:convert';

import 'package:calmove/Modals/doctors_list_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorCellWidget extends StatelessWidget {
  final String ? thumbnailPath;
  final String ? doctorName;
  final String ? branchName;
  final String ? designation;

  DoctorCellWidget({this.thumbnailPath,this.doctorName,this.branchName,this.designation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 25.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ]
        ),
        child: Stack(
          children: [
            thumbnailPath != null && thumbnailPath!.isNotEmpty ? Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(top: 10.0,left: 10.0,bottom: 10.0),
              child: Image.network(
                thumbnailPath!,
                fit: BoxFit.fill,
              ),
            ) : Container(),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 140.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      doctorName!,
                      //textAlign: TextAlign.justify,
                      maxLines: 2,
                      //overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.cyan[700],
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      branchName!,
                      style: TextStyle(
                        color: Colors.cyan[700]
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      designation.toString(),
                      style: TextStyle(
                        color: Colors.cyan[700]
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  )
                              )
                          ),
                          onPressed: () {

                          },
                          child: const Text(
                            'Book Now',
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 5.0),
                          child: Container(
                            color: Colors.grey,
                            height: 40.0,
                            width: 1,
                          ),
                        ),
                        Column(
                          children: [
                            const Text(
                                '129 reviews',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.star,
                                  color: Colors.deepOrange,
                                  size: 15.0,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.deepOrange,
                                  size: 15.0,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.deepOrange,
                                  size: 15.0,
                                ),
                                Icon(
                                  Icons.star_border,
                                  size: 15.0,
                                  //color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star_border,
                                  size: 15.0,
                                  //color: Colors.yellow,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 5.0),
                          child: Container(
                            color: Colors.grey,
                            height: 40.0,
                            width: 1,
                          ),
                        ),
                        Icon(
                          Icons.
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }

}