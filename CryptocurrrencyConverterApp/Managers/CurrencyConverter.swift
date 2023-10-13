//
//  CurrencyConverter.swift
//  CryptocurrrencyConverterApp
//
//  Created by Clem OJ on 12/10/2023.
//

import Foundation

class CurrencyConverter {
    
    private let apiKey = "Your API Key"
    
    func getExchangeRate(currency: String, crypto: String,  completion: @escaping (String) -> Void){
        guard let url = URL(string: "https://rest.coinapi.io/v1/exchangerate/\(crypto)/\(currency)?apikey=\(apiKey)") else {
            completion("Failure to create URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion("Failure to get data")
                return
            }
            
            do{
                let response = try JSONDecoder().decode(CoinData.self, from: data)
                let rate = response.rate
                let rateString = String(format: "%.2f", rate)
                completion(rateString)
            }
            catch{
                completion("Failure to convert data")
            }
        }.resume()
    }
}

struct CoinData: Decodable {
    let rate: Double
}
