class House {
  String? key;
  final int? id;
  final String? image;
  final int? price;
  final int? bedrooms;
  final int? bathrooms;
  final int? size;
  final String? description;
  final String? zip;
  final String? city;
  final int? latitude;
  final int? longitude;

  House({
    this.key,
    this.id,
    this.image,
    this.price,
    this.bedrooms,
    this.bathrooms,
    this.size,
    this.description,
    this.zip,
    this.city,
    this.latitude,
    this.longitude,
  });

  factory House.fromJson(Map<String, dynamic> json) {
    return House(
      key: json['key'],
      id: json['id'],
      image: json['image'],
      price: json['price'],
      bedrooms: json['bedrooms'],
      bathrooms: json['bathrooms'],
      size: json['size'],
      description: json['description'],
      zip: json['zip'],
      city: json['city'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'price': price,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'size': size,
      'description': description,
      'zip': zip,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
