library hop_runner;

import 'package:hop/hop.dart';
import 'dart:io';

// Set this to the location where you want to copy your files
final String deployDir = "/tmp/"; 

void main(List<String> args){
  addTask('copy_files',(TaskContext ctx){
    ctx.info("Starting copy...");
    // Check for "change" file
    File file = new File("tool/change");
    if(file.existsSync()){
      List<String> lines = file.readAsLinesSync();
      for(String line in lines){
        ctx.info(doCopy(line));
      }
      // Copy Packages
      ctx.info("Copying packages directory...");
      Directory packages = new Directory("build/packages/");
      List<FileSystemEntity> entries = packages.listSync(recursive: true, followLinks: true);
      for(FileSystemEntity entry in entries){
        if(entry is File){
          String newname = deployDir + entry.path.substring("build/".length);
          File newfile = new File(newname);
          if(!newfile.existsSync()){
            newfile.createSync(recursive: true);
          }
          entry.copySync(newname);
          ctx.info("Copied: ${entry.path}");
        }
      }
      file.deleteSync(recursive: false);
    } else{
      ctx.info("No change file detected, perhaps run a pub build?");
    }
    
  }, description: 'Copy all files to server deploy dir');
  
  runHop(args);
}

String doCopy(String filename){
  if(filename.startsWith("build/")){
    String newFileName = deployDir + filename.substring("build/".length);
    File oldfile = new File(filename);
    File newfile = new File(newFileName);
    if(!newfile.existsSync()){
      newfile.createSync(recursive: true);
      oldfile.copySync(newFileName);
    } else{
      oldfile.copySync(newFileName);
    }
    return "Copied: ${filename}";
  } else{
    return "Skipping file not in build/ directory";
  }
}