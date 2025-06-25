import Foundation
import Eitri

/**
 * EitriBridgeHelper is a utility class to expose functions to eitri-apps.
 *
 * It contains methods to expose custom APIs that can be used in the Eitri environment.
 *
 * This is where you can define your custom functions that will be available in the eitri-apps.
 */
class EitriBridgeHelper {
    
    func exposeFunctions(eitriMachine: EitriMachine) {
        
        // simple fn to demonstrate exposedApis
        try? eitriMachine.bridge.exposeMethod(namespace: "math", methodName: "sum", fn: { params in
            if let a = params.data["a"] as? Double, let b = params.data["b"] as? Double {
                return a + b
            }
            throw NSError(domain: "math.sum.failed", code: 0)
        })
    }
    
}
