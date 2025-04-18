package expo.modules.moproreactnativepackage

import expo.modules.kotlin.modules.Module
import expo.modules.kotlin.modules.ModuleDefinition
import expo.modules.moproreactnativepackage.ExpoProof
import java.net.URL
import java.io.File
import uniffi.mopro.CircomProof
import uniffi.mopro.generateCircomProof
import uniffi.mopro.ProofLib
import uniffi.mopro.proveZkemail
import uniffi.mopro.verifyZkemail

fun convertType(proof: CircomProof): ExpoProof {
  var a = ExpoG1(proof.a.x, proof.a.y)
  var b = ExpoG2(proof.b.x, proof.b.y)
  var c = ExpoG1(proof.c.x, proof.c.y)
  var output = ExpoProof(a, b, c)
  return output
}

fun generateProof(zkeyPath: String, circuitInputs: String): Result {
  val file = File(zkeyPath)
  val res = generateCircomProof(file.absolutePath, circuitInputs, ProofLib.ARKWORKS)
  val result = Result(convertType(res.proof), res.inputs)
  return result
}

class MoproReactNativePackageModule : Module() {
  // Each module class must implement the definition function. The definition consists of components
  // that describes the module's functionality and behavior.
  // See https://docs.expo.dev/modules/module-api for more details about available components.
  override fun definition() = ModuleDefinition {
    // Sets the name of the module that JavaScript code will use to refer to the module. Takes a string as an argument.
    // Can be inferred from module's class name, but it's recommended to set it explicitly for clarity.
    // The module will be accessible from `requireNativeModule('MoproReactNativePackage')` in JavaScript.
    Name("MoproReactNativePackage")

    // Sets constant properties on the module. Can take a dictionary or a closure that returns a dictionary.
    Constants(
      "PI" to Math.PI
    )

    // Defines event names that the module can send to JavaScript.
    Events("onChange")

    // Defines a JavaScript synchronous function that runs the native code on the JavaScript thread.
    Function("hello") {
      "Hello world! 👋"
    }

    Function("generateCircomProof") { zkeyPath: String, circuitInputs: String ->
      generateProof(zkeyPath, circuitInputs)
    }

    Function("proveZkemail") { srsPath: String, inputs: Map<String, List<String>> ->
      proveZkemail(srsPath, inputs)
    }

    Function("verifyZkemail") { srsPath: String, proof: ByteArray ->
      verifyZkemail(srsPath, proof)
    }

    // Defines a JavaScript function that always returns a Promise and whose native code
    // is by default dispatched on the different thread than the JavaScript runtime runs on.
    AsyncFunction("setValueAsync") { value: String ->
      // Send an event to JavaScript.
      sendEvent("onChange", mapOf(
        "value" to value
      ))
    }

    // Enables the module to be used as a native view. Definition components that are accepted as part of
    // the view definition: Prop, Events.
    View(MoproReactNativePackageView::class) {
      // Defines a setter for the `url` prop.
      Prop("url") { view: MoproReactNativePackageView, url: URL ->
        view.webView.loadUrl(url.toString())
      }
      // Defines an event that the view can send to JavaScript.
      Events("onLoad")
    }
  }
}
