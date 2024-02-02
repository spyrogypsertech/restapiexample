import 'package:flutter/material.dart';
import 'package:uidemo/model/university.dart';

class UniversityCard extends StatelessWidget {
  final University university;
  final TextStyle _textStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold);

  UniversityCard({Key? key, required this.university}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        elevation: 0.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRow('Domain', university.domain),
              _buildRow('Alpha code', university.alphaCode),
              _buildRow('State Province', university.stateProvince),
              _buildRow('name', university.name),
              _buildRow(
                'Web Page',
                university.webPages.isNotEmpty ? university.webPages : 'N/A',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              '$label',
              style: _textStyle,
            ),
          ),
          Text(
            ':',
            style: _textStyle.copyWith(fontSize: 16.0),
          ),
          SizedBox(width: 4.0),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: _textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
