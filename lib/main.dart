import 'package:flutter/material.dart';
import './services/user_services.dart';
import './model/User.dart';
void main(){
runApp(MyApp2());
}
class MyApp2 extends StatefulWidget {
  const MyApp2({super.key});

  @override
  State<MyApp2> createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _contactController=TextEditingController();

  final services=UserService();
  
  void showBottomModal(BuildContext context, var id, var name, var contact){
    final TextEditingController _updateContactController=TextEditingController();
    final TextEditingController _updateNameController= TextEditingController();
    _updateNameController.text=name;
     _updateContactController.text=contact.toString();
     showModalBottomSheet(context: context, builder: (_){
     return  Container(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              labelText:"Name",hintText: "Enter your Name",
              border: OutlineInputBorder(),
    
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: "Contact",hintText: "Enter your Contact",
              border: OutlineInputBorder() 
            ),
          ),
         ),
         Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
         child:ElevatedButton(onPressed: (){
          setState(() {
           services.updateUser(id, _updateNameController.text,
            int.parse(_updateContactController.text));
          });
          Navigator.of(context).pop();

         }, child: Text("Update User"),),
         )
         ]
         
         ));
    }
    );
  }



  @override
  Widget build(BuildContext context) {
    
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
      child: Scaffold(
      appBar: AppBar(title: Text("Home Screen"),centerTitle: true,),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(15),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText:"Name",hintText: "Enter your name"),
              ),
            ),
            Padding(padding: EdgeInsets.all(15),
              child: TextFormField(
                controller: _contactController,
                decoration: InputDecoration(labelText:"Contact",hintText: "Enter your Contact No."),
               ),        
              ),
              ElevatedButton(onPressed:() {
                setState(() {
                services.saveUser(_nameController.text, int.parse(_contactController.text) );
 
                });
              }, 
              child: Text("Save")
              ),
              Expanded(
                child: FutureBuilder(future: services.fetchUser(), builder:(context, snapshot) {
              
                List<User>? users2=snapshot.data;
              
                  if (!snapshot.hasData) return (Text("No Data Found"));
              
                return Card(child: ListView.builder(itemCount:users2?.length, 
              
                itemBuilder:(context, index) {
              
                  return ListTile(title: Text("${users2![index].name}"),
                  subtitle: Text("${users2[index].contact}"),
                  trailing: Row(mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                   IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: (){
                    setState(() {
                      services.deleteUser(users2[index].id);
                    });
                   }),
                   IconButton(icon: Icon(Icons.edit),onPressed: ()=>showBottomModal(
                    
                  context,
                  users2[index].id,
                  users2[index].name,
                  users2[index].contact

                   )),


                  ],),
                  );
                  
                }));
                }
                
                ),
              )
            ],
           ),
      ),
       )
      )
    );
  }
}