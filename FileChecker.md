# FileChecker

Check file existence and SHA1 hash to check if file is valid or invalid, and return invalid file list. `Downloader` will download these files.

All file checker should inherit `IFileChecker`. There are 3 default file checkers, `AssetChecker`, `ClientChecker`, `LibraryChecker`.

## Example

```csharp
var launcher = new CMLauncher(new MinecraftPath());

// Skip asset file checking
launcher.GameFileCheckers.AssetFileChecker = null;

// Skip hash checking of library files
launcher.GameFileCheckers.LibraryFileChecker.CheckHash = false;

// Use BMCLAPI mirror server
launcher.GameFileCheckers.LibraryFileChecker.LibraryServer = "https://bmclapi2.bangbang93.com/maven";
launcher.GameFileCheckers.AssetFileChecker.AssetServer = "https://bmclapi2.bangbang93.com/assets";

// Add custom file checker
launcher.GameFileCheckers.Add(new MyFileChecker());
```

## IFileChecker interface

#### event DownloadFileChangedHandler ChangeFile;

#### DownloadFile[] CheckFiles(MinecraftPath path, MVersion version);

Check game files and return invalid file list.

#### Task<DownloadFile[]> CheckFilesTaskAsync(MinecraftPath path, MVersion version);

Check game files and return invalid file list.

## AssetChecker class

Check asset files.

### Properties

#### AssetServer

*Type: string*

Asset server to download files.  
Default value: `http://resources.download.minecraft.net/`

#### CheckHash

*Type: bool*

Check SHA1 hash of file.

## LibraryChecker class

Check library files.

### Properties

#### LibraryServer

*Type: string*

Default library server to download files.  
Default value: `https://libraries.minecraft.net/`

#### CheckHash

*Type: bool*

Check SHA1 hash of file.

## ClientChecker class

Check client jar files.

### Properties

#### CheckHash

*Type: bool*

Check SHA1 hash of file.

## Make custom FileChecker

Make derived class of `IFileChecker`.

## FileCheckerCollection class

Represents IFileChecker list to be executed.  
It contains 3 default FileChecker, `AssetChecker`, `ClientChecker`, `LibraryChecker`.  
You can add your FileChecker or remove default FileChecker.  

### Properties

#### AssetFileChecker

*Type: AssetChecker*

Get default AssetChecker

#### ClientFileChecker

*Type: ClientChecker*

Get default ClientChecker

#### LibraryFileChecker

*Type: LibraryChecker*

Get default LibraryChecker

### Methods

#### public void Add(IFileChecker item)

Add IFileChecker to collection

#### public void Remove(IFileChecker item)

Remove IFileChecker in current collection

#### public void RemoveAt(int index)

Remove IFileChecker using specific index number.

#### public void Insert(int index, IFileChecker item)

Add IFileChecker at specific position.