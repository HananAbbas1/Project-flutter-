import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Permissions extends StatefulWidget {
  String Id;
  Permissions({required this.Id});

  @override
  State<Permissions> createState() => _PermissionsState();
}

class _PermissionsState extends State<Permissions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('التصاريح'),
        backgroundColor: kPrimaryColor,
      ),
      body: Center(child: permissionget(context)),
    );
  }

  Widget permissionget(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('permissions')
            .doc(widget.Id)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return SafeArea(
              child: Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(kPrimaryColor))),
            );
          } else {
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'تصريح لرمي الجمرات',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        snapshot.data!['timeout'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        'وقت الخروج',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        snapshot.data!['timein'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        'وقت الدخول',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  QrImage(
                    data: 'This QR code has an embedded image as well',
                    version: QrVersions.auto,
                    size: 320,
                    foregroundColor: Colors.green.shade700,
                    gapless: false,
                    embeddedImage: AssetImage('assets/images/52.png'),
                    embeddedImageStyle: QrEmbeddedImageStyle(
                      size: Size(100, 100),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
