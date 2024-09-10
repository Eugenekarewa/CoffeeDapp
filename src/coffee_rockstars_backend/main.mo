import Text "mo:base/Text";
import Map "mo:base/HashMap";

actor UserRegistry {

  // A HashMap to store users by name and assign each a unique ID (Nat)
  let userMap = Map.HashMap<Text, Nat>(10, Text.equal, Text.hash);
  var nextUserId : Nat = 0;  // To assign unique IDs incrementally

  // Public function to register a user
  public func registerUser(name : Text) : async ?Nat {
    // Check if the user is already registered
    switch (userMap.get(name)) {
      case (null) {
        // User not found, register the user with a unique ID
        let userId = nextUserId;
        userMap.put(name, userId);
        nextUserId += 1;  // Increment the user ID counter
        return ?userId;  // Return the new user ID
      };
      case (?existingId) {
        // User is already registered, return their existing ID
        return ?existingId;
      };
    }
  };

  // Public function to look up a user's ID by name
  public func lookupUser(name : Text) : async ?Nat {
    return userMap.get(name);  // Return the user ID if found, or null
  };

  // Public function to get the total number of registered users
  public func getTotalUsers() : async Nat {
    return userMap.size();
  };
}
