import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solitaire/backend/board.dart';

//TODO : avoid prints
class BoardProvider extends ChangeNotifier {
  Board? board;

  void loadGame() async {
    print("Loading");
    final prefs = await SharedPreferences.getInstance();
    String? savedBoard = prefs.getString('gameState');
    if (savedBoard != null) {
      board = Board.fromJson(jsonDecode(savedBoard));
      print("Board found");
    }
    print("Loaded");
    notifyListeners();
  }

  Future<void> saveGame(Board boardToSave) async {
    final prefs = await SharedPreferences.getInstance();
    await clearSavedGame();
    print("Saving");
    Map<String, dynamic> jsonBoard = boardToSave.toJson();
    await prefs.setString('gameState', jsonEncode(jsonBoard));
    board = boardToSave;
    print("saved");
    notifyListeners();
  }

  Future<void> clearSavedGame() async {
    print("Clearing");
    final prefs = await SharedPreferences.getInstance();
    bool success = await prefs.clear();
    if (success) {
      print('Board cleared');
    } else {
      print('Failed to clear board');
    }
    board = null;
    notifyListeners();
  }
}
