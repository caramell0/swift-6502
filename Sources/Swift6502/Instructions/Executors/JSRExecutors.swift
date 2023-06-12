import Foundation

struct JSRExecutors {
    
    private init() {}
    
    // MARK: JSR
    struct Absolute: InstructionExecutor {
        func execute(cpu: inout CPU, cycles: inout UInt32, memory: inout Memory) throws {
            // cycle: fetch value
            let subroutineAddr = cpu.fetchWord(cycles: &cycles, memory: &memory)
            
            // cycle: set return point
            // TODO: Instead of subtracting cycles all the time, why not have a higher order function that can do the cycle operations
            memory.write(word: cpu.programCounter - 1, address: cpu.stackPointer, cycles: &cycles)
            
            // cycle: set subroutine address
            cpu.programCounter = subroutineAddr
            cycles -= 1
            
            // cycle: increment stack pointer
            cpu.stackPointer += 1
            cycles -= 1
        }
    }
    
}
