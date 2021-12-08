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
    bool linkBroken = false;
    precacheImage(
      originalImage,
      context,
      onError: (_, __) {
        linkBroken = true;
        precacheImage(
          CachedNetworkImageProvider(
            thumbnail,
          ),
          context,
        );
      },
    );
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
        return ImageScreen(
          originalImage: linkBroken
              ? CachedNetworkImageProvider(
                  thumbnail,
                )
              : originalImage,
          original: linkBroken ? thumbnail : original,
        );
      },
      transitionDuration: const Duration(
        milliseconds: 300,
      ),
    );
  }
}
