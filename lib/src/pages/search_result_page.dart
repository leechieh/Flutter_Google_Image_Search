import 'package:image_search/index.dart';
import 'package:image_search/src/components/image_grid_item.dart';

class SearchResultPage extends StatefulWidget {
  final SearchResponse searchResponse;

  const SearchResultPage({required this.searchResponse, Key? key})
      : super(key: key);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  late int itemsNumber;

  @override
  void initState() {
    super.initState();
    itemsNumber = (widget.searchResponse.imagesResults.length < 18)
        ? widget.searchResponse.imagesResults.length
        : 18;
  }

  @override
  Widget build(BuildContext context) {
    final List<ImageGridItem> list = [];

    for (dynamic entry in widget.searchResponse.imagesResults) {
      list.add(
        ImageGridItem(
          original: entry['original'],
          originalImage: Image.network(entry['original']),
          position: entry['position'],
          link: entry['link'],
          thumbnail: entry['thumbnail'],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollNotification) {
            if (scrollNotification.metrics.pixels ==
                scrollNotification.metrics.maxScrollExtent) {
              setState(() {
                itemsNumber += 9;
              });
            }
            return false;
          },
          child: Container(
            color: Colors.black,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1 / 1,
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemCount:
                  (itemsNumber < list.length) ? itemsNumber : list.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 2, bottom: 2),
              itemBuilder: ((BuildContext context, int index) {
                precacheImage(list[index].originalImage.image, context);
                return list[index];
              }),
            ),
          ),
        ),
      ),
    );
  }
}
