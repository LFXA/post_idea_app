
 class Post {
    Post(this._id, this.author, this.category, this.content, this.created, this.excerpt, this.image, this.image_caption, this.lang, this.path,  this.tags, this.title);



  final String _id;
   final String author;
   final String category;
   final String content;
   final DateTime created;
   final String excerpt;
   final String image;
   final String image_caption;
   final String lang;
   final String path;
   final List<Object> tags;
   final String title;

    String get id => _id;


}