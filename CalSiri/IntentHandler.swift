import Intents

class IntentHandler: INExtension {}

extension IntentHandler: GetRecentEventsIntentHandling{
    
    func handle(intent: GetRecentEventsIntent, completion: @escaping(GetRecentEventsIntentResponse)->Void){
//        guard let amount = intent.currencyAmount?.amount?.doubleValue else{
//            completion(INRequestPaymentIntentResponse(code: .failure, userActivity: nil))
//            return
//        }
//        number = amount
        let response : GetRecentEventsIntentResponse
//        let userActivity = NSUserActivity(activityType: NSStringFromClass(GetRecentEventsIntent.self))
//        response.userActivity = user
//        print(number)
//        response = ReceiveSuccessIntentResponse(code: .success, userActivity: userActivity)
//        completion(INRequestPaymentIntentResponse(code: .success, userActivity: nil))
        let detail = GetRecentEventsDetail()
        
        response = GetRecentEventsIntentResponse.success(detail: detail)
        print(detail)
        completion(response)
    }
}
