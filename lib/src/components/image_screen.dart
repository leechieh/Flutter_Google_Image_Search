import 'dart:io';
import 'package:image_search/index.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({
    Key? key,
    required this.originalImage,
    required this.original,
  }) : super(key: key);

  final CachedNetworkImageProvider originalImage;
  final String original;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: PhotoView(
              imageProvider: originalImage,
            ),
          ),
          Positioned(
            top: 20,
            right: 10,
            child: IconButton(
              iconSize: 30,
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close_rounded,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: MediaQuery.of(context).size.width / 2 - 23,
            child: IconButton(
              color: Colors.black,
              onPressed: () async {
                bool pass = false;
                if (Platform.isIOS) {
                  pass = await Permission.photos.request().isGranted;
                  if (!pass) {}
                }
                if (pass || Platform.isAndroid) {
                  GallerySaver.saveImage(original);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Image Saved',
                      ),
                    ),
                  );
                }
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
  }
}
