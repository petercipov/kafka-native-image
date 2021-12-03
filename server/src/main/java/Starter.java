import org.apache.kafka.common.utils.Exit;
import sun.misc.Signal;
import java.util.List;
import kafka.Kafka;

public class Starter {

    private static final List<String> SIGNALS = List.of("TERM", "INT", "HUP");

    public static void main(String[] args) {
        SIGNALS.stream()
            .map(Signal::new)
            .forEach(signal -> Signal.handle(signal, Starter::exit));

        System.getProperties().list(System.out);
        Kafka.main(args);
    }

    private static void exit(Signal signal) {
        System.out.println("Received signal, "+signal+" exiting");
        Exit.exit(0);
    }
}
