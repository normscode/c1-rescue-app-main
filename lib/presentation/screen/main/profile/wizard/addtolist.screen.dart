
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AddToListScreen extends StatefulWidget {
  const AddToListScreen(this.editType, {super.key});

  final String editType;

  @override
  State<AddToListScreen> createState() => _AddToListScreenState();
}

class _AddToListScreenState extends State<AddToListScreen> {

  final TextEditingController editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add to ${widget.editType}"),
        leading: BackButton(onPressed: () {
          context.router.pop(editController.text);
        }),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 20),
          
                TextField(
                  controller: editController,
                  decoration: InputDecoration(
                      label: Text(widget.editType),
                      prefixIcon: const Icon(Icons.medical_information_sharp)),
                ),
                
                const SizedBox(height: 20),
          
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.router.pop(editController.text);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    child: Text("Add ${widget.editType}",
                      style: const TextStyle(color: Colors.black)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}