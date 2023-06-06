import 'dart:io';
import 'package:http/http.dart' as http;

class ImageDataSource {
  Future<bool> uploadImage(File image) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://35.180.62.182/api/testing/upload'),
      );
      request.files.add(await http.MultipartFile.fromPath('file', image.path));
      final response = await request.send();
      return response.statusCode == 200;
    } catch (e) {
      print('Error uploading image: $e');
      return false;
    }
  }
}