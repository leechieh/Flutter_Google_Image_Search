import 'package:image_search/index.dart';

class SearchResultPage extends StatefulWidget {
  // final SearchResponse searchResponse;
  final List<ImageGridItem> searchResponse;
  final String searchTerm;

  const SearchResultPage(
      {required this.searchResponse, required this.searchTerm, Key? key})
      : super(key: key);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  late int itemsNumber;
  late ScrollController _scrollController;
  late List<ImageGridItem> showList = [];

  @override
  void initState() {
    super.initState();
    itemsNumber =
        (widget.searchResponse.length < 18) ? widget.searchResponse.length : 18;
    _scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    for (int index = 0; index < itemsNumber; index++) {
      if (index < itemsNumber) {
        showList.add(widget.searchResponse[index]);
        index += 1;
      }
    }
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent * 0.8 &&
        !_scrollController.position.outOfRange) {
      setState(() {
        itemsNumber = (itemsNumber + 12 <= widget.searchResponse.length)
            ? itemsNumber + 12
            : widget.searchResponse.length;
        addItemIntoLisT(itemsNumber);
      });
    }
  }

  void addItemIntoLisT(int totalItemCount) {
    for (int i = showList.length; i < totalItemCount; i++) {
      showList.add(widget.searchResponse[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.searchTerm,
        ),
      ),
      body: Center(
        child: GridView.count(
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          crossAxisCount: 3,
          childAspectRatio: 1 / 1,
          physics: const AlwaysScrollableScrollPhysics(),
          children: showList,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
