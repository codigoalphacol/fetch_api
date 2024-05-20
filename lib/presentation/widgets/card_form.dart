import 'package:flutter/material.dart';

class CardFormText extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  const CardFormText(
      {super.key,
      required this.emailController,
      required this.nameController,
      required this.phoneController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 300,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 45, 47, 48),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextFormField(
            controller: emailController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextFormField(
            controller: phoneController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(labelText: 'Phone'),
          ),
        ],
      ),
    );
  }
}
