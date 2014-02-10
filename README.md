dart_buildhelper
==================

##Summary


These are a couple of files you can integrate into your existing dart project so that it makes it easier to build and integrate your application with a separate backend.

##Background

When working with a different backend on dart, I often have to do a build and then copy my build directory over to the backend. While I can use a shell script for it, I figured I'd like to do things as much in the DartEditor as I could. So I decided on a model where I use the DartEditor's `build.dart` capability to track my changed files and write them into a file called `tool/change`. After this, I use [Hop](https://github.com/dart-lang/hop) and created a task called `copy_files`. When I run the hop task, it copies any files found in my `tool/change` file across to my designated directory.


## Usage

To use this in your own project, first add hop to your `pubspec.yaml`:


```yaml
name: awesome_project
dependencies:
  hop: any
```

Then copy the `build.dart` file in this repo to the root of your project. This file will get executed anytime you make a file system change using your DartEditor. So a save or delete should trigger this file.

## Building your project

When you run `pub build` from the DartEditor, a `build` directory is created. The contents of this directory is written to the file called `tool/change` automatically. Then you run the `tool/hop_runner` as described in the [Hop](https://github.com/dart-lang/hop) project. This will copy your entire `build/` directory to the location you specify. 