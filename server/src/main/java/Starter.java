import kafka.Kafka;

public class Starter {
    public static void main(String[] args) {
        java.security.Security.setProperty("networkaddress.cache.ttl" , "0");
        java.security.Security.setProperty("networkaddress.cache.negative.ttl" , "0");

        System.getProperties().list(System.out);
        Kafka.main(args);
    }
}
