class DataModel{
  /*
   {
    "id": 0,
    "name": "Gulab Jamun",
    "discription": "The soft and syrupy Gulab Jamun makes its way to the top in a marriage sweets list. The spongy dough balls made with Khoya and fried in saffron syrup tastes like heaven when eaten warm.",
    "imageUrl": "https://m.media-amazon.com/images/I/81S-ekaE+vS._AC_UL320_.jpg",
    "published_date": "2022-08-20",
    "event_date": "799"
  */

  //data Type
  int? id;
  String? name;
  String? discription;
  String? imageURL;
  String? published_date;
  String? event_date;

// constructor
  DataModel(
      {
        this.id,
        this.name,
        this.discription,
        this.imageURL,
        this.published_date,
        this.event_date
      }
      );

  //method that assign values to respective datatype vairables
  DataModel.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    name =json['name'];
    discription = json['discription'];
    imageURL = json['imageUrl'];
    published_date = json['published_date'];
    event_date = json['event_date'];
  }
}