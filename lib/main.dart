
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
import 'database_service.dart';
import 'fichier_service.dart';

void main() {
  runApp(const QuartierAlerteApp());
}

class QuartierAlerteApp extends StatelessWidget {
  const QuartierAlerteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quartier Alerte',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF167D4A),
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F8F6),
      ),
      home: const AccueilPage(),
    );
  }
}

/// Page d'accueil de Quartier Alerte pour la commune de Hann Bel-Air.
/// Le bouton Commencer ouvre l'écran des catégories déjà existant.
class AccueilPage extends StatelessWidget {
  const AccueilPage({super.key});

  @override
  Widget build(BuildContext context) {
    const vert = Color(0xFF167D4A);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/hann_bel_air.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: const Color(0xFFE1F3E7),
              child: const Icon(
                Icons.location_city,
                size: 150,
                color: vert,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.25),
                  Colors.black.withValues(alpha: 0.78),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.location_city, color: Colors.white, size: 34),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'QUARTIER ALERTE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Text(
                    'HANN BEL-AIR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Ensemble, améliorons notre cadre de vie.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Signalez facilement les problèmes de votre quartier : '
                    'ordures, routes abîmées, éclairage défectueux et fuites d’eau.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    height: 58,
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CategoriesPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text(
                        'Commencer',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: vert,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategorieProbleme {
  final String titre;
  final String description;
  final String image;
  final IconData icone;
  final Color couleur;

  const CategorieProbleme({
    required this.titre,
    required this.description,
    required this.image,
    required this.icone,
    required this.couleur,
  });
}

const List<CategorieProbleme> categories = [
  CategorieProbleme(
    titre: 'Ordures',
    description: 'Déchets dans la rue',
    image: 'assets/images/ordures.jpg',
    icone: Icons.delete_outline,
    couleur: Color(0xFF23864B),
  ),
  CategorieProbleme(
    titre: 'Route abîmée',
    description: 'Nid-de-poule',
    image: 'assets/images/route.jpg',
    icone: Icons.car_crash_outlined,
    couleur: Color(0xFFD97706),
  ),
  CategorieProbleme(
    titre: 'Éclairage',
    description: 'Lampadaire cassé',
    image: 'assets/images/eclairage.jpg',
    icone: Icons.lightbulb_outline,
    couleur: Color(0xFF4766CC),
  ),
  CategorieProbleme(
    titre: "Fuite d'eau",
    description: 'Eau qui coule',
    image: 'assets/images/fuite_eau.jpg',
    icone: Icons.water_drop_outlined,
    couleur: Color(0xFF008CA8),
  ),
];

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  void ouvrirCategorie(
    BuildContext context,
    CategorieProbleme categorie,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SignalementPage(categorie: categorie),
      ),
    );
  }

  void afficherAide(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Comment utiliser l’application ?'),
        content: const Text(
          '1. Choisissez l’image correspondant au problème.\n\n'
          '2. Prenez une photo du problème.\n\n'
          '3. Ajoutez votre position et, si nécessaire, un message vocal.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF167D4A),
        foregroundColor: Colors.white,
        title: const Row(
          children: [
            Icon(Icons.location_city, size: 30),
            SizedBox(width: 10),
            Text(
              'Quartier Alerte',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Aide',
            onPressed: () => afficherAide(context),
            icon: const Icon(Icons.help_outline),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFE1F3E7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Un problème dans votre quartier ?',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF125B36),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Touchez une image pour le signaler.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'QUE VOULEZ-VOUS SIGNALER ?',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.78,
              ),
              itemBuilder: (context, index) {
                final categorie = categories[index];

                return InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () => ouvrirCategorie(context, categorie),
                  child: Card(
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.antiAlias,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Image.asset(
                            categorie.image,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: categorie.couleur.withAlpha(35),
                                child: Icon(
                                  categorie.icone,
                                  size: 70,
                                  color: categorie.couleur,
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 2),
                          child: Text(
                            categorie.titre,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(6, 0, 6, 10),
                          child: Text(
                            categorie.description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 56,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ListeSignalementsPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.map_outlined, size: 26),
                label: const Text(
                  'Voir les signalements',
                  style: TextStyle(fontSize: 17),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF167D4A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignalementPage extends StatefulWidget {
  final CategorieProbleme categorie;

  const SignalementPage({
    super.key,
    required this.categorie,
  });

  @override
  State<SignalementPage> createState() => _SignalementPageState();
}

class _SignalementPageState extends State<SignalementPage> {
  bool chargementGPS = false;
  Position? position;
  String? erreurGPS;

  final ImagePicker _imagePicker = ImagePicker();
  File? photoSignalement;
  bool chargementPhoto = false;

  final AudioRecorder _enregistreur = AudioRecorder();
  bool enregistrementEnCours = false;
  bool chargementAudio = false;
  String? cheminAudio;
  String? erreurAudio;
  DateTime? debutEnregistrement;
  Duration dureeAudio = Duration.zero;

  void afficherMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> prendrePhoto() async {
    if (chargementPhoto) return;

    setState(() {
      chargementPhoto = true;
    });

    try {
      final XFile? photo = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1600,
      );

      if (photo == null || !mounted) return;

      setState(() {
        photoSignalement = File(photo.path);
      });
      afficherMessage('Photo ajoutée au signalement.');
    } catch (e) {
      afficherMessage(
        'Impossible d’ouvrir la caméra. Vérifiez l’émulateur et réessayez.',
      );
    } finally {
      if (mounted) {
        setState(() {
          chargementPhoto = false;
        });
      }
    }
  }

  Future<void> ajouterPosition() async {
    if (chargementGPS) return;

    setState(() {
      chargementGPS = true;
      erreurGPS = null;
    });

    try {
      final bool serviceActive =
          await Geolocator.isLocationServiceEnabled();

      if (!serviceActive) {
        if (mounted) {
          setState(() {
            erreurGPS =
                'Activez la localisation dans les paramètres Android.';
          });
        }
        afficherMessage('La localisation du téléphone est désactivée.');
        return;
      }

      LocationPermission permission =
          await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        if (mounted) {
          setState(() {
            erreurGPS =
                'Autorisation refusée. Autorisez la localisation pour continuer.';
          });
        }
        afficherMessage('Autorisation GPS refusée.');
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          setState(() {
            erreurGPS =
                'Autorisation refusée définitivement. Modifiez-la dans les paramètres de l’application.';
          });
        }
        afficherMessage(
          'Ouvrez les paramètres Android pour autoriser la localisation.',
        );
        return;
      }

      final Position nouvellePosition =
          await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 25),
        ),
      );

      if (!mounted) return;

      setState(() {
        position = nouvellePosition;
        erreurGPS = null;
      });

      afficherMessage('Votre position GPS a été récupérée !');
    } catch (e) {
      if (mounted) {
        setState(() {
          erreurGPS =
              'Impossible de récupérer la position. Vérifiez le GPS et réessayez.';
        });
      }
      afficherMessage('Erreur GPS : vérifiez les paramètres du téléphone.');
    } finally {
      if (mounted) {
        setState(() {
          chargementGPS = false;
        });
      }
    }
  }

  Future<void> demarrerEnregistrement() async {
    if (chargementAudio || enregistrementEnCours) return;

    setState(() {
      chargementAudio = true;
      erreurAudio = null;
    });

    try {
      final bool autorise = await _enregistreur.hasPermission();

      if (!autorise) {
        if (mounted) {
          setState(() {
            erreurAudio =
                'Autorisez le microphone dans les paramètres Android.';
          });
        }
        afficherMessage('Accès au microphone refusé.');
        return;
      }

      final String dossier = Directory.systemTemp.path;
      final String chemin =
          '$dossier/message_quartier_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await _enregistreur.start(
        const RecordConfig(
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          sampleRate: 44100,
        ),
        path: chemin,
      );

      if (!mounted) return;

      setState(() {
        enregistrementEnCours = true;
        debutEnregistrement = DateTime.now();
        dureeAudio = Duration.zero;
        cheminAudio = null;
      });

      afficherMessage('Enregistrement vocal démarré.');
    } catch (e) {
      if (mounted) {
        setState(() {
          erreurAudio =
              'Impossible de démarrer le microphone. Vérifiez les permissions.';
        });
      }
      afficherMessage('Erreur lors du démarrage de l’enregistrement.');
    } finally {
      if (mounted) {
        setState(() {
          chargementAudio = false;
        });
      }
    }
  }

  Future<void> arreterEnregistrement() async {
    if (!enregistrementEnCours) return;

    try {
      final String? chemin = await _enregistreur.stop();

      if (!mounted) return;

      setState(() {
        enregistrementEnCours = false;
        debutEnregistrement = null;
        cheminAudio = chemin;
      });

      if (chemin != null) {
        final File fichier = File(chemin);
        if (await fichier.exists()) {
          final int taille = await fichier.length();
          if (taille == 0) {
            setState(() {
              erreurAudio = 'Le fichier vocal est vide. Réessayez.';
              cheminAudio = null;
            });
            afficherMessage('Aucun son enregistré. Réessayez.');
            return;
          }
        }

        afficherMessage('Message vocal enregistré.');
      } else {
        afficherMessage('Aucun fichier vocal n’a été créé.');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          enregistrementEnCours = false;
          erreurAudio = 'Impossible de terminer l’enregistrement.';
        });
      }
      afficherMessage('Erreur lors de l’arrêt de l’enregistrement.');
    }
  }

  Future<void> envoyerSignalement() async {
    if (photoSignalement == null) {
      afficherMessage('Prenez une photo du problème avant l’envoi.');
      return;
    }
    if (position == null) {
      afficherMessage('Ajoutez votre position GPS avant l’envoi.');
      return;
    }
    if (enregistrementEnCours) {
      afficherMessage('Arrêtez l’enregistrement vocal avant l’envoi.');
      return;
    }

    try {
      // Copier les médias dans le dossier permanent de l’application.
      final String id = DateTime.now().microsecondsSinceEpoch.toString();
      String? photoPath;
      String? audioPath;

      if (photoSignalement != null && await photoSignalement!.exists()) {
        photoPath = await FichierService.instance.copierFichier(
          cheminSource: photoSignalement!.path,
          prefixe: 'photo_$id',
        );
      }

      if (cheminAudio != null && await File(cheminAudio!).exists()) {
        audioPath = await FichierService.instance.copierFichier(
          cheminSource: cheminAudio!,
          prefixe: 'audio_$id',
        );
      }

      await DatabaseService.instance.ajouterSignalement({
        'id': id,
        'categorie': widget.categorie.titre,
        'description': widget.categorie.description,
        'photoPath': photoPath,
        'latitude': position!.latitude,
        'longitude': position!.longitude,
        'audioPath': audioPath,
        'dateCreation': DateTime.now().toIso8601String(),
        'statut': 'En attente',
      });

      if (!mounted) return;
      afficherMessage('Signalement enregistré durablement !');
      Navigator.of(context).pop();
    } catch (e) {
      afficherMessage('Erreur lors de la sauvegarde. Réessayez.');
    }
  }

  String formaterDuree(Duration duree) {
    final String minutes =
        duree.inMinutes.remainder(60).toString().padLeft(2, '0');
    final String secondes =
        duree.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$secondes';
  }

  @override
  void dispose() {
    _enregistreur.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouveau signalement'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: photoSignalement != null
                    ? Image.file(
                        photoSignalement!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        widget.categorie.image,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            color: widget.categorie.couleur.withAlpha(35),
                            child: Icon(
                              widget.categorie.icone,
                              size: 90,
                              color: widget.categorie.couleur,
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.categorie.titre,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                height: 62,
                child: FilledButton.icon(
                  onPressed: chargementPhoto ? null : prendrePhoto,
                  icon: chargementPhoto
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.camera_alt, size: 28),
                  label: Text(
                    chargementPhoto
                        ? 'Ouverture de la caméra...'
                        : photoSignalement == null
                            ? 'Prendre une photo'
                            : 'Reprendre une photo',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              SizedBox(
                height: 62,
                child: OutlinedButton.icon(
                  onPressed: chargementGPS ? null : ajouterPosition,
                  icon: chargementGPS
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.my_location, size: 28),
                  label: Text(
                    chargementGPS
                        ? 'Recherche de la position...'
                        : 'Ajouter ma position',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),

              if (position != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE1F3E7),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xFF167D4A),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Color(0xFF167D4A),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Position GPS récupérée',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Latitude : ${position!.latitude.toStringAsFixed(6)}',
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Longitude : ${position!.longitude.toStringAsFixed(6)}',
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Précision : ${position!.accuracy.toStringAsFixed(1)} mètres',
                      ),
                    ],
                  ),
                ),
              ],

              if (erreurGPS != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    erreurGPS!,
                    style: TextStyle(
                      color: Colors.orange.shade900,
                    ),
                  ),
                ),
                if (erreurGPS!.contains('paramètres de l’application'))
                  TextButton.icon(
                    onPressed: () => Geolocator.openAppSettings(),
                    icon: const Icon(Icons.settings),
                    label: const Text('Ouvrir les paramètres'),
                  ),
                if (erreurGPS!.contains('paramètres Android'))
                  TextButton.icon(
                    onPressed: () => Geolocator.openLocationSettings(),
                    icon: const Icon(Icons.settings),
                    label: const Text('Activer la localisation'),
                  ),
              ],

              const SizedBox(height: 14),

              SizedBox(
                height: 62,
                child: OutlinedButton.icon(
                  onPressed: chargementAudio
                      ? null
                      : enregistrementEnCours
                          ? arreterEnregistrement
                          : demarrerEnregistrement,
                  icon: chargementAudio
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : Icon(
                          enregistrementEnCours ? Icons.stop : Icons.mic,
                          size: 28,
                        ),
                  label: Text(
                    chargementAudio
                        ? 'Veuillez patienter...'
                        : enregistrementEnCours
                            ? 'Arrêter l’enregistrement'
                            : cheminAudio == null
                                ? 'Enregistrer un message vocal'
                                : 'Réenregistrer le message vocal',
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
              ),

              if (enregistrementEnCours) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.fiber_manual_record,
                          color: Colors.red.shade700),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Enregistrement en cours. Appuyez sur Arrêter quand vous avez terminé.',
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              if (cheminAudio != null && !enregistrementEnCours) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE1F3E7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.audio_file,
                        color: Color(0xFF167D4A),
                        size: 30,
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Message vocal enregistré sur cet appareil.',
                        ),
                      ),
                      IconButton(
                        tooltip: 'Supprimer le message vocal',
                        onPressed: () async {
                          final String ancienChemin = cheminAudio!;
                          setState(() {
                            cheminAudio = null;
                          });
                          try {
                            final File fichier = File(ancienChemin);
                            if (await fichier.exists()) {
                              await fichier.delete();
                            }
                          } catch (_) {
                            // Le message est retiré de l'écran.
                          }
                        },
                        icon: const Icon(Icons.delete_outline),
                      ),
                    ],
                  ),
                ),
              ],

              if (erreurAudio != null) ...[
                const SizedBox(height: 12),
                Text(
                  erreurAudio!,
                  style: TextStyle(color: Colors.red.shade800),
                ),
              ],

              const SizedBox(height: 22),
              SizedBox(
                height: 58,
                child: FilledButton.icon(
                  onPressed: envoyerSignalement,
                  icon: const Icon(Icons.send),
                  label: const Text(
                    'Envoyer le signalement',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF167D4A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Ajoutez une photo et votre position GPS. Le message vocal est facultatif. Les données et les médias sont sauvegardés sur cet appareil.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListeSignalementsPage extends StatefulWidget {
  const ListeSignalementsPage({super.key});

  @override
  State<ListeSignalementsPage> createState() => _ListeSignalementsPageState();
}

class _ListeSignalementsPageState extends State<ListeSignalementsPage> {
  late Future<List<Map<String, dynamic>>> _chargement;

  @override
  void initState() {
    super.initState();
    _chargement = DatabaseService.instance.obtenirSignalements();
  }

  Future<void> _actualiser() async {
    setState(() {
      _chargement = DatabaseService.instance.obtenirSignalements();
    });
    await _chargement;
  }

  Future<void> _confirmerSuppression(Map<String, dynamic> item) async {
    final String categorie = item['categorie'] as String? ?? 'ce signalement';
    final bool? confirmer = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Supprimer le signalement ?'),
        content: Text(
          'Voulez-vous vraiment supprimer le signalement « $categorie » ? '
          'Cette action est irréversible.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );

    if (confirmer != true || !mounted) return;

    final String id = item['id']?.toString() ?? '';
    if (id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Impossible de trouver l’identifiant du signalement.')),
      );
      return;
    }

    try {
      await DatabaseService.instance.supprimerSignalement(id);

      final String? photoPath = item['photoPath'] as String?;
      final String? audioPath = item['audioPath'] as String?;
      await FichierService.instance.supprimerFichier(photoPath);
      await FichierService.instance.supprimerFichier(audioPath);

      if (!mounted) return;
      await _actualiser();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signalement supprimé.')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('La suppression a échoué. Réessayez.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signalements du quartier'),
        actions: [
          IconButton(
            tooltip: 'Actualiser',
            onPressed: _actualiser,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _chargement,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Impossible de charger les signalements. Vérifiez la base de données puis réessayez.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final List<Map<String, dynamic>> signalements =
              snapshot.data ?? [];

          if (signalements.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.map_outlined,
                      size: 90,
                      color: Color(0xFF167D4A),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Aucun signalement pour le moment.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Les signalements sauvegardés apparaîtront ici.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _actualiser,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: signalements.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic> item = signalements[index];
                final String? photoPath = item['photoPath'] as String?;
                final String? audioPath = item['audioPath'] as String?;
                final DateTime date =
                    DateTime.tryParse(item['dateCreation'] as String? ?? '') ??
                    DateTime.now();

                return Card(
                  margin: const EdgeInsets.only(bottom: 14),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (photoPath != null && File(photoPath).existsSync())
                        Image.file(
                          File(photoPath),
                          height: 170,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const SizedBox(
                            height: 90,
                            child: Icon(Icons.broken_image_outlined, size: 40),
                          ),
                        )
                      else
                        Container(
                          height: 110,
                          color: const Color(0xFFE1F3E7),
                          child: const Icon(
                            Icons.image_not_supported_outlined,
                            size: 42,
                            color: Color(0xFF167D4A),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['categorie'] as String? ?? 'Sans catégorie',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if ((item['description'] as String? ?? '').isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(item['description'] as String),
                            ],
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.schedule, size: 18),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    '${date.day.toString().padLeft(2, '0')}/'
                                    '${date.month.toString().padLeft(2, '0')}/'
                                    '${date.year} à '
                                    '${date.hour.toString().padLeft(2, '0')}:'
                                    '${date.minute.toString().padLeft(2, '0')}',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Latitude : ${(item['latitude'] as num?)?.toStringAsFixed(6) ?? 'indisponible'}',
                            ),
                            Text(
                              'Longitude : ${(item['longitude'] as num?)?.toStringAsFixed(6) ?? 'indisponible'}',
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Chip(
                                avatar: const Icon(Icons.hourglass_top, size: 18),
                                label: Text(item['statut'] as String? ?? 'En attente'),
                                backgroundColor: const Color(0xFFFFF0C2),
                              ),
                            ),
                            if (audioPath != null && File(audioPath).existsSync())
                              const Row(
                                children: [
                                  Icon(Icons.audio_file,
                                      color: Color(0xFF167D4A)),
                                  SizedBox(width: 8),
                                  Text('Message vocal joint'),
                                ],
                              ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerRight,
                              child: OutlinedButton.icon(
                                onPressed: () => _confirmerSuppression(item),
                                icon: const Icon(Icons.delete_outline, color: Colors.red),
                                label: const Text(
                                  'Supprimer',
                                  style: TextStyle(color: Colors.red),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
