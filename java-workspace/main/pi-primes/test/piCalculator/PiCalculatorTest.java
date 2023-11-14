package piCalculator;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

import static org.assertj.core.api.Assertions.*;

class PiCalculatorTest {

    @Test
    void calcPiWithNThreads_threadCountSmallerThan1_exception() {
        assertThatThrownBy(() -> PiCalculator.calcPiWithNThreads(1, 0));
    }

    @ParameterizedTest
    @ValueSource(ints = {1, 2, 4, 8, 7})
    void calcPiWithNThreads_threadCountValid_returnsAlmostPi(int threads) throws InterruptedException {
        double pi = PiCalculator.calcPiWithNThreads(99_999, threads);

        assertThat(pi).isCloseTo(3.14158265358971, within(1e-13));
    }
}