class subModel {
   int id ;
   String name ;
   int count ;
   int price ;

   subModel({this.id, this.name, this.count, this.price});

   factory subModel.fromJson (Map<String , dynamic > json ){
    return subModel(
         id : json['id'],
         name : json['name'],
         count : json['count'],
         price: json['price'],
    );
   }
}