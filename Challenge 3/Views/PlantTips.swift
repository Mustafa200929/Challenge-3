import SwiftUI
import FoundationModels
import Combine

@MainActor
class TipGenerator: ObservableObject {
    let session = LanguageModelSession(model: .default)

    func generateTips(for plant: PlantInfo, plantAge: Int, daysToGerminate: Int) async throws -> [String] {

        let prompt = """
        You are a plant care assistant.
        Generate 4 short plant care tips under 20 words.

        Plant Name: \(plant.name)
        Age in days: \(plantAge)
        Days to Germinate: \(daysToGerminate)

        Temperature requirement: \(plant.temp)
        Watering frequency: \(plant.wateringperiod)
        Lighting: \(plant.lighting)
        Toxicity: \(plant.toxicinfo)

        IMPORTANT:
        • If plantAge < daysToGerminate = give seed-level germination advice.
        • If plantAge == daysToGerminate = give sprouting transition advice.
        • If plantAge > daysToGerminate = give care tips for young/adult plant.

        Return ONLY:
        1. tip
        2. tip
        3. tip
        4. tip
        """

        let result = try await session.respond(to: prompt)
        let text = result.content

        let lines = text
            .components(separatedBy: .newlines)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }

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

