import 'package:flutter/material.dart';

// Um botão personalizado reutilizável
class MyButton extends StatelessWidget {
  final void Function()? onTap; // Função chamada quando o botão é pressionado
  final String text; // Texto exibido no botão

  // Construtor da classe
  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  // Método responsável por construir a interface do botão
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
