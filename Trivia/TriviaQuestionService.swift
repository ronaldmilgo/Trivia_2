import Foundation

class TriviaQuestionService {
    func fetchQuestions(completion: @escaping ([TriviaQuestion]?) -> Void) {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=5&type=multiple") else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  error == nil else {
                print("Network error: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(TriviaQuestionResponse.self, from: data)
                completion(decodedResponse.results)
            } catch {
                print("Decoding error: \(error)")
                completion(nil)
            }
        }

        task.resume()
    }
}
