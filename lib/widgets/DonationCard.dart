import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import '../CentralState.dart';
import 'package:provider/provider.dart';
import "../classes/ScreenArguments.dart";

class InfoPart extends StatelessWidget {
  InfoPart([this.title = "", this.tags = ""]);
  final String title;
  final String tags;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(
            height: 10,
          ),
          Text(tags),
          SizedBox(
            height: 10,
          )
        ]));
  }
}

class DonationImage extends StatelessWidget {
  DonationImage([this.image = ""]);
  //'https://placeimg.com/640/480/any'
  final String image;

  @override
  Widget build(BuildContext context) {
    if (image == "") return Text("invalid image");
    print("rendering card");
    if (this.image.indexOf(".jpg") == -1) return Text("bad image");

    return ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14), topRight: Radius.circular(14)),
        child: Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(),
          child: Image.network(image, fit: BoxFit.cover),
        ));
  }
}

class DonationCard extends StatelessWidget {
  DonationCard(
      [this.image = "",
      this.title = "",
      this.tags = "",
      this.id = "",
      this.donater = "",
      this.latitude = "",
      this.longitude = ""]);
  //'https://placeimg.com/640/480/any'
  final String image;
  final String title;
  final String tags;
  final String id;
  final String latitude;
  final String donater;
  final String longitude;
//
  @override
  Widget build(BuildContext context) {
    Function change = context.read<CentralState>().change;

    void gotoDetailsPage() {
      change("item-image", image);
      change("item-title", title);
      change("item-tags", tags);
      change("item-id", id);
      change("item-donater", donater);
      change("item-latitude", latitude);
      change("item-longitude", longitude);

      Navigator.pushNamed(
        context,
        '/donation-details',
      );
    }

    return Column(children: [
      SizedBox(
        height: 25,
      ),
      GestureDetector(
          onTap: gotoDetailsPage,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 2,
                color: Colors.black,
                style: BorderStyle.solid,
              ),
            ),
            child: Wrap(children: [
              DonationImage(this.image),
              InfoPart(this.title, this.tags)
            ]),
          ))
    ]);
  }
}
