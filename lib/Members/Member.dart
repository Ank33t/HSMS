class Member
{
  String activate;
  String bhk;
  String contact;
  String dateofentry;
  String dateofpurchase;
  String flat;
  String name;
  String previousowner;
  // Member1(){
  //
  // }


  Member(this.activate, this.bhk, this.contact, this.dateofentry,
      this.dateofpurchase, this.flat, this.name, this.previousowner);

  Map toJson() => {
    'activate': activate,
    'bhk': bhk,
    'contact': contact,
    'dateofentry': dateofentry,
    'dateofpurchase': dateofpurchase,
    'flat': flat,
    'name': name,
    'previousowner': previousowner,
  };

}