class Resep{
  final String id;
  final String name;
  final String images;
  final String totalTime;
  final String description;
  final String rating;
  final String ingredient;
  final String instruction;
  final String videoUrl;

  Resep({required this.id, 
  required this.name, 
  required this.images, 
  required this.totalTime,
  required this.description,
  required this.rating,
  required this.ingredient,
  required this.instruction,
  required this.videoUrl
  });

  factory Resep.fromJson(Map<String, dynamic> json) =>
    Resep(
      id: json['id'],
      name: json['name'], 
      images: json['images'], 
      totalTime: json['totalTime'], 
      description: json['description'], 
      rating: json['rating'],
      ingredient: json['ingredient'],
      instruction: json['instruction'],
      videoUrl: json['videoUrl']
    );

  Map<String, dynamic> toJson() => {
    "id" : id,
    "name": name,
    "images": images,
    "totalTime": totalTime,
    "description": description,
    "rating": rating,
    "ingredient": ingredient,
    "instruction": instruction,
    "videoUrl": videoUrl,
    };
}