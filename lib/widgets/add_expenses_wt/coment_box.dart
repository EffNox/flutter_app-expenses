import 'package:expenses/models/combined_model.dart';
import 'package:flutter/material.dart';

class CommentBoxWidget extends StatelessWidget {
  final CombinedModel cModel;

  const CommentBoxWidget({Key? key, required this.cModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = '';
    text = cModel.comment;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          const Icon(
            Icons.sticky_note_2_outlined,
            size: 35,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextFormField(
              initialValue: text,
              // maxLength: 10,
              cursorColor: Colors.green,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                counterText: '',
                hintText: 'Agregar comentario',
                hintStyle: const TextStyle(fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.green),
                ),
              ),
              onChanged: (value) {
                cModel.comment = value;
              },
            ),
          )
        ],
      ),
    );
  }
}
