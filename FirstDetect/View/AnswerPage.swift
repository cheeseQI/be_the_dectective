//
//  AnswerPage.swift
//  FirstDetect
//
//  Created by oliver xu on 3/26/23.
//

import SwiftUI

struct AnswerPage: View {
    let script: Script
    @State private var messageText: String = ""
    @State private var showSelectView = false
    @State private var reply = ""
    @State private var showProgress = false
    let urlsring = "http://vcm-30653.vm.duke.edu:8080/game/check_target"
    var body: some View {
        VStack{
            ScrollView {
                Text("Your Mission")
                    .font(.title)
                    .fontWeight(.bold)
                ScrollView {
                    Text(script.target)
                        .padding()
                }
                Text("Background")
                    .font(.title)
                    .fontWeight(.bold)
                ScrollView {
                    Text(script.background)
                        .padding()
                }
                Spacer()
                    .frame(height: 10.0)
                HStack {
                    TextField("enter your answer", text: $messageText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading)
                    
                    Button(action: {
                        showProgress = true
                        sendMessage()
                    }) {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 24))
                            .padding(.trailing)
                    }
                }.padding()
                
                
                
                if showProgress {
                    ProgressView()
                        .padding()
                } else {
                    Text(reply)
                        .padding()
                }
                
                Spacer()
                
                Button(action: {
                    self.showSelectView = true
                }, label: {
                    Text("End Game")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 330.0)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                })
            }
            .fullScreenCover(isPresented: $showSelectView, content: {
                SelectScriptView()
            })
        }
    }
    func sendMessage() {
        if !messageText.trimmingCharacters(in: .whitespaces).isEmpty {
            _ = Message(text: messageText, isSentByCurrentUser: true)
            let decoder = JSONDecoder()
            postAnswer(ans: messageText){ result in
                switch result {
                case .success(let data):
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Encoded JSON:\n\(jsonString)")
                        do {
                            let res = try decoder.decode([String: String].self, from: data)
                            if let messageContent = res["content"] {
                                DispatchQueue.main.async {
                                    reply = messageContent
                                    showProgress = false
                                }
                            }
                        } catch {
                            print("Error decoding JSON data: \(error)")
                        }
                    }
                    print("Chat object successfully posted. Server response: \(data)")
                case .failure(let error):
                    print("Error posting chat object: \(error.localizedDescription)")
                }
            }
            messageText = ""
        }
    }
    
    func postAnswer(ans: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: urlsring)
        let encoder = JSONEncoder()
        let postMessage = ["uuid": GameInfo.id, "answer": ans]
        do {
            let ansData = try encoder.encode(postMessage)
            if let jsonString = String(data: ansData, encoding: .utf8) {
                print("Encoded JSON:\n\(jsonString)")
            }
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = ansData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                    completion(.failure(error))
                    return
                }
                completion(.success(data))
            }
            task.resume()
            
        } catch let error {
            completion(.failure(error))
        }
    }
}

struct AnswerPage_Previews: PreviewProvider {
    static var previews: some View {
        AnswerPage(script: Script(title: "Mumu", author: "Miumiu"))
    }
}
