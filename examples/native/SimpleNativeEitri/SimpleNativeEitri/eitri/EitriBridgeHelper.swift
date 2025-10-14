import Foundation
import AVFoundation
import SwiftUI
import Eitri
import CodeScanner

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
        // call it in the JS side with `await EITRI.exposedApis.math.sum({a:1, b:2})`
        try? eitriMachine.bridge.exposeMethod(namespace: "math", methodName: "sum", fn: { params in
            if let a = params.data["a"] as? Double, let b = params.data["b"] as? Double {
                return a + b
            }
            throw NSError(domain: "math.sum.failed", code: 0)
        })
        
        exposeCameraFunctions(eitriMachine)
    }
    
    /// sample function interacting with UI and continuation flow
    /// call it in the JS side with `await EITRI.exposedApis.camera.startScanner()`
    /// 
    /// WARNING: This implementation makes simplifying assumptions about Navigation Controller availability:
    /// - Assumes the current view controller has a navigationController
    /// - Does not handle cases where navigationController is nil
    /// - In production code, consider adding fallback presentation logic for direct view controller presentation
    private func exposeCameraFunctions(_ eitriMachine: EitriMachine) {
        let namespace = "camera"
        let bridge = eitriMachine.bridge

        try? bridge.exposeMethod(namespace: namespace, methodName: "startScanner", fn: { @MainActor params in
            
            guard let currentVC = EitriViewControllerUtils.topView(searchInsideBottomBars: false) else { return }
            
            let scanResult = await withCheckedContinuation { continuation in
                let codeScannerView = CodeScannerView(
                    codeTypes: [.qr, .ean13],
                    scanMode: .once
                ) { result in
                    switch result {
                    case .success(let scanResult):
                        // SIMPLIFIED: Assumes navigationController exists for dismissal
                        // TODO: Add fallback for direct view controller dismissal
                        if let topVC = currentVC.navigationController {
                            continuation.resume(returning: scanResult.string)
                            topVC.dismiss(animated: true)
                        }
                    case .failure(let error):
                        continuation.resume(returning: error.localizedDescription)
                    }
                }
            
                // SIMPLIFIED: Assumes navigationController exists for presentation
                // TODO: Add fallback to present directly on currentVC if navigationController is nil
                if let navController = currentVC.navigationController {
                    navController.present(UIHostingController(rootView: codeScannerView), animated: true)
                }
            }

            return scanResult
        })
    }
    
}
