package domain;

import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.NullAndEmptySource;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

public class ProfessorTest {

    @Test
    void correctly_identified_by_id() {
        var professor1 = new Professor(1, "lastName", "firstName");
        var professor2 = new Professor(1, "lastName", "firstName");

        assertThat(professor1).hasSameHashCodeAs(professor2);
        assertThat(professor1).isEqualTo(professor2);
    }

    @Nested
    class Construction {

        @ParameterizedTest
        @NullAndEmptySource
        void fails_without_lastname(String lastName) {
            assertThatThrownBy(() -> new Professor(lastName, "firstName"));
        }

        @ParameterizedTest
        @NullAndEmptySource
        void fails_without_firstname(String firstName) {
            assertThatThrownBy(() -> new Professor("lastName", firstName));
        }
    }
}
