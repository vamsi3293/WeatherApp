
import Foundation
enum HTTPHeaderFields {
	case application_json
	case application_x_www_form_urlencoded
	case none
}

struct APIErrorDescription{
   static let invalidUrl =  "Invalid Url Passed"
	static let httpError =  "HTTP request failed"
	static let noData =  "Data Not Found"
	static let JsonParseError =  "Error: While parsing JSON"
	
}
struct APIUrl{
	static let baseUrl = "https://api.weatherapi.com/v1/forecast.json?key=\(NetworkConstants.ApiToken)&q=\(NetworkConstants.location)&days=7&aqi=no&alerts=no"

}
struct NetworkConstants{
	
	static let contentType = "Content-Type"
	static let AcceptType = "Accept"
	static let requestJson = "application/json"
	static let requestUrlEncoded = "application/x-www-form-urlencoded"
	static let ApiToken = "e57752053dfb452a99a63035222009"
	static let location = "chennai"
}

class HttpClient{
	//type, url, param, options, callback, retryTime, suppressSession, securityManager,
	func GET(url:String,params:Data?,options:[String:String]?,complete: @escaping (Bool, Data?) -> ()){
		send(type: "GET", url: url, params: params, httpHeader: .application_json, options: options) { isSuccess, data in
			if(isSuccess){
				complete(true,data)
			}else{
				complete(false,data)
			}
		}
	}
	func POST(url:String,params:Data?,options:[String:String]?,complete: @escaping (Bool, Data?) -> ()){
		send(type: "POST", url: url, params: params, httpHeader: .application_json, options: options) { isSuccess, data in
			if(isSuccess){
				complete(true,data)
			}else{
				complete(false,data)
			}
		}
	}
	func send(type:String,url:String,params:Data?,httpHeader: HTTPHeaderFields,options:[String:String]?,complete: @escaping (Bool, Data?) -> ()){
		guard let url = URL(string: APIUrl.baseUrl) else {
			self.onError(error:APIErrorDescription.invalidUrl )
			return
		}
		var request = URLRequest(url: url)
		request.httpMethod = type
		switch httpHeader {
		case .application_json:
				request.setValue(NetworkConstants.requestJson, forHTTPHeaderField: NetworkConstants.contentType)
				request.setValue(NetworkConstants.requestJson, forHTTPHeaderField: NetworkConstants.AcceptType)
		case .application_x_www_form_urlencoded:
				request.setValue(NetworkConstants.requestUrlEncoded, forHTTPHeaderField: NetworkConstants.contentType)
		case .none: break
		}
		if let params = params{
			request.httpBody = params
		}
		
		let config = URLSessionConfiguration.default
		let session = URLSession(configuration: config)
		
		session.dataTask(with: request) { data, response, error in
			guard error == nil else {
				self.onError(error: String(describing: error))
				return
			}
			guard let data = data else {
				self.onError(error: APIErrorDescription.noData)
				return
			}
			guard let response1 = response as? HTTPURLResponse, (200 ..< 300) ~= response1.statusCode else {
				self.onError(error: APIErrorDescription.httpError)
				return
			}
			
			complete(true, data)
		}.resume()
		
	}
	
	func onError(error:String){
		
		GLOBAL.sharedInstance.showAlert(title: "Error", message: error, completionHandler: nil)
	}
}

