

import '../models/models.dart';

class User {
  final String id;
  final String name;
  List<Contact> conversations;
  User({
    required this.conversations,
    required this.id, required this.name, this.messages = const []});
  String get initials => '${name[0]}${name[1]}';
  static final List<User> users = [
    User(id: '1', name: 'Praveen Pilli', messages: [
      Message(
        id: '1',
        text: 'Heyy,, How are you?',
        isMine: false,
        time: DateTime.now(),
      ),
      Message(
        id: '2',
        text: 'Im good, Thank you',
        time: DateTime.now(),
      ),
    ]),
    User(id: '9', name: 'Shweta Singh', messages: [
      Message(
        id: '1',
        text: 'Heyy,, How are you?',
        time: DateTime.now(),
      ),
    ]),
    User(id: '8', name: 'Sangit banik', messages: [
      Message(
        id: '1',
        text: 'Heyy,, How are you?',
        time: DateTime.now(),
      ),
    ]),
    User(id: '7', name: 'Priyanka Paul', messages: [
      Message(
        id: '1',
        text: 'Heyy,, How are you?',
        time: DateTime.now(),
      ),
    ]),
    User(id: '6', name: 'Sagar Paul', messages: [
      Message(
        id: '1',
        text: 'Heyy,, How are you?',
        time: DateTime.now(),
      ),
    ]),
    User(id: '5', name: 'Gopi krishna', messages: [
      Message(
        id: '1',
        text: 'Heyy,, How are you?',
        time: DateTime.now(),
      ),
    ]),
    User(id: '4', name: 'Sashi Guduri', messages: [
      Message(
        id: '1',
        text: 'Heyy,, How are you?',
        time: DateTime.now(),
      ),
    ]),
    User(id: '3', name: 'Random Stranger', messages: [
      Message(
        id: '1',
        text: 'Heyy,, How are you?',
        time: DateTime.now(),
      ),
    ]),
    User(id: '2', name: 'Boss', messages: [
      Message(
        id: '1',
        text: 'Heyy,, How are you?',
        time: DateTime.now(),
      ),
    ]),
  ];
}
