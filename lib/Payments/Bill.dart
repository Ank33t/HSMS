class Bills
{
    String date;
    String detail;
    String desc;
    String client;
    String price;

    Bills(this.date, this.detail, this.desc, this.client, this.price);

    Map toJson() => {
      'date': date,
      'detail': detail,
      'desc': desc,
      'client': client,
      'price': price
    };
}