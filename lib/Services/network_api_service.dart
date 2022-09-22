import 'package:http/http.dart' as http;
import 'package:search_news/core/const.dart';

class NetworkApiService {
  // API to get all news data
  Future getNewsAPI() async {
    try {
      final response = await http.get(
        Uri.parse(Constants.newsUrl + Secret.secretKey),
      );

      if (response.statusCode == 200) {
        // print(response.body);
        return {"isSuccess": true, "data": response.body};
      } else {
        // print(response.body);
        return {"isSuccess": false, "data": response.body};
      }
    } on Exception catch (exception) {
      // print('Ecception = $exception');
      return {
        "isSuccess": false,
      };
      // only executed if error is of type Exception
    } catch (error) {
      // print('error =  $error');
      return {
        "isSuccess": false,
      };
      // executed for errors of all types other than Exception
    }
  }
}
