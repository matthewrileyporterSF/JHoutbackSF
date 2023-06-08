public class AccountLocator {
    public class LocationDetails {
        @InvocableVariable(required=true)
        public Decimal miles;
        
        @InvocableVariable(required=true)
        public Decimal latitude;
        
        @InvocableVariable(required=true)
        public Decimal longitude;
    }
    
    @InvocableMethod(label='Find Nearby Accounts' description='Returns a list of Accounts within a specified distance from a given location.')
    public static List<List<Account>> findNearbyAccounts(List<LocationDetails> locations) {
        List<List<Account>> accountsToReturn = new List<List<Account>>();
        for(LocationDetails location : locations) {
            String query = 'SELECT Id, Name, BillingAddress, BillingLatitude, BillingLongitude FROM Account WHERE DISTANCE(BillingAddress, GEOLOCATION(' + 
                           String.valueOf(location.latitude) + ',' + String.valueOf(location.longitude) + '), \'mi\') < ' + 
                           String.valueOf(location.miles);
            List<Account> accounts = Database.query(query);
            accountsToReturn.add(accounts);
        }
        return accountsToReturn;
    }
}