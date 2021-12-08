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
    // precacheImage(originalImage, context);
    return OpenContainer(
      closedBuilder: (_, __) {
        return InkWell(
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: thumbnail,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      openBuilder: (BuildContext context, __) {
        return ImageScreen(originalImage: originalImage, original: original);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
