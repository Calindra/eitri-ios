import Foundation
import Eitri
import UIKit

/**
 * MainAppService is just an example. Create your own control structure using
 * inversion of control and dependency injection to manage your EitriService instance.
 *
 * It is a singleton, so it can be accessed from anywhere in the app.
 * It's just a sample service to demonstrate how to create and keep an EitriService instance.
 *
 * @property eitriService The EitriService instance.
 */
class MainAppService {
    
    let eitriService: EitriService
    
    static let shared: MainAppService = {
        let instance = createAppService()
        return instance
    }()
        
    init(
        eitriService: EitriService
    ) {
        self.eitriService = eitriService
    }
    
    private static func createAppService() -> MainAppService {
        
        let mainEitriMachineCtx = EitriMachineInstanceManager.start()
        
        let eitriService = EitriService(
            eitriMachine: mainEitriMachineCtx.mainMachine,
            eitriMachineStack: mainEitriMachineCtx.mainStack
        )
        
        return MainAppService(
            eitriService: eitriService
        )
    }
}
