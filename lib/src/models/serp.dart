import 'package:image_search/index.dart';
import 'package:http/http.dart' as http;

const String serpKey =
    '103d703e1130f9c8fef19a36d30162a40bb756abc0fa2e6ef791e70c37fec343';

String requestUrl({
  required String searchTerm,
}) {
  return 'https://serpapi.com/search.json?q=$searchTerm&tbm=isch&api_key=$serpKey';
}

class SearchResponse {
  final Map<String, dynamic> searchMetadata;
  final Map<String, dynamic> searchParameters;
  final List<dynamic> imagesResults;

  SearchResponse({
    required this.searchMetadata,
    required this.searchParameters,
    required this.imagesResults,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      searchMetadata: json['search_metadata'],
      searchParameters: json['search_parameters'],
      imagesResults: json['images_results'],
    );
  }
}

Future<SearchResponse> getSearchResponse({
  required String searchTerm,
  String searchEngine = 'google',
}) async {
  http.Response response = await http.get(
    Uri.parse(
      requestUrl(
        searchTerm: searchTerm,
      ),
    ),
  );
  if (response.statusCode == 200) {
    return SearchResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to get a response');
  }
}
