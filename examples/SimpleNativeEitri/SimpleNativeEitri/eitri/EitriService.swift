import Foundation
import UIKit
import Eitri

class EitriService {
    
    // TODO: Replace with the current app version or marketing version
    let appVersion = "1.0.0"
    
    // TODO: Replace with a scheme property and use a real environment key provided by the Eitri team
    let envKey = "b73b5d05-183a-4630-b442-71d2b61cfaaa"
    
    let mainEitriMachine: EitriMachine
    let eitriMachineStack: EitriMachineStack
    
    init(
        eitriMachine: EitriMachine,
        eitriMachineStack: EitriMachineStack
    ) {
        self.mainEitriMachine = eitriMachine
        self.eitriMachineStack = eitriMachineStack
    }
    
    func configure() {
        Task {
            do {
                
                let configureInput = ConfigureInput(
                    version: appVersion,
                    environmentKey: envKey,
                    debugMode: self.isEitriDevEnabled(),
                    theme: ThemeConfig(
                        light: Theme(backgroundColor: "#1E1E1E"),
                        dark: Theme(backgroundColor: "#1E1E1E")
                    )
                )
                
                try await self.mainEitriMachine.configure(input: configureInput)
            } catch {
                print("error initializing EitriPlayer", error)
            }
            
            try? mainEitriMachine.bridge.exposeNativeNavigationApi(eitriMachineStack: eitriMachineStack)
            EitriBridgeHelper().exposeFunctions(mainEitriMachine, eitriMachineStack)
        }
    }
    
    private func resetEitriMachineStack() async throws {
        let removedEitriMachine = eitriMachineStack.pop()
        let lastEitriMachine = eitriMachineStack.peek()
        
        if(lastEitriMachine?.instanceId() == removedEitriMachine?.instanceId()) {
            return
        }
        
        try await resetEitriMachineStack()
    }
    
    func runOnTop(_ options: RunInput) {
        Task { @MainActor in
            do {
                try await self.eitriMachineStack.createReplicaInstance().run(options: options)
            } catch {
                print("runOnTop.error", error)
            }
        }
    }
    
    func isEitriDevEnabled() -> Bool {
        // TODO: Define your rules. Production builds typically set this to false to disable Eitri debugging.
        return true
    }
}
