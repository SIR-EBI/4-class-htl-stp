package primeFinder;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

import static java.time.Duration.ofMillis;
import static java.time.Duration.ofSeconds;
import static org.assertj.core.api.Assertions.assertThat;
import static org.awaitility.Awaitility.await;

class PrimeFinderTest {

    @ParameterizedTest
    @ValueSource(longs = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47})
    void isPrimeWithDelay_primeNoDelay_outputIsPrime(long candidate) {
        PrimeFinder finder = new PrimeFinder();
        PrimeChecker checker = new PrimeChecker(candidate, finder);

        assertThat(checker.isPrimeWithDelay()).isTrue();
    }

    @ParameterizedTest
    @ValueSource(longs = {-1, 0, 1, 4, 6, 9, 15})
    void isPrimeWithDelay_notPrime_false(long candidate) {
        PrimeFinder finder = new PrimeFinder();
        PrimeChecker checker = new PrimeChecker(candidate, finder);

        assertThat(checker.isPrimeWithDelay()).isFalse();
    }

    @Test
    void isPrimeWithDelay_withDelay_processTakesTime() {
        PrimeFinder finder = new PrimeFinder(15);
        PrimeChecker checker = new PrimeChecker(37, finder);
        boolean[] result = new boolean[1];

        new Thread(() -> result[0] = checker.isPrimeWithDelay()).start();

        await().atLeast(ofMillis(150))
                .atMost(ofSeconds(2))
                .untilAsserted(() ->
                        assertThat(result[0]).isTrue());
    }

    @Test
    void run_primesAdded() {
        PrimeFinder finder = new PrimeFinder(0, 0, 20);

        finder.findPrimes();

        await().atMost(ofSeconds(1))
                .untilAsserted(() ->
                        assertThat(finder.getPrimes()).containsExactly(2L, 3L, 5L, 7L, 11L, 13L, 17L, 19L));
    }

    @Test
    void working_threadCountCorrect() {
        PrimeFinder finder = new PrimeFinder(20, 37, 38);

        finder.findPrimes();

        await().pollDelay(ofMillis(20))
                .atMost(ofSeconds(1))
                .untilAsserted(() ->
                        assertThat(finder.countRunningCheckers()).isGreaterThan(0));
    }

    @Test
    void workDone_noRunningThreads() {
        PrimeFinder finder = new PrimeFinder(0, 0, 10_000);

        new Thread(finder::findPrimes).start();
        await().atMost(ofSeconds(10))
                .until(() -> allPrimesFound(finder));

        assertThat(finder.countRunningCheckers()).isZero();
    }

    private boolean allPrimesFound(PrimeFinder finder) {
        return finder.getPrimes().count() == 1229;
    }
}