import 'package:ahmad_suleiman/models/student.dart';
import 'package:ahmad_suleiman/util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class CscDetailsUploadPage extends StatefulWidget {
  const CscDetailsUploadPage({super.key});

  @override
  State<CscDetailsUploadPage> createState() => _CscDetailsUploadPageState();
}

class _CscDetailsUploadPageState extends State<CscDetailsUploadPage> {
  final TextEditingController fullNameController =
          TextEditingController(text: 'Umar Usman'),
      lastnameController = TextEditingController(text: 'hh'),
      nicknameController = TextEditingController(text: 'hh'),
      dobController = TextEditingController(text: 'hh'),
      originController = TextEditingController(text: 'hh'),
      hobbiesController = TextEditingController(text: 'hh'),
      workController = TextEditingController(text: 'hh'),
      relationshipController = TextEditingController(text: 'hh'),
      crushController = TextEditingController(text: 'hh'),
      igController = TextEditingController(text: 'hh'),
      stressLevelController = TextEditingController(text: 'hh'),
      bestMomentController = TextEditingController(text: 'hh'),
      courseController = TextEditingController(text: 'hh'),
      lecturerController = TextEditingController(text: 'hh'),
      whatElseController = TextEditingController(text: 'hh'),
      quoteController = TextEditingController(text: 'hh');

  final formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();

  Uint8List? localImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: Image.asset('assets/images/others/kasulogo.png'),
            title: Text('Computer Science Students Personality Flyer Creator',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold))),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  Form(
                      key: formKey,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: <Widget>[
                            addImageWidget,
                            input('Full name', fullNameController),
                            input('Nickname', nicknameController),
                            input('Date Of Birth', dobController),
                            input('Hobbies', hobbiesController),
                            input('Business/Skills', workController),
                            input(
                                'Relationship status', relationshipController),
                            input('Class crush', crushController),
                            input('IG handle', igController),
                            input(
                                'Most stressful level', stressLevelController),
                            input(
                                'Best Moment on Campus', bestMomentController),
                            input('Favourite course', courseController),
                            input('Favourite lecturer', lecturerController),
                            input('If not CSC, What else?', whatElseController),
                            input('Favourite quote', quoteController)
                          ]))),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              Theme.of(context).colorScheme.primaryContainer)),
                      onPressed: () {
                        if (localImage != null) {
                          if (formKey.currentState!.validate()) {
                            Student student = Student(
                                image: localImage!,
                                fullName: fullNameController.text,
                                nickname: nicknameController.text,
                                dob: dobController.text,
                                origin: originController.text,
                                hobbies: hobbiesController.text,
                                work: workController.text,
                                relationship: relationshipController.text,
                                crush: crushController.text,
                                ig: igController.text,
                                stressfulLevel: stressLevelController.text,
                                bestMoment: bestMomentController.text,
                                course: courseController.text,
                                lecturer: lecturerController.text,
                                whatElse: whatElseController.text,
                                quote: quoteController.text);

                            context.go("/csc-personality-page", extra: student);
                          }
                        } else {
                          snackBar(context, 'Abeg add image');
                        }
                      },
                      label: const Text('Upload'),
                      icon: const Icon(Icons.upload))
                ]))));
  }

  Widget get addImageWidget {
    if (localImage != null) {
      return Column(children: [
        Image(
            height: 300,
            image: MemoryImage(localImage!),
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error),
            fit: BoxFit.fitWidth),
        const SizedBox(height: 20),
        TextButton.icon(
            onPressed: addImage,
            label: const Text('Replace image'),
            icon: const Icon(Icons.change_circle))
      ]);
    } else {
      return SizedBox(
          height: 300,
          child: Center(
              child: TextButton.icon(
                  onPressed: addImage,
                  label: const Text('Add image'),
                  icon: const Icon(Icons.upload))));
    }
  }

  void addImage() async {
    Uint8List? image;
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) image = await file.readAsBytes();
    setState(() => localImage = image);
  }

  Widget input(String label, final TextEditingController controller) =>
      TextFormField(
          controller: controller,
          decoration: InputDecoration(labelText: label),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Write something';
            return null;
          });
}
