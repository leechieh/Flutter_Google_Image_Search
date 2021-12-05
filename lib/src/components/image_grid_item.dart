import 'package:image_search/index.dart';

class ImageGridItem extends StatelessWidget {
  final String thumbnail;
  final String original;
  final int position;
  final String link;
  final Image originalImage;

  const ImageGridItem({
    required this.original,
    required this.thumbnail,
    required this.position,
    required this.link,
    required this.originalImage,
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(
    BuildContext context,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (
              BuildContext context,
            ) {
              return Scaffold(
                body: Stack(
                  children: <Widget>[
                    SizedBox.expand(
                      child: PhotoView(
                        imageProvider: originalImage.image,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: MediaQuery.of(context).size.width / 2 - 23,
                      child: IconButton(
                        color: Colors.black,
                        onPressed: () {
                          GallerySaver.saveImage(original);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Image Saved',
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.save,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Image.network(
          thumbnail,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
