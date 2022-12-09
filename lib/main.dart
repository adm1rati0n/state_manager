import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_manager/cubit/click/click_cubit.dart';
import 'package:state_manager/cubit/theme_change/theme_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp

  ({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ClickCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Практическая работа №4',
            themeMode: context
                .read<ThemeCubit>()
                .themeMode,
            theme: ThemeData(
              colorScheme: const ColorScheme(
                  brightness: Brightness.light,
                  primary: Colors.lightBlueAccent,
                  onPrimary: Colors.white,
                  secondary: Colors.lightBlueAccent,
                  onSecondary: Colors.white,
                  error: Colors.red,
                  onError: Colors.white,
                  background: Colors.white,
                  onBackground: Colors.black,
                  surface: Colors.white54,
                  onSurface: Colors.black),
            ),
            darkTheme: ThemeData(
              colorScheme: const ColorScheme(
                  brightness: Brightness.dark,
                  primary: Colors.deepPurpleAccent,
                  onPrimary: Colors.white,
                  secondary: Colors.deepPurpleAccent,
                  onSecondary: Colors.white,
                  error: Colors.red,
                  onError: Colors.white,
                  background: Colors.black26,
                  onBackground: Colors.white,
                  surface: Colors.black12,
                  onSurface: Colors.white),
            ),
            home: const MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage

  ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<ClickCubit, ClickState>(
              builder: (context, state) {
                if (state is ClickPicture) {
                  return SizedBox(
                    width: 320,
                    height: 158,
                    child: Image.asset('assets/img.png'),
                  );
                }
                if (state is Click) {
                  return Text(
                    state.count.toString(),
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline4,
                  );
                }
                return Text(
                  '0',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline4,
                );
              },
            ),
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 100,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<ClickCubit>()
                          .onClickInc(context
                          .read<ThemeCubit>()
                          .themeMode);
                    },
                    child: const Text('+'),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<ClickCubit>()
                          .onClickDec(context
                          .read<ThemeCubit>()
                          .themeMode);
                    },
                    child: const Text('-'),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
            SizedBox(
              height: 360,
              width: 300,
              child: Card(
                color: Theme
                    .of(context)
                    .colorScheme
                    .surface,
                child: Column(
                  children: [
                    Text(
                      'История',
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline4,
                    ),
                    Expanded(
                      child: BlocBuilder<ClickCubit, ClickState>(
                        builder: (context, state) {
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Center(
                                child: Text(context
                                    .read<ClickCubit>()
                                    .widgetList[index]),
                              );
                            },
                            itemCount:
                            context
                                .read<ClickCubit>()
                                .widgetList
                                .length,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              context.read<ThemeCubit>().changeTheme();
              context.read<ClickCubit>().onThemeChanged(context);
            },
            child: const Icon(Icons.accessible_forward_sharp),
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
