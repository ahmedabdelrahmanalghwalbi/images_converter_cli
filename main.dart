import 'lib/alghwalbi_images_converter.dart';

final prompter = const Prompter();
void main() {
  final bool? choice = prompter.buildBinaryQuestion(
      prompt: "Are you here to convert an image", options: []);
  if (choice != true) {
    exit(0);
  }
  final OptionModel? selectedFormate = prompter.buildQuestion(
      prompt: "Select Formate :-", options: buildFormatAction());
  final OptionModel? selectedFormat = prompter.buildQuestion(
      prompt: "Select an Image To Convert :-", options: buildFileOptions());
  final String newImagePathAfterConverting =
      convertImage(selectedFormat?.value, selectedFormate?.value);
  final bool? openImage =
      prompter.buildBinaryQuestion(prompt: "Open The Image ? ", options: []);
  if (openImage == true) {
    //this method Proccess.run() is Equale that when i write open command in terminal >open image.png
    Process.run('Open', [newImagePathAfterConverting]);
  }
}

List<OptionModel> buildFormatAction() => [
      OptionModel(label: 'Convert to jpeg', value: 'jpeg'),
      OptionModel(label: 'Convert to png', value: 'png')
    ];

List<OptionModel> buildFileOptions() {
//Get a refrence to the current working directory
  final currentDirectory = Directory.current;
//Find all the files and folders in this directory
  var entities = currentDirectory.listSync();
//Look through that list and find only *images files*
  entities = entities
      .where((entity) =>
              FileSystemEntity.isFileSync(
                  entity.path) // this condition ensure that the entity is File
              &&
              entity.path.contains(RegExp(
                  r'\.(png|jpg|jpeg)')) //this condition ensure that the entity is image
          )
      .toList();
// Take all the images and create an option object out of each
  return entities
      .map((entity) => OptionModel(
          label: entity.path.split(Platform.pathSeparator).last, value: entity))
      .toList();
}
