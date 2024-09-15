import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solitaire/backend/models/board.dart';

//TODO : avoid prints
class BoardProvider extends ChangeNotifier {
  Board? board;
  int counterMoves = 0;
  Timer? timer;
  int elapsedSeconds = 0;

  void loadGame() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedBoard = prefs.getString('gameState');
    if (savedBoard != null) {
      board = Board.fromJson(jsonDecode(savedBoard));
      counterMoves = board?.moves ?? 0;
      elapsedSeconds = jsonDecode(savedBoard)['time'] ?? 0;
    }
    notifyListeners();
  }

  Future<void> saveGame(Board boardToSave) async {
    boardToSave.moves = counterMoves;
    final prefs = await SharedPreferences.getInstance();
    await clearSavedGame();
    Map<String, dynamic> jsonBoard = boardToSave.toJson(elapsedSeconds);
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

  void increaseCounterMoves() {
    counterMoves++;
    notifyListeners();
  }

  void reinitializeInfos() {
    counterMoves = 0;
    elapsedSeconds = 0;
    notifyListeners();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      elapsedSeconds++;
      notifyListeners();
    });
  }

  void stopTimer() {
    timer?.cancel();
  }
}
