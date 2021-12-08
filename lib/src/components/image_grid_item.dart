
import 'package:image_search/index.dart';

class ImageGridItem extends StatelessWidget {
  final String thumbnail;
  final String original;
  final int position;
  final String link;
  final CachedNetworkImageProvider originalImage;

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
              return ImageScreen(
                  originalImage: originalImage, original: original);
            },
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: thumbnail,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
