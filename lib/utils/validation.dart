class Validation {

  static String? validateMail(String value){
    if(value.isEmpty){
      return "Please Enter Email";
    }
    if(!value.contains('@')){
          return "Enter valid mail";
    }
    return null;
  }


  static String? validatePassword(String value){
    if(value.isEmpty||value==null){
      return "Please Ebter Password";
    }
    if(value.length<=6){
       return "Password must be 6 character";
    }
    return null;
  }
}