# All

### Could not create Java Virtual Machine
In 32bit OS Envrionment, you can't set MaximumRam(XMX) exceeding 1024

### Error: could not open jvm.cfg
Reinstall java.  
if your launcher use MJava, remove runtime directory(default: %appdata%/.minecraft/runtime) and download java through MJava again.

# macOS  

### DockName
You have to set DockName and DockIcon in LaunchOption.  
If DockName is empty, you can't click or access to minecraft window.

example:  

     var launchOption = new MLaunchOption
     {
         MaximumRamMb = 1024,
         Session = session, 
         DockName = "Minecraft"
     };

On macOS Catalina, Minecraft works normally without above option. but some macOS version doesn't work well.

### JRE
Old minecraft version doesn't support OpenJDK 11.  

# Linux  
Use Java 8. Old minecraft version doesn't support OpenJDK 11.

    sudo apt-get update
    sudo apt-get install openjdk-8-jre

and 

    java -version

It should return

    java version "1.8.0_~~~"