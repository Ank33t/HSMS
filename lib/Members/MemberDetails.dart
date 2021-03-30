import 'package:flutter/material.dart';
import 'Member.dart';

class MemberDetails extends StatefulWidget {

  Member obj;
  MemberDetails(Member obj)
  {
    this.obj = obj;
  }

  @override
  _MemberDetailsState createState() => _MemberDetailsState(obj);


}

class _MemberDetailsState extends State<MemberDetails> {
String s ="Sfsd";
  Member member;
_MemberDetailsState(Member obj)
{
  this.member = obj;
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
      appBar: AppBar(title: Text("Member Details"),),
      body:
    SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //"activate", "bhk", "contact", "dateofentry", "dateofpurchase", "flat", "name", "previousowner"

            info(Icons.apartment ,"Address: " + member.flat),
            info(Icons.account_circle ,"Name: " + member.name),
            info(Icons.apartment ,"Type: " + member.bhk + " BHK"),
            info(Icons.call ,"Contact: " + member.contact),
            info(Icons.date_range ,"Entry: " + member.dateofentry),
            info(Icons.date_range ,"Purchase: " + member.dateofpurchase),
            info(Icons.supervisor_account_sharp ,"Previous Owner: " + member.previousowner),
            info(Icons.payment ,"Billing Activated: " + member.activate),
          ],
        ),
      ),
    );
  }
}
