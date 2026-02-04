import 'package:flutter/material.dart';
import 'package:letterapp/api/apis.dart';

import 'package:letterapp/auth/auth_service.dart';
import 'package:letterapp/screens/splash_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService authService = AuthService();

  void logout() async {
    await authService.signOut();

    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  final _formKey = GlobalKey<FormState>();
  String generatedEmail = '';

  // Controllers
  final TextEditingController recipientController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController keyPointsController = TextEditingController();
  final TextEditingController languageController = TextEditingController();

  // Dropdown values
  String? emailType;
  String? tone;

  // Dropdown options
  final List<String> emailTypes = [
    'Formal',
    'Informal',
    'Complaint',
    'Request',
    'Leave Email',
  ];

  final List<String> tones = ['Professional', 'Friendly', 'Polite', 'Strict'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "Generate Email",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: logout,
            tooltip: 'Logout',
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Email Type Dropdown
              const Text(
                "Email Type *",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              DropdownButtonFormField<String>(
                initialValue: emailType,
                hint: const Text("Select Email Type"),
                items: emailTypes
                    .map(
                      (type) =>
                          DropdownMenuItem(value: type, child: Text(type)),
                    )
                    .toList(),
                onChanged: (val) => setState(() => emailType = val),
                validator: (value) =>
                    value == null ? "Please select email type" : null,
              ),
              const SizedBox(height: 20),

              // Recipient Name
              const Text(
                "Recipient Name *",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: recipientController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter recipient name",
                ),
                validator: (value) =>
                    value!.isEmpty ? "Recipient name required" : null,
              ),
              const SizedBox(height: 20),

              // Subject
              const Text(
                "Subject (Optional)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: subjectController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter email subject",
                ),
              ),
              const SizedBox(height: 20),

              // Key Points / Message
              const Text(
                "Key Points / Message *",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: keyPointsController,
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter the main points you want in the email",
                ),
                validator: (value) =>
                    value!.isEmpty ? "Key points required" : null,
              ),
              const SizedBox(height: 20),

              // Tone Dropdown
              const Text(
                "Tone *",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              DropdownButtonFormField<String>(
                initialValue: tone,
                hint: const Text("Select Tone"),
                items: tones
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (val) => setState(() => tone = val),
                validator: (value) =>
                    value == null ? "Please select tone" : null,
              ),
              const SizedBox(height: 20),

              // Language (Optional)
              const Text(
                "Language (Optional)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: languageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "e.g. English, Spanish",
                ),
              ),
              const SizedBox(height: 30),

              // Generate Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Combine input into prompt
                      String prompt =
                          """
Email Type: $emailType
Recipient: ${recipientController.text}
Subject: ${subjectController.text}
Key Points: ${keyPointsController.text}
Tone: $tone
Language: ${languageController.text}
""";

                      // Show loading
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => const Center(
                          child: CircularProgressIndicator(
                            color: Colors.deepPurple,
                          ),
                        ),
                      );

                      // Call API
                      String generatedEmail = await APIs.getAnswer(prompt);

                      // Close loading
                      Navigator.pop(context);

                      // Navigate to output screen
                      Navigator.pushNamed(
                        context,
                        '/output_screen',
                        arguments: generatedEmail,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                  ),
                  child: const Text(
                    "Generate Email",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
