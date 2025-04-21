import Foundation

struct SinRequestBody: Codable {
    let prompt: String
}

struct SinResponse: Codable {
    let sinResponse: String
    let penance: String
    let absolution: String
    let sinSeverity: Int
    let sinSeverityReason: String
    let meta: Meta
    
    enum CodingKeys: String, CodingKey {
        case sinResponse = "SinResponse"
        case penance = "Penance"
        case absolution = "Absolution"
        case sinSeverity = "SinSeverity"
        case sinSeverityReason = "SinSeverityReason"
        case meta = "_meta"
    }
    
    struct Meta: Codable {
        let usage: Usage
        let cacheHit: Bool
        
        struct Usage: Codable {
            let promptTokens: Int
            let completionTokens: Int
            let totalTokens: Int
            let promptTokensDetails: TokenDetails
            let completionTokensDetails: CompletionTokenDetails
            
            enum CodingKeys: String, CodingKey {
                case promptTokens = "prompt_tokens"
                case completionTokens = "completion_tokens"
                case totalTokens = "total_tokens"
                case promptTokensDetails = "prompt_tokens_details"
                case completionTokensDetails = "completion_tokens_details"
            }
            
            struct TokenDetails: Codable {
                let cachedTokens: Int
                let audioTokens: Int
                
                enum CodingKeys: String, CodingKey {
                    case cachedTokens = "cached_tokens"
                    case audioTokens = "audio_tokens"
                }
            }
            
            struct CompletionTokenDetails: Codable {
                let reasoningTokens: Int
                let audioTokens: Int
                let acceptedPredictionTokens: Int
                let rejectedPredictionTokens: Int
                
                enum CodingKeys: String, CodingKey {
                    case reasoningTokens = "reasoning_tokens"
                    case audioTokens = "audio_tokens"
                    case acceptedPredictionTokens = "accepted_prediction_tokens"
                    case rejectedPredictionTokens = "rejected_prediction_tokens"
                }
            }
        }
    }
}
