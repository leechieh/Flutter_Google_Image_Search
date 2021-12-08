import 'package:image_search/index.dart';

class SearchForm extends StatefulWidget {
  const SearchForm({Key? key}) : super(key: key);

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final _formKey = GlobalKey<FormState>();

  late String searchInput;
  late bool loading;

  @override
  void initState() {
    super.initState();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: SpinKitSpinningLines(
              color: Colors.black,
            ),
          )
        : Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'What would you like to search:',
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      30,
                      5,
                      30,
                      5,
                    ),
                    child: TextFormField(
                      initialValue: '',
                      onChanged: (String value) {
                        searchInput = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          SearchResponse response = await getSearchResponse(
                            searchTerm: searchInput,
                          );

                          final List<ImageGridItem> list = [];
                          for (dynamic entry in response.imagesResults) {
                            list.add(
                              ImageGridItem(
                                original:
                                    entry['original'] ?? entry['thumbnail'],
                                originalImage: CachedNetworkImageProvider(
                                    entry['original'] ?? entry['thumbnail']),
                                position: entry['position'],
                                link: entry['link'],
                                thumbnail: entry['thumbnail'],
                              ),
                            );
                          }
                          setState(() {
                            loading = false;
                          });

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) {
                              return SearchResultPage(
                                searchResponse: list,
                                searchTerm: response.searchParameters['q'],
                              );
                            }),
                          );
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
