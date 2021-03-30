class Service
{
  String name;
  String service;
  String address;
  String contact;
  String url;

  Service(this.name, this.service, this.address, this.contact, this.url);

  Map toJson() => {
    'name': name,
    'service': service,
    'address': address,
    'contact': contact,
    'url': url
  };
}