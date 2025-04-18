import ExpoModulesCore
import ZKEmailSwift

// func convertType(proof: CircomProof) -> ExpoProof {
//   var a = ExpoG1()
//   a.x = proof.a.x
//   a.y = proof.a.y

//   var b = ExpoG2()
//   b.x = proof.b.x
//   b.y = proof.b.y

//   var c = ExpoG1()
//   c.x = proof.c.x
//   c.y = proof.c.y

//   var expoProof = ExpoProof()
//   expoProof.a = a
//   expoProof.b = b
//   expoProof.c = c
//   return expoProof
// }

// func generateProof(zkeyPath: String, circuitInputs: String) -> Result {
//   do {
//     let res = try generateCircomProof(
//       zkeyPath: zkeyPath, circuitInputs: circuitInputs, proofLib: ProofLib.arkworks)
//     let result = Result()
//     result.inputs = res.inputs
//     result.proof = convertType(proof: res.proof)
//     return result
//   } catch {
//     print("Error: \(error)")
//     let result = Result()
//     result.inputs = [error.localizedDescription]
//     return result
//   }
// }

public class MoproReactNativePackageModule: Module {
  // Each module class must implement the definition function. The definition consists of components
  // that describes the module's functionality and behavior.
  // See https://docs.expo.dev/modules/module-api for more details about available components.
  public func definition() -> ModuleDefinition {
    // Sets the name of the module that JavaScript code will use to refer to the module. Takes a string as an argument.
    // Can be inferred from module's class name, but it's recommended to set it explicitly for clarity.
    // The module will be accessible from `requireNativeModule('MoproReactNativePackage')` in JavaScript.
    Name("MoproReactNativePackage")

    // Sets constant properties on the module. Can take a dictionary or a closure that returns a dictionary.
    Constants([
      "PI": Double.pi
    ])

    // Defines event names that the module can send to JavaScript.
    Events("onChange")

    // Defines a JavaScript synchronous function that runs the native code on the JavaScript thread.
    Function("hello") {
      return "Hello world! 👋"
    }

    // Function("generateCircomProof") {
    //   (zkeyPath: String, circuitInputs: String) -> Result in

    //   // Call into the compiled static library
    //   return generateProof(zkeyPath: zkeyPath, circuitInputs: circuitInputs)
    // }

    Function("proveZkemail") {
      (srsPath: String, inputs: [String: [String]]) -> Data in
      return try! proveZkemail(srsPath: srsPath, inputs: inputs)
    }

    Function("verifyZkemail") {
      (srsPath: String, proof: Data) -> Bool in
      return try!verifyZkemail(srsPath: srsPath, proof: proof)
    }

    // Defines a JavaScript function that always returns a Promise and whose native code
    // is by default dispatched on the different thread than the JavaScript runtime runs on.
    AsyncFunction("setValueAsync") { (value: String) in
      // Send an event to JavaScript.
      self.sendEvent(
        "onChange",
        [
          "value": value
        ])
    }

    // Enables the module to be used as a native view. Definition components that are accepted as part of the
    // view definition: Prop, Events.
    View(MoproReactNativePackageView.self) {
      // Defines a setter for the `url` prop.
      Prop("url") { (view: MoproReactNativePackageView, url: URL) in
        if view.webView.url != url {
          view.webView.load(URLRequest(url: url))
        }
      }

      Events("onLoad")
    }
  }
}
