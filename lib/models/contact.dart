import '../models/models.dart';

class Contact{
  final String name;
  final String id;
  final List<Message> messages;
  final String? imageUrl;
  final List<String> mediaUrls;
  Contact({required this.name, required this.id, required this.messages, this.mediaUrls = const [], this.imageUrl,});
}
