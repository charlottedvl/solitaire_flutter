import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solitaire/backend/models/board.dart';

//TODO : avoid prints
class BoardProvider extends ChangeNotifier {
  Board? board;

  void loadGame() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedBoard = prefs.getString('gameState');
    if (savedBoard != null) {
      board = Board.fromJson(jsonDecode(savedBoard));
    }
    notifyListeners();
  }

  Future<void> saveGame(Board boardToSave) async {
    final prefs = await SharedPreferences.getInstance();
    await clearSavedGame();
    Map<String, dynamic> jsonBoard = boardToSave.toJson();
    await prefs.setString('gameState', jsonEncode(jsonBoard));
    board = boardToSave;
    notifyListeners();
  }

  Future<void> clearSavedGame() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    board = null;
    notifyListeners();
  }
}
