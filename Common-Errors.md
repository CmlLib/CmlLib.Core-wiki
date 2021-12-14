# Common Errors

### Could not create Java Virtual Machine
In a 32-bit JVM, There is limit on `MaximumRamMb`.  
Recommended value of `MaximumRamMb` on 32-bit JVM is `1024`.  
[More information](https://stackoverflow.com/questions/1434779/maximum-java-heap-size-of-a-32-bit-jvm-on-a-64-bit-os/7019624#7019624)

### Error: could not open jvm.cfg
Reinstall Java.  
if your launcher uses `MJava` or `JavaChecker`, Remove the runtime directory (default: `<Your Minecraft Path>/runtime`) and install java again.

### SRV Record and `ServerIP`

Minecraft cannot connect to server which has a SRV record when you use direct server connection feature (MLaunchOption.ServerIP).  

# macOS

### DockName
You have to set DockName and DockIcon in LaunchOption.  
If DockName is empty, you can't click or access the Minecraft window.

Example:

```csharp
var launchOption = new MLaunchOption
{
    MaximumRamMb = 1024,
    Session = session, 
    DockName = "Minecraft"
};
```

On macOS Catalina, Minecraft works normally without the above options. but some macOS versions don't work well.

### JRE
Old Minecraft versions don't support OpenJDK 11.

# Linux
Use Java 8. Old Minecraft versions don't support OpenJDK 11.

To install Java 8, type the following lines in terminal:

```
sudo apt-get update
sudo apt-get install openjdk-8-jre
```

To make sure it worked, type `java -version`. It should return `java version "1.8.0_~~~"`.
