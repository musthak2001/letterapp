import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

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
    'Leave Email'
  ];

  final List<String> tones = [
    'Professional',
    'Friendly',
    'Polite',
    'Strict'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generate Email"),
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
                value: emailType,
                hint: const Text("Select Email Type"),
                items: emailTypes
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
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
                value: tone,
                hint: const Text("Select Tone"),
                items: tones
                    .map((t) => DropdownMenuItem(
                          value: t,
                          child: Text(t),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => tone = val),
                validator: (value) => value == null ? "Please select tone" : null,
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Send data to OpenAI API
                      String prompt = """
Email Type: $emailType
Recipient: ${recipientController.text}
Subject: ${subjectController.text}
Key Points: ${keyPointsController.text}
Tone: $tone
Language: ${languageController.text}
""";
                      // For now, just show prompt in a dialog
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Generated Prompt"),
                          content: Text(prompt),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
                            )
                          ],
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    "Generate Email",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
