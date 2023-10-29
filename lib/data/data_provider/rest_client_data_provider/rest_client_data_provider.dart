import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../utilities/constant.dart';
part 'rest_client_data_provider.g.dart';



@RestApi(baseUrl: "https://api.nytimes.com/svc/topstories/v2/")
abstract class RestClientDataProvider {
  factory RestClientDataProvider(Dio dio, {String baseUrl}) = _RestClientDataProvider;

  @GET("/{sectionName}.json?api-key=$apiKey")
  Future<HttpResponse> getTopStoriesBySection(@Path("sectionName") String sectionName);

}


