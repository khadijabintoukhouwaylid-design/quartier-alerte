
import 'package:flutter/material.dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({super.key});

  @override
  Widget build(BuildContext context) {
    const vert = Color(0xFF167D4A);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Photo de Hann Bel-Air
          Image.asset(
            'assets/images/hann_bel_air.jpg',
            fit: BoxFit.cover,
          ),

          // Voile sombre pour rendre le texte lisible
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withAlpha(100),
                  Colors.transparent,
                  Colors.black.withAlpha(180),
                ],
                stops: const [0.0, 0.40, 1.0],
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 35),

                  const Icon(
                    Icons.location_city,
                    size: 55,
                    color: Colors.white,
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Quartier Alerte',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Spacer(),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(225),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          'BIENVENUE À',
                          style: TextStyle(
                            color: vert,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'HANN BEL AIR',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF125B36),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Ensemble, améliorons notre quartier.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF26352D),
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const AccueilSignalementsPage(),
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

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Écran temporaire : à relier à l'écran des catégories existant.
class AccueilSignalementsPage extends StatelessWidget {
  const AccueilSignalementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quartier Alerte'),
      ),
      body: const Center(
        child: Text(
          'Écran des catégories à relier.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
