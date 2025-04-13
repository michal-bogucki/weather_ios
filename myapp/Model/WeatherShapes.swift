import SwiftUI

// MARK: - Custom Weather Shapes
// Contains shape definitions for weather elements like clouds, raindrops, snowflakes, etc.

// Cloud shape
struct CloudShape: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        
        var path = Path()
        
        // Main cloud body
        path.addEllipse(in: CGRect(x: width * 0.2, y: height * 0.2, width: width * 0.6, height: height * 0.6))
        path.addEllipse(in: CGRect(x: width * 0.05, y: height * 0.3, width: width * 0.4, height: height * 0.5))
        path.addEllipse(in: CGRect(x: width * 0.55, y: height * 0.3, width: width * 0.4, height: height * 0.5))
        path.addEllipse(in: CGRect(x: width * 0.3, y: height * 0.1, width: width * 0.4, height: height * 0.5))
        
        return path
    }
}

// Raindrop shape
struct RainDrop: Shape {
    let length: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        
        var path = Path()
        path.move(to: CGPoint(x: width/2, y: 0))
        path.addLine(to: CGPoint(x: width/2, y: length))
        
        return path
    }
}

// Simple snowflake
struct SnowflakeSimple: Shape {
    func path(in rect: CGRect) -> Path {
        let centerX = rect.width / 2
        let centerY = rect.height / 2
        let size = min(rect.width, rect.height) / 2
        
        var path = Path()
        
        // Horizontal line
        path.move(to: CGPoint(x: centerX - size, y: centerY))
        path.addLine(to: CGPoint(x: centerX + size, y: centerY))
        
        // Vertical line
        path.move(to: CGPoint(x: centerX, y: centerY - size))
        path.addLine(to: CGPoint(x: centerX, y: centerY + size))
        
        // Diagonal line 1
        path.move(to: CGPoint(x: centerX - size * 0.7, y: centerY - size * 0.7))
        path.addLine(to: CGPoint(x: centerX + size * 0.7, y: centerY + size * 0.7))
        
        // Diagonal line 2
        path.move(to: CGPoint(x: centerX - size * 0.7, y: centerY + size * 0.7))
        path.addLine(to: CGPoint(x: centerX + size * 0.7, y: centerY - size * 0.7))
        
        return path
    }
}

// More detailed snowflake
struct SnowflakeComplex: Shape {
    func path(in rect: CGRect) -> Path {
        let centerX = rect.width / 2
        let centerY = rect.height / 2
        let size = min(rect.width, rect.height) / 2
        
        var path = Path()
        
        // Main 6 stems
        for i in 0..<6 {
            let angle = CGFloat(i) * .pi / 3
            
            // Main stem
            path.move(to: CGPoint(x: centerX, y: centerY))
            path.addLine(to: CGPoint(
                x: centerX + cos(angle) * size,
                y: centerY + sin(angle) * size
            ))
            
            // Branch 1
            let branchPoint = CGPoint(
                x: centerX + cos(angle) * size * 0.6,
                y: centerY + sin(angle) * size * 0.6
            )
            
            path.move(to: branchPoint)
            path.addLine(to: CGPoint(
                x: branchPoint.x + cos(angle + .pi/3) * size * 0.3,
                y: branchPoint.y + sin(angle + .pi/3) * size * 0.3
            ))
            
            // Branch 2
            path.move(to: branchPoint)
            path.addLine(to: CGPoint(
                x: branchPoint.x + cos(angle - .pi/3) * size * 0.3,
                y: branchPoint.y + sin(angle - .pi/3) * size * 0.3
            ))
        }
        
        return path
    }
}

// Lightning bolt
struct LightningBolt: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        
        var path = Path()
        
        path.move(to: CGPoint(x: width * 0.5, y: 0))
        path.addLine(to: CGPoint(x: width * 0.2, y: height * 0.5))
        path.addLine(to: CGPoint(x: width * 0.5, y: height * 0.5))
        path.addLine(to: CGPoint(x: width * 0.3, y: height))
        path.addLine(to: CGPoint(x: width * 0.7, y: height * 0.4))
        path.addLine(to: CGPoint(x: width * 0.5, y: height * 0.4))
        path.addLine(to: CGPoint(x: width * 0.5, y: 0))
        
        return path
    }
}

// MARK: - Modern Snowflake
struct ModernSnowflake: Shape {
    func path(in rect: CGRect) -> Path {
        let centerX = rect.width / 2
        let centerY = rect.height / 2
        let size = min(rect.width, rect.height) / 2
        
        var path = Path()
        
        // Main 6 stems - more elegant design
        for i in 0..<6 {
            let angle = CGFloat(i) * .pi / 3
            
            // Main stem
            path.move(to: CGPoint(x: centerX, y: centerY))
            path.addLine(to: CGPoint(
                x: centerX + cos(angle) * size,
                y: centerY + sin(angle) * size
            ))
            
            // Branch 1
            let branchPoint1 = CGPoint(
                x: centerX + cos(angle) * size * 0.5,
                y: centerY + sin(angle) * size * 0.5
            )
            
            path.move(to: branchPoint1)
            path.addLine(to: CGPoint(
                x: branchPoint1.x + cos(angle + .pi/3) * size * 0.3,
                y: branchPoint1.y + sin(angle + .pi/3) * size * 0.3
            ))
            
            // Branch 2
            path.move(to: branchPoint1)
            path.addLine(to: CGPoint(
                x: branchPoint1.x + cos(angle - .pi/3) * size * 0.3,
                y: branchPoint1.y + sin(angle - .pi/3) * size * 0.3
            ))
        }
        
        return path
    }
}
