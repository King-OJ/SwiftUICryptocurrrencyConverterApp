//
//  ContentView.swift
//  CryptocurrrencyConverterApp
//
//  Created by Clem OJ on 12/10/2023.
//

import SwiftUI

struct ContentView: View {
    
    let currencyConverter = CurrencyConverter()
    
    @State private var selectedCurrency = "AUD"
    @State private var selectedCrypto = "BTC"
    @State private var rate = ""
    
    var currencies: [String] = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var cryptos = ["BTC", "ETH", "USDT", "ADA", "BNB", "DOGE", "XRP", "DOT", "UNI", "BCH", "LTC", "LINK", "USDC", "MATIC", "SOL", "THETA", "ICP", "WBTC", "VET", "FIL"]
    
    var body: some View {
        
        VStack(spacing: 15) {
            Text("What is the exchange rate between dollar and crypto currencies")
                .font(.system(size: 25))
                .multilineTextAlignment(.center)
            
            Text("$\(rate)")
                .font(.system(size: 30))
                .fontWeight(.bold)
       
            
            Divider()
                .frame(maxWidth: .infinity, maxHeight: 2)
                .background(.white)
                .padding(.vertical, 20)
            
            Text("Select Currency")
                .font(.title)
            Picker("", selection: $selectedCurrency) {
                ForEach(currencies, id: \.self) {currency in
                    Text(currency).tag(currency)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 120)
            
            Divider()
                .frame(maxWidth: .infinity, maxHeight: 2)
                .background(.white)
                .padding(.vertical, 20)
        
        
            Text("Select Crypto")
                .font(.title)
            Picker("", selection: $selectedCrypto) {
                ForEach(cryptos, id: \.self) {crypto in
                    Text(crypto).tag(crypto)
                }
                
            }
            .pickerStyle(.wheel)
            .frame(height: 120)
            
           Spacer()
            
            
           
        }
        .padding()
        .preferredColorScheme(.dark)
        
        .onChange(of: selectedCurrency) { _ in
            currencyConverter.getExchangeRate(currency: selectedCurrency, crypto: selectedCrypto) { rate in
                self.rate = rate
            }
        }
        .onChange(of: selectedCrypto) { _ in
            currencyConverter.getExchangeRate(currency: selectedCurrency, crypto: selectedCrypto) { rate in
                self.rate = rate
            }
        }
        .onAppear {
            currencyConverter.getExchangeRate(currency: selectedCurrency, crypto: selectedCrypto) { rate in
                self.rate = rate
            }
        }
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
