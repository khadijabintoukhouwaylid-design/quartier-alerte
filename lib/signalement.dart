
import 'dart:io';

class Signalement {
  final String id;
  final String categorie;
  final String description;
  final File? photo;
  final double? latitude;
  final double? longitude;
  final String? cheminAudio;
  final DateTime dateCreation;
  final String statut;

  Signalement({
    required this.id,
    required this.categorie,
    this.description = '',
    this.photo,
    this.latitude,
    this.longitude,
    this.cheminAudio,
    DateTime? dateCreation,
    this.statut = 'En attente',
  }) : dateCreation = dateCreation ?? DateTime.now();
}
