import 'package:escola_interativa/app/core/core.dart';
import 'package:flutter/material.dart';

class CardPublishWidget extends StatelessWidget {
  final String disciplina;
  final String semestre;
  final String instituicao;
  CardPublishWidget(
      {required this.disciplina,
      required this.semestre,
      required this.instituicao});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 100.0,
          width: 77.0,
          padding: EdgeInsets.all(10.0),
          child: Image.asset(
            AppImages.imgPdf,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 200.0,
              child: Text(
                disciplina,
                style: AppTextStyles.titleCard,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 120.0,
              child: Text(
                "$semestreº Semestre",
                style: AppTextStyles.textCard,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              width: 200.0,
              child: Text(
                "Instituição: $instituicao",
                style: AppTextStyles.textCard,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
