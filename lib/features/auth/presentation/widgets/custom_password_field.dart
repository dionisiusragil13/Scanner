import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  const CustomPasswordField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  // Variabel untuk mengontrol apakah teks disembunyikan
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(color: Colors.black, fontSize: 14),
        ),
        TextField(
          controller: widget.controller,
          obscureText: _obscureText, // Mengikuti state variabel
          style: const TextStyle(
            color: Color(0xff191970), 
            fontWeight: FontWeight.bold
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(color: Colors.grey),
            // Tombol Mata
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                // Mengubah state saat ikon diklik
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff191970)),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}