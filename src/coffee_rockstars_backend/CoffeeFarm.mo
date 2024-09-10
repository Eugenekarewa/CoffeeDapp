import Text "mo:base/Text";
import Map "mo:base/HashMap";

actor CoffeeFarm {
  // Coffee Farm details
  type Farm = {
    location: Text;
    certifications: [Text];
    coffeeBatches: [Text]; // IDs of CoffeeBean canisters representing batches
  };

  let farms = Map.HashMap<Text, Farm>(10, Text.equal, Text.hash); // Map farm ID to Farm details

  // Register a new farm
  public func registerFarm(farmId: Text, location: Text, certifications: [Text]) : async () {
    let newFarm: Farm = { location; certifications; coffeeBatches = [] };
    farms.put(farmId, newFarm);
  };

  // Add a new coffee batch to a farm
  public func addCoffeeBatch(farmId: Text, batchId: Text) : async () {
    switch (farms.get(farmId)) {
      case (?farm) {
        let updatedFarm = { location = farm.location; certifications = farm.certifications; coffeeBatches = batchId # farm.coffeeBatches };
        farms.put(farmId, updatedFarm);
      };
      case null {};
    }
  };

  // Get farm details
  public func getFarm(farmId: Text) : async ?Farm {
    return farms.get(farmId);
  };
};
