import Foundation
import Eitri

class EitriBridgeHelper {
    
    func exposeFunctions(_ eitriMachine: EitriMachine, _ eitriMachineStack: EitriMachineStack) {
        
        // simple fn to demonstrate exposedApis
        try? eitriMachine.bridge.exposeMethod(namespace: "math", methodName: "sum", fn: { params in
            if let a = params.data["a"] as? Double, let b = params.data["b"] as? Double {
                return a + b
            }
            throw NSError(domain: "math.sum.failed", code: 0)
        })
    }
    
}
