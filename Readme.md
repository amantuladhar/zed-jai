# Zed Jai

Jai extension for Jai. For LSP support (Jails) see description on repository. 

## Install on Zed (as dev extension)
> [!Note]
> You might need rust on your path, as zed extension is rust project and creates a wasm binary from the code.

1. Go to extension page
2. Click on "Install as Dev Extension"
3. Select the folder where you cloned this repository


## Jails support

For LSP support this extension uses [Jails](https://github.com/SogoCZE/Jails). Make sure you have cloned the repository and have a jails executable on your PATH.

Simplified instruction:

1. Clone the repository [Jails](https://github.com/SogoCZE/Jails)
2. Run `jai build.jai - -release`
3. Make sure your `<Jails_Path>/bin` is on your PATH.

> [!Note]
> Please checkout [Jails](https://github.com/SogoCZE/Jails) documentation for more details and latest instructions on how to install / build the project.

## TODO
- [ ] When jails binary can be download, update the code to auto download executable so this Jails setup is not needed.


