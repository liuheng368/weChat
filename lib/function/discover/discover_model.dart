class DiscoverModel {
  final String imageName;
  final String title;
  final String subTitle;
  final String subImageName;

  DiscoverModel({this.imageName, this.title, this.subTitle, this.subImageName})
      : assert(imageName.length > 0 && title.length > 0);
}
