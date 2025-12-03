import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const LegalDraftApp());
}

class LegalDraftApp extends StatelessWidget {
  const LegalDraftApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LegalDraft',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB), // Tailwind Blue-600
          primary: const Color(0xFF2563EB),
          secondary: const Color(0xFF0F172A), // Tailwind Slate-900
          surface: Colors.white,
          background: const Color(0xFFF8FAFC), // Tailwind Slate-50
        ),
        useMaterial3: true,
        fontFamily: 'Roboto', // Standard web font
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF2563EB), width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2563EB),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingScreen(),
        '/questionnaire': (context) => const QuestionnaireScreen(),
      },
    );
  }
}

// --- Data Model ---

class LegalData {
  String companyName;
  String websiteUrl;
  String contactEmail;
  String websiteType; // e.g., E-commerce, Blog, SaaS
  bool collectsEmails;
  bool collectsPayments;
  bool collectsCookies;

  LegalData({
    this.companyName = '',
    this.websiteUrl = '',
    this.contactEmail = '',
    this.websiteType = 'E-commerce',
    this.collectsEmails = false,
    this.collectsPayments = false,
    this.collectsCookies = false,
  });
}

// --- Screens ---

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.gavel, color: Color(0xFF2563EB)),
            SizedBox(width: 8),
            Text('LegalDraft', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.description_outlined, size: 80, color: Color(0xFF2563EB)),
              const SizedBox(height: 24),
              Text(
                'Générez vos documents juridiques en quelques minutes',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0F172A),
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                'Conditions Générales de Vente, Politique de Confidentialité et plus encore.\nProtégez votre entreprise en ligne dès aujourd\'hui.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF64748B),
                    ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/questionnaire');
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Commencer le questionnaire'),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _FeatureItem(icon: Icons.check_circle, text: 'Conforme RGPD'),
                  SizedBox(width: 16),
                  _FeatureItem(icon: Icons.check_circle, text: 'Rapide & Simple'),
                  SizedBox(width: 16),
                  _FeatureItem(icon: Icons.check_circle, text: 'Professionnel'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.green),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
      ],
    );
  }
}

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final _formKey = GlobalKey<FormState>();
  final LegalData _data = LegalData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Configuration'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  'Parlez-nous de votre entreprise',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F172A),
                      ),
                ),
                const SizedBox(height: 24),
                
                // Company Name
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nom de l\'entreprise / Site Web',
                    hintText: 'Ex: Ma Boutique En Ligne',
                    prefixIcon: Icon(Icons.business),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un nom';
                    }
                    return null;
                  },
                  onSaved: (value) => _data.companyName = value!,
                ),
                const SizedBox(height: 16),

                // Website URL
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'URL du site web',
                    hintText: 'https://www.example.com',
                    prefixIcon: Icon(Icons.link),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer une URL';
                    }
                    return null;
                  },
                  onSaved: (value) => _data.websiteUrl = value!,
                ),
                const SizedBox(height: 16),

                // Email
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email de contact',
                    hintText: 'contact@example.com',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un email';
                    }
                    return null;
                  },
                  onSaved: (value) => _data.contactEmail = value!,
                ),
                const SizedBox(height: 24),

                Text(
                  'Type d\'activité',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _data.websiteType,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.category),
                  ),
                  items: ['E-commerce', 'Blog', 'SaaS', 'Portfolio', 'Autre']
                      .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _data.websiteType = value!;
                    });
                  },
                ),
                const SizedBox(height: 24),

                Text(
                  'Données collectées',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    children: [
                      CheckboxListTile(
                        title: const Text('Adresses Email (Newsletter, Compte)'),
                        value: _data.collectsEmails,
                        onChanged: (val) => setState(() => _data.collectsEmails = val!),
                      ),
                      const Divider(height: 1),
                      CheckboxListTile(
                        title: const Text('Informations de Paiement'),
                        value: _data.collectsPayments,
                        onChanged: (val) => setState(() => _data.collectsPayments = val!),
                      ),
                      const Divider(height: 1),
                      CheckboxListTile(
                        title: const Text('Cookies & Traceurs'),
                        value: _data.collectsCookies,
                        onChanged: (val) => setState(() => _data.collectsCookies = val!),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(data: _data),
                        ),
                      );
                    }
                  },
                  child: const Text('Générer les documents'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final LegalData data;

  const ResultScreen({super.key, required this.data});

  Future<void> _launchPayment() async {
    // URL de base fournie
    const String baseUrl = 'https://api.maishapay.online/payment/create';
    
    // Simulation des paramètres de transaction
    // Note: Dans une vraie intégration, cela se ferait probablement via une requête POST backend
    // ou via un SDK. Ici, nous simulons l'envoi via des paramètres GET pour la démo
    // ou nous redirigeons simplement vers l'URL comme demandé.
    
    final Uri url = Uri.parse(baseUrl).replace(queryParameters: {
      'amount': '39',
      'currency': 'USD',
      'description': 'LegalDraft Download',
      'customer_email': data.contactEmail,
      // Ajout d'un timestamp pour simuler une transaction unique
      'ref': DateTime.now().millisecondsSinceEpoch.toString(), 
    });

    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Erreur lors de la redirection: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final String privacyPolicy = _generatePrivacyPolicy(data);
    final String termsOfService = _generateTerms(data);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Vos Documents'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DocumentPreview(title: 'Politique de Confidentialité', content: privacyPolicy),
                  const SizedBox(height: 24),
                  _DocumentPreview(title: 'Conditions Générales de Vente', content: termsOfService),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: null, // LOCKED
                        icon: const Icon(Icons.lock, size: 18),
                        label: const Text('Télécharger (PDF)'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          foregroundColor: Colors.grey,
                          side: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: null, // LOCKED
                        icon: const Icon(Icons.lock, size: 18),
                        label: const Text('Télécharger (DOCX)'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          foregroundColor: Colors.grey,
                          side: const BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _launchPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF16A34A), // Green for payment
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          'Déverrouiller le téléchargement',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Paiement unique de 39 \$ USD',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_outline, size: 12, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      'Paiement sécurisé via Maishapay',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _generatePrivacyPolicy(LegalData data) {
    return '''
POLITIQUE DE CONFIDENTIALITÉ

Dernière mise à jour : ${DateTime.now().toString().split(' ')[0]}

1. INTRODUCTION
Bienvenue sur ${data.companyName}. Nous respectons votre vie privée et nous engageons à protéger vos données personnelles.

2. DONNÉES COLLECTÉES
Nous collectons les informations suivantes :
${data.collectsEmails ? '- Adresses email et informations de contact' : ''}
${data.collectsPayments ? '- Informations de facturation et de paiement' : ''}
${data.collectsCookies ? '- Données de navigation et cookies' : ''}

3. UTILISATION DES DONNÉES
Vos données sont utilisées pour fournir nos services sur ${data.websiteUrl}, traiter vos commandes et améliorer votre expérience utilisateur.

4. CONTACT
Pour toute question, contactez-nous à : ${data.contactEmail}
    ''';
  }

  String _generateTerms(LegalData data) {
    return '''
CONDITIONS GÉNÉRALES DE VENTE ET D'UTILISATION

1. OBJET
Les présentes conditions régissent les ventes par ${data.companyName} sur le site ${data.websiteUrl}.

2. PRIX
Les prix de nos produits sont indiqués en devise locale, toutes taxes comprises.

3. COMMANDES
Vous pouvez passer commande sur notre site ${data.websiteType == 'E-commerce' ? 'via notre boutique en ligne' : 'en nous contactant directement'}.

4. RESPONSABILITÉ
${data.companyName} ne saurait être tenu pour responsable des dommages résultant d'une mauvaise utilisation du produit acheté.
    ''';
  }
}

class _DocumentPreview extends StatelessWidget {
  final String title;
  final String content;

  const _DocumentPreview({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF1E293B),
              ),
            ),
            const Divider(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: const Color(0xFFF8FAFC),
              child: Text(
                content,
                style: const TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 12,
                  color: Color(0xFF334155),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0),
                    Colors.white,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
