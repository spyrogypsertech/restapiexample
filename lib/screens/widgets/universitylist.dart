import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uidemo/controller/universityprovider.dart';
import 'package:uidemo/screens/widgets/universitycard.dart';

class UniversityList extends StatefulWidget {
  const UniversityList({Key? key}) : super(key: key);

  @override
  _UniversityListState createState() => _UniversityListState();
}

class _UniversityListState extends State<UniversityList> {
  late Future<void> universitiesFuture;

  @override
  void initState() {
    super.initState();
    universitiesFuture = Provider.of<UniversityProvider>(context, listen: false)
        .fetchUniversities();
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Are you sure you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: GestureDetector(
            onTap: () async {
              final shouldPop = await _onBackPressed();
              if (shouldPop) {
                // ignore: use_build_context_synchronously
                SystemNavigator.pop();
              }
            },
            child: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text('universities'),
        ),
        body: FutureBuilder(
          future: universitiesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading universities'));
            } else {
              return UniversityListView();
            }
          },
        ),
      ),
    );
  }
}

class UniversityListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final universityProvider = Provider.of<UniversityProvider>(context);

    if (universityProvider.universities.isEmpty) {
      return const Center(child: Text('No universities found.'));
    }

    return ListView.builder(
      itemCount: universityProvider.universities.length,
      itemBuilder: (context, index) {
        final university = universityProvider.universities[index];
        return UniversityCard(university: university);
      },
    );
  }
}
