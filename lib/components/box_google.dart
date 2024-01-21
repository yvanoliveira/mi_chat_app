import 'package:flutter/material.dart';

// Widget que representa uma caixa com a imagem do Google
class BoxGoogle extends StatelessWidget {
  final String imagePath;  // Caminho para imagem do Google
  final Function()? onTap;  // Função chamada quando a caixa é tocada

  // Construtor da classe
  const BoxGoogle({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(14),
          color: Colors.grey[200],
        ),
        child: Image.asset(
          imagePath,
          height: 40,
        ),
      ),
    );
  }
}
