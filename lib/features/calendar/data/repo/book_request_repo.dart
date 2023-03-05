import '../book_request_client.dart';
import '../book_request_model.dart';

class BookRequestRepo {
  BookRequestClient bookRequestClient;

  BookRequestRepo(this.bookRequestClient);

  Future requestBook(BookRequestModel model) async {
    var response = await bookRequestClient.bookRequest(model);
  }
}
