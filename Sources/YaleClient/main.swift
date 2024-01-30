import Yale
import Foundation

struct User {
  var name: String
  var age: Int
}

struct Account: CustomStringConvertible {
  var email: String
  var user: User

  var description: String {
    "Account: \(email) \(user.name)"
  }
}

let integer = 13
let double = Double.pi
let string = "Hello World"
let user1: User? = User(name: "John Doe", age: 23)
let user2: User? = nil
let account = Account(email: "john.doe@example.com", user: user1!)

let assd: Yale.Message = "\(integer) \(double) \(string) \(user1) \(user2) \(account)"

print(assd)

Yale.bootstrap([.textStream(level: .trace)])

Yale.trace(assd, category: .default)
Yale.debug(assd, category: .default)
Yale.info(assd, category: .app)
Yale.notice(assd, category: .app)
Yale.warning(assd, category: .app)
Yale.error(assd, category: .app)
Yale.critical(assd, category: .app)

#logTrace("User logged in")
_ = readLine()
