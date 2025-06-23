import Foundation
import UIKit
import Eitri

/**
 * EitriService is a suggested service to manage the EitriMachine and EitriMachineStack.
 *
 * It's responsible for configuring the EitriMachine and exposing the necessary Eitri APIs for the app.
 *
 * It's also wrapping the asynchronous nature of the EitriMachine configuration and run methods
 * to make it easier to use in an older native iOS application. 
 * If you are a modern architecture, you might want to adapt this service to fit your needs.
 */
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
            EitriBridgeHelper().exposeFunctions(eitriMachine: mainEitriMachine)
        }
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
