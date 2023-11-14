package primeFinder;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Vector;
import java.util.stream.Stream;

public class PrimeFinder {

    private Collection<Long> primes = new Vector<>();
    private Collection<Thread> threadList = new ArrayList<>();
    private int delay;
    private int from;
    private int to;

    public PrimeFinder() {
        this.delay = 0;
    }

    public PrimeFinder(int delay) {
        this.delay = delay;
    }

    public PrimeFinder(int delay, int from, int to) {
        this.delay = delay;
        this.from = from;
        this.to = to;
    }

    public int countRunningCheckers() {
        int count = 0;
        for (Thread thread : threadList) {
            if (thread.isAlive()) {
                count++;
            }
        }
        return count;
    }

    /**
     * Teilt alle Zahlen in [from, to[ auf Threads auf,
     * welche die Primalität der jeweiligen Zahl bestimmen
     */
    public void findPrimes() {
        for (int i = from; i <= to; i++) {
            Thread finder = new Thread(new PrimeChecker(i, this));
            threadList.add(finder);
            finder.start();
        }
    }

    public Stream<Long> getPrimes() {
        return primes.stream();
    }

    public void soutPrimes() {
        System.out.println(primes);
    }

    public void addPrime(long prime) {
        primes.add(prime);
    }

    public int getDelay() {
        return delay;
    }

    public static void main(String[] args) {
        PrimeFinder primeFinder = new PrimeFinder(10, 0, 100);

        primeFinder.findPrimes();

        Thread monitor = new Thread(() -> {
            while (Thread.activeCount() > 2) {
                try {
                    Thread.sleep(500);
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
                System.out.println("Active Checkers: " + primeFinder.countRunningCheckers());
                primeFinder.soutPrimes();
            }
            System.out.println("---------------------");
            System.out.println(primeFinder.getPrimes());
        });
        monitor.setDaemon(true);
        monitor.start();
    }
    
}
