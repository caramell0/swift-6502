import Foundation

public protocol InstructionExecutor {
    func execute(cpu: inout CPU, cycles: inout UInt32, memory: inout Memory) throws
}

extension Instruction {
    public var executor: InstructionExecutor {
        switch self {
        case .jsrAbsolute:
            return JSRExecutors.Absolute()
        case .ldaImmediate:
            return LDAExecutors.Immediate()
        case .ldaZeroPage:
            return LDAExecutors.ZeroPage()
        case .ldaZeroPageX:
            return LDAExecutors.ZeroPageX()
        default:
            fatalError("missing executor for \(self)")
        }
    }
}
