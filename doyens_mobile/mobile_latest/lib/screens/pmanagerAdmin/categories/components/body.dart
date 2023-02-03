import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/screens/home/components/body.dart';
import 'package:shop_app/size_config.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: TextField(
              controller: myController,
              style: new TextStyle(
                  fontSize: 12.0,
                  color: const Color(0xFF000000),
                  fontWeight: FontWeight.w200,
                  fontFamily: "Roboto"),
            ),
          ),
          ElevatedButton(
              onPressed: () => addCategory(myController.text),
              child: Text("Add New")),
        ]),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('categories').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else
                return ListView(
                  children: (snapshot.data!).docs.map((doc) {
                    return Card(
                      child: Dismissible(
                        key: Key(doc["name"]),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) async {
                          await removeCategory(doc["name"]);
                        },
                        background: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFE6E6),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Spacer(),
                              SvgPicture.asset("assets/icons/Trash.svg"),
                            ],
                          ),
                        ),
                        child: ListTile(
                          title: Text(doc["name"]),
                        ),
                      ),

                      /* child: ListTile(
                        title: Text(doc["name"]),
                      ),*/
                    );
                  }).toList(),
                );
            },
          ),
        ),
      ],
    );
  }

  removeCategory(String name) async {
    await FirebaseFirestore.instance
        .collection("categories")
        .where("name", isEqualTo: name)
        .get()
        .then((snapshot) => {
              for (DocumentSnapshot ds in snapshot.docs) {ds.reference.delete()}
            });
  }

  addCategory(String name) {
    String docID = FirebaseFirestore.instance.collection("categories").doc().id;
    FirebaseFirestore.instance
        .collection("categories")
        .doc(docID)
        .set({"id": docID, "name": name});

    myController.clear();
  }
}
