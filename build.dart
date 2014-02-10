import 'dart:io';

void main(List<String> args){
  for(String arg in args){
    if(arg.startsWith("--changed=")){
      String fileName = arg.substring("--changed=".length);
      if(!fileName.startsWith("tool/")){
        copyFile(fileName);
      }
    } else if(arg.startsWith("--removed=")){
      String fileName = arg.substring("--removed=".length);
      if(!fileName.startsWith("tool/")){
        removeFile(fileName);
      }
      
    }
  }
}

void copyFile(String newFile){
  File file = new File("tool/change");
  file.writeAsStringSync(newFile+"\n", mode: FileMode.APPEND, flush: true);
}

void removeFile(String newFile){
  File file = new File("tool/remove");
  file.writeAsStringSync(newFile+"\n", mode: FileMode.APPEND, flush: true);
}