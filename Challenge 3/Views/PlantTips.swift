import SwiftUI
import FoundationModels
import Combine

@MainActor
class TipGenerator: ObservableObject {
    let session = LanguageModelSession(model: .default)

    func generateTips(for plant: PlantInfo) async throws -> [String] {

        let prompt = """
        You are a plant care assistant.
        Generate 4 short care tips under 20 words.

        Plant Name: \(plant.name)
        Temperature: \(plant.temp)
        Watering: \(plant.wateringperiod)
        Lighting: \(plant.lighting)
        Toxicity: \(plant.toxicinfo)

        Return ONLY:
        1. tip
        2. tip
        3. tip
        4. tip
        """

        // This returns LanguageModelSession.Response<String>
        let result = try await session.respond(to: prompt)

        // Extract actual text
        let text: String = result.content
        print("RAW OUTPUT:\n\(text)")

        // Split into separate lines
        let rawLines = text.components(separatedBy: CharacterSet.newlines)

        // Trim + remove empty rows
        let lines = rawLines
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }

        // Remove numbering like "1. " or "2) "
        let cleaned = lines.map { line in
            line.replacingOccurrences(
                of: #"^\d+[\.\)]\s*"#,
                with: "",
                options: .regularExpression
            )
        }

        return cleaned
    }
}
