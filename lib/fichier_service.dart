
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class FichierService {
  FichierService._();

  static final FichierService instance = FichierService._();

  Future<Directory> _obtenirDossier() async {
    final Directory dossierApplication =
        await getApplicationDocumentsDirectory();

    final Directory dossierMedia = Directory(
      p.join(dossierApplication.path, 'signalements'),
    );

    if (!await dossierMedia.exists()) {
      await dossierMedia.create(recursive: true);
    }

    return dossierMedia;
  }

  Future<String> copierFichier({
    required String cheminSource,
    required String prefixe,
  }) async {
    final File source = File(cheminSource);

    if (!await source.exists()) {
      throw FileSystemException(
        'Le fichier source est introuvable.',
        cheminSource,
      );
    }

    final Directory dossier = await _obtenirDossier();

    final String extension = p.extension(cheminSource);
    final String nomFichier =
        '${prefixe}_${DateTime.now().microsecondsSinceEpoch}$extension';

    final String nouveauChemin = p.join(dossier.path, nomFichier);

    final File copie = await source.copy(nouveauChemin);

    return copie.path;
  }

  Future<void> supprimerFichier(String? chemin) async {
    if (chemin == null || chemin.isEmpty) return;

    try {
      final File fichier = File(chemin);

      if (await fichier.exists()) {
        await fichier.delete();
      }
    } catch (_) {
      // Une erreur de suppression ne doit pas bloquer l'application.
    }
  }
}
