import 'package:flutter/material.dart';
import 'package:pet_project/src/features/group_chat/model/group_chat_model.dart';

class GroupChatProvider with ChangeNotifier {
  // Group chat list
  List<GroupChatModel> _groupChats = [];

  // Favorites list
  List<bool> _favourites = [];

  // Pins list
  List<bool> _pens = [];


  List<GroupChatModel> get groupChats => _groupChats;

  // Initialize the group chat list and the favorites and pins lists
  void initialize(List<GroupChatModel> initialChats) {
    _groupChats = initialChats;
    _favourites = List.generate(initialChats.length, (
        index) => false); // Initialize favourites with default values
    _pens = List.generate(initialChats.length, (
        index) => false); // Initialize pins with default values
    notifyListeners();
  }

  // Add a new group and update favorites and pins lists
  void addGroup(GroupChatModel newGroup) {
    _groupChats.add(newGroup);
    _favourites.add(
        false); // Add a default false value for the new group in favourites
    _pens.add(false); // Add a default false value for the new group in pins
    notifyListeners(); // Notify listeners of changes
  }


  // Toggle the favourite status of a group
  void toggleFavourite(int index) {
    if (index < _favourites.length) {
      _favourites[index] = !_favourites[index];
      notifyListeners();
    }
  }

  // Check if a group is a favourite
  bool isFavourite(int index) {
    if (index < _favourites.length) {
      return _favourites[index];
    }
    return false;
  }

  // Toggle the pin status of a group
  void togglePin(int index) {
    if (index < _pens.length) {
      _pens[index] = !_pens[index];
      notifyListeners();
    }
  }

  // Check if a group is pinned
  bool isPen(int index) {
    if (index < _pens.length) {
      return _pens[index];
    }
    return false;
  }

}
