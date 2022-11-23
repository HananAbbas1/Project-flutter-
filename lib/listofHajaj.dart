import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class ListOfHajaj extends StatefulWidget {
  String campaignnumber;
   ListOfHajaj({
    required this.campaignnumber
}) ;

  @override
  State<ListOfHajaj> createState() => _ListOfHajajState();
}

class _ListOfHajajState extends State<ListOfHajaj> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('الحجاج'),
        backgroundColor: kPrimaryColor,
      ),
      body: Center(
          child: HajajList(context)
      ),
    );
  }
  Widget HajajList (context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('hajjaj')
          .where('campaignnumber', isEqualTo: widget.campaignnumber)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor)));
        } else {
          return
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 10),
                shrinkWrap: true,
                //physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                //controller: listScrollController,
                itemBuilder: (context, index) =>
                    postDetails(snapshot.data!.docs[index]),
              ),
            );
        }
      },
    );
  }

  Widget postDetails(DocumentSnapshot document) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(document['id'], style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),),
                SizedBox(width: 20,),
                Text(':رقم الهوية',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(width: 20,),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(document['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),),
                SizedBox(width: 20,),
                Text(':اسم الحاج',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),),
              ],
            ),
          ],
        )
    ]);
  }
}

