package primeFinder;

public class PrimeChecker implements Runnable {

    private final long candidate;
    private final PrimeFinder finder;

    public PrimeChecker(long candidate, PrimeFinder finder) {
        this.candidate = candidate;
        this.finder = finder;
    }

    @Override
    public void run() {
        if (isPrimeWithDelay()) {
            finder.addPrime(this.candidate);
        }
    }

    public boolean isPrimeWithDelay() {
        if (candidate < 2) {
            return false;
        }

        for (int i = 2; i < candidate; i++) {
            trySleep(finder.getDelay());
            if (candidate % i == 0) {
                return false;
            }
        }
        return true;
    }

    public void trySleep(int ms) {
        try {
            Thread.sleep(ms);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }

}
