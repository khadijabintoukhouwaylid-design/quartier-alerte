
import 'signalement.dart';

class SignalementService {
  SignalementService._();

  static final SignalementService instance = SignalementService._();

  final List<Signalement> _signalements = [];

  List<Signalement> get signalements =>
      List.unmodifiable(_signalements);

  void ajouter(Signalement signalement) {
    _signalements.insert(0, signalement);
  }
}
