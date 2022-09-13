import 'package:gameadmin/com/localStorage.dart';
import 'package:gameadmin/cubit/scoreboardTO_cubit.dart';

void backup(ScoreboardTOState saveState) async {
  List<ScoreboardTOState> saveStates = await readData();
  for (var ss in saveStates) {
    if (ss.gameData.id == saveState.gameData.id) {
      saveStates.remove(ss);
      break;
    }
  }
  saveStates.add(saveState);
  writeData(saveStates);
}

Future<ScoreboardTOState> recall(String id) async {
  List<ScoreboardTOState> saveStates = await readData();
  ScoreboardTOState saveState = ScoreboardTOInitial();
  for (var ss in saveStates) {
    if (ss.gameData.id == id) {
      saveState = ss;
      break;
    }
  }
  return saveState;
}
