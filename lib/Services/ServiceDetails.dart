import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Service.dart';

class ServiceDetails extends StatefulWidget {

  Service obj;
  ServiceDetails(Service obj)
  {
    this.obj = obj;
  }

  @override
  _ServiceDetailsState createState() => _ServiceDetailsState(obj);
}

class _ServiceDetailsState extends State<ServiceDetails> {
  String s ="Sfsd";
  Service service;
  _ServiceDetailsState(Service obj)
  {
    this.service = obj;
    // print(obj.flat);
  }
  @override
  Widget build(BuildContext context) {
    info(icon, subtitle) {
      return subtitle != ""
          ? Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: 5),
            Row(
              children: [
                Icon(icon, size: 25, color: Colors.cyan),
                SizedBox(width: 12),
                Container(
                  // width: MediaQuery.of(context).size.width - 80,
                  child: Text(
                    subtitle,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            )
          ],
        ),
      )
          : Container();
    }
    return Scaffold(
      appBar: AppBar(title: Text("Service Details"),),
      body:
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 16.0,
                bottom: 8.0,
                left: 130,
              ),
              child: CircleAvatar(
                radius: 70.0,
                backgroundImage:
                NetworkImage(service.url),
              ),
            ),
            info(Icons.account_circle ,"Name: " + service.name),
            info(Icons.room_service ,"Service: " + service.service),
            info(Icons.apartment ,"Address: " + service.address),
            GestureDetector(onTap: (){ launch(('tel:${service.contact}'));}, child:info(Icons.call ,"Contact: " + service.contact),)
          ],
        ),
      ),
    );
  }
}
