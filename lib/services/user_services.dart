import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';
import '../helper/DB1Helper.dart';
import '../model/User.dart';
class  UserService{
void saveUser(var name,var contact){
 DB1Helper.insert("users2",{"id":DateTime.now().toString(),"name":name,"contact":contact});
  }
  Future <List<User>> fetchUser() async{
    final usersList=await DB1Helper.getData("users2");
    return usersList.map((item) => User(id:item["id"],name: item["name"],contact: item["contact"])).toList();
  }
  void deleteUser(var id){
    DB1Helper.deleteData("users2", id);
  }
  void updateUser(var id,var name, var contact){
    DB1Helper.updateData("users2", id, {"id":DateTime.now().toString(),"name":name,"contact":contact});
  }
}
