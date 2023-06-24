import 'package:pokemon_explorer/generated/l10n.dart';
import 'package:pokemon_explorer/presentation/screens/animations/animations_screen.dart';
import 'package:pokemon_explorer/presentation/screens/pokemon/pokemon_screen.dart';
import 'package:pokemon_explorer/presentation/utils/text_input_validator.dart';
import 'package:pokemon_explorer/presentation/widgets/common/common.dart';
import 'package:pokemon_explorer/res/app_res.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _nameController =
      TextEditingController(text: kDebugMode ? 'debug name' : '');
  String _nameText = kDebugMode ? 'debug name' : '';

  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _updateInputText(String newText) {
    setState(() {
      _nameText = newText;
    });
  }

  void _clearText() {
    setState(() {
      _nameController.clear();
      _nameText = '';
    });
  }

  void _goToAnimations() {
    _dismissKeyboard();
    if (_formKey.currentState?.validate() ?? false) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.of(context)
            .pushNamed(AnimationsScreen.routeName, arguments: _nameText);
      });
    }
  }

  void _goToPokemon() {
    _dismissKeyboard();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context).pushNamed(PokemonScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _dismissKeyboard,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home',
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  // focusNode: FocusNode(),
                  onChanged: _updateInputText,
                  decoration: const InputDecoration(
                    labelText: 'Enter your name',
                  ),
                  validator: (text) {
                    return TextInputValidator(validators: [
                      InputValidator.requiredField,
                    ]).validate(text);
                  },
                ),
                SizedBox(height: 50.h),
                Text(
                  _nameText,
                  style: Styles.label1.copyWith(color: Colors.black),
                ),
                const Spacer(),
                TextButton(
                    onPressed: _clearText,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.delete, color: AppColors.redColor),
                        SizedBox(width: 10.w),
                        Text(
                          'Clear Text',
                          style:
                              Styles.label2.copyWith(color: AppColors.redColor),
                        )
                      ],
                    )),
                SizedBox(height: 50.h),
                AppElevatedButton(
                  callback: _goToAnimations,
                  label: 'Go to Animations Page',
                  color: AppColors.secondaryColor,
                ),
                SizedBox(height: 50.h),
                AppElevatedButton(
                    callback: _goToPokemon, label: 'Go to Pokemon Page'),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
