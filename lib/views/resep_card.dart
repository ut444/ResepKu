import 'package:flutter/material.dart';
import '../model/resep.dart';
import '../views/resep_detail.dart';

class ResepCard extends StatelessWidget {
  final Resep resep;

  const ResepCard({required this.resep});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailResep(resep: resep),
            ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        width: MediaQuery.of(context).size.width,
        height: 250,
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  offset: Offset(0.0, 0.10),
                  blurRadius: 10.0,
                  spreadRadius: -6.0),
            ],
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.35), BlendMode.multiply),
                image: NetworkImage("${resep.images}"),
                fit: BoxFit.cover)),
        child: Stack(
          children: [
            Align(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  "${resep.name}",
                  style: TextStyle(fontSize: 19),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              alignment: Alignment.center,
            ),
            Align(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 18),
                        SizedBox(width: 7),
                        Text("${resep.rating}")
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        Icon(Icons.schedule, color: Colors.yellow, size: 18),
                        SizedBox(width: 7),
                        Text("${resep.totalTime}")
                      ],
                    ),
                  ),
                ],
              ),
              alignment: Alignment.bottomLeft,
            )
          ],
        ),
      ),
    );
  }
}
