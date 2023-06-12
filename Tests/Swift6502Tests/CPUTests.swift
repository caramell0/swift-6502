import XCTest
@testable import Swift6502

final class CPUTests: XCTestCase {
    
    // MARK: Playground
    func testExample() throws {
        var memory = Memory()
        var cpu = CPU()
        cpu.reset(memory: &memory)
        
        memory[0xfffc] = Instruction.ldaImmediate.rawValue
        memory[0xfffd] = 0x42
        
        try cpu.execute(cycles: 2, memory: &memory)
        
        print(memory)
    }
    
}
