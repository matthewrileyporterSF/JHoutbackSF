public class ContactLocator {
    public class LocationDetails {
        @InvocableVariable(required=true)
        public Decimal miles;
        
        @InvocableVariable(required=true)
        public Decimal latitude;
        
        @InvocableVariable(required=true)
        public Decimal longitude;
    }
    
    @InvocableMethod(label='Find Nearby Contacts' description='Returns a list of contacts within a specified distance from a given location.')
    public static List<List<Contact>> findNearbyContacts(List<LocationDetails> locations) {
        List<List<Contact>> contactsToReturn = new List<List<Contact>>();
        for(LocationDetails location : locations) {
            String query = 'SELECT Id, Name, MailingAddress, MailingLatitude, MailingLongitude FROM Contact WHERE DISTANCE(MailingAddress, GEOLOCATION(' + 
                           String.valueOf(location.latitude) + ',' + String.valueOf(location.longitude) + '), \'mi\') < ' + 
                           String.valueOf(location.miles);
            List<Contact> contacts = Database.query(query);
            contactsToReturn.add(contacts);
        }
        return contactsToReturn;
    }
}