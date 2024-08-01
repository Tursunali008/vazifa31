import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa31/bloc/file/bloc_file.dart';
import 'package:vazifa31/data/repostoriya/repostoriya_file.dart';
import 'package:vazifa31/ui/screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) {
        return FileRepository();
      },
      child: BlocProvider(
        create: (context) {
          return FileBloc(
            fileRepository: context.read<FileRepository>(),
          );
        },
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ),
      ),
    );
  }
}

class AppTextStyles {
  static const blueTextStyle = TextStyle(color: Colors.blue);
}