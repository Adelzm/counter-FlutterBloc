import 'package:flutter/material.dart';
import 'package:flutter_bloc_counter/bloc/counter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: MaterialApp(
        title: 'Special Counter Flutter Bloc',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            centerTitle: true,
            elevation: 0,
          ),
        ),
        home: const CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CounterBloc, CounterState>(
        listener: (context, state) {
          _controller.clear();
        },
        builder: (context, state) {
          final invalidValue =
              (state is CounterStateInvalidNumber) ? state.invalidNumber : '';
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 64),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(flex: 2),
                  _TextContainer(text: '${state.number}'),
                  const Spacer(flex: 1),
                  _MainTextField(controller: _controller),
                  Visibility(
                    visible: state is CounterStateInvalidNumber,
                    child: Column(
                      children: [
                        const SizedBox(height: 14),
                        Text(
                          '"$invalidValue" is an invalid input',
                          style:
                              const TextStyle(fontSize: 18, color: Colors.red),
                        )
                      ],
                    ),
                  ),
                  const Spacer(flex: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _CircularOutlinedButton(
                        icon: Icons.add,
                        onPressed: () {
                          context
                              .read<CounterBloc>()
                              .add(IncrementEvent(value: _controller.text));
                        },
                      ),
                      _CircularOutlinedButton(
                        icon: Icons.remove,
                        onPressed: () {
                          context
                              .read<CounterBloc>()
                              .add(DecrementEvent(value: _controller.text));
                        },
                      ),
                    ],
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TextContainer extends StatelessWidget {
  const _TextContainer({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.amber, width: 2),
        borderRadius: BorderRadiusDirectional.circular(24),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 26, color: Colors.amber),
        ),
      ),
    );
  }
}

class _MainTextField extends StatelessWidget {
  const _MainTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 26, color: Colors.amber),
      textAlign: TextAlign.center,
      cursorColor: Colors.amber,
      cursorWidth: 2,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        hintText: 'Enter Number',
        hintStyle: TextStyle(fontSize: 26, color: Colors.amber.withAlpha(200)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.amber, width: 2),
          borderRadius: BorderRadius.circular(24),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.amber, width: 2),
          borderRadius: BorderRadius.circular(24),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}

class _CircularOutlinedButton extends StatelessWidget {
  const _CircularOutlinedButton(
      {Key? key, required this.icon, required this.onPressed})
      : super(key: key);
  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
          shape: const CircleBorder(),
          side: const BorderSide(color: Colors.amber, width: 2.0),
          padding: const EdgeInsets.all(16.0)),
      child: Icon(
        icon,
        size: 30,
        color: Colors.amber,
      ),
    );
  }
}
