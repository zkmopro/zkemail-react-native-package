# zkEmail React Native Package via MoproFFI

## How to Import the Package

Use a Node.js package manager in your React Native app to install dependencies. For example:

```sh
npm install https://github.com/zkmopro/zkemail-react-native-package
```

Alternatively, you can manually add it to your `package.json`:

```json
"dependencies": {
  "zkemail-react-native-package": "github:zkmopro/zkemail-react-native-package",
}
```

## How to Use the Package

### zkEmail Proofs

```ts
import ZKEmailReactNativePackage from "zkemail-react-native-package";

const inputs = {
    header_storage: [...], // Array of header storage bytes as strings
    header_len: ["123"],   // Header length
    pubkey_modulus: [...], // Modulus components
    pubkey_redc: [...],    // REDC components
    signature: [...],      // Signature components
    date_index: ["42"],
    subject_index: ["100"],
    subject_length: ["20"],
    from_header_index: ["150"],
    from_header_length: ["30"],
    from_address_index: ["200"],
    from_address_length: ["40"]
}

const proof = ZKEmailReactNativePackage.proveZkemail(
    "/path/to/srs",
    inputs
);

const valid = ZKEmailReactNativePackage.verifyZkemail(
    "/path/to/srs",
    proof
);
```

## Running on a real device

Since this is a native module, you’ll need to use Expo's build commands to run it on a device.
We’ve included an example app in the example folder to help you get started and test:

```sh
cd example
```

### iOS

To run on a connected iOS device:

```sh
npm run ios:device
```

### Android

To run on Android:

```sh
npm run android
```

## How to Build the Package

### iOS

You’ll need to update [`zkemail-swift-package`](https://github.com/zkmopro/zkemail-swift-package) and run `npm run ios:device` again to use the latest version.
You can check `ios/Podfile.lock` to verify if `ZKEmailSwift` is up to date.

> [!WARNING]  
> We’ll be setting up a GitHub Actions workflow soon to automatically publish `ZKEmailSwift`.

### Android

Follow the instructions in the [`zkemail-kotlin-package` README](https://github.com/zkmopro/zkemail-kotlin-package?tab=readme-ov-file#how-to-build-the-package) to build the package, then run `npm run android` again.


## Community

- X account: <a href="https://twitter.com/zkmopro"><img src="https://img.shields.io/twitter/follow/zkmopro?style=flat-square&logo=x&label=zkmopro"></a>
- Telegram group: <a href="https://t.me/zkmopro"><img src="https://img.shields.io/badge/telegram-@zkmopro-blue.svg?style=flat-square&logo=telegram"></a>

## Acknowledgements

This work was initially sponsored by a joint grant from [PSE](https://pse.dev/) and [0xPARC](https://0xparc.org/). It is currently incubated by PSE.

This project is heavily inspired by [ezkl-swift-package](https://github.com/zkonduit/ezkl-swift-package) and follows a similar approach for integrating native cryptographic libraries into Swift via a Swift Package.
