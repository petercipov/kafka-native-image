import kafka.Kafka;

public class Starter {
    public static void main(String[] args) {
        System.getProperties().list(System.out);
        Kafka.main(args);
    }
}
