import Foundation
import Eitri
import UIKit

class MainAppService {
    
    let eitriService: EitriService
    
    static let shared: MainAppService = {
        let instance = createAppService()
        return instance
    }()
        
    init(
        eitriService: EitriService,
    ) {
        self.eitriService = eitriService
    }
    
    private static func createAppService() -> MainAppService {
        
        let mainEitriMachineCtx = EitriMachineInstanceManager.start()
        
        let eitriService = EitriService(
            eitriMachine: mainEitriMachineCtx.mainMachine,
            eitriMachineStack: mainEitriMachineCtx.mainStack,
        )
        
        return MainAppService(
            eitriService: eitriService
        )
    }
}
