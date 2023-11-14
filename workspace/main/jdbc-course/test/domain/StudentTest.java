package domain;

import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.NullAndEmptySource;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

public class StudentTest {

    @Test
    void correctly_identified_by_id() {
        var student1 = new Student(1, "lastName", "firstName");
        var student2 = new Student(1, "lastName", "firstName");

        assertThat(student1).hasSameHashCodeAs(student2);
        assertThat(student1).isEqualTo(student2);
    }

    @Nested
    class Construction {

        @ParameterizedTest
        @NullAndEmptySource
        void fails_without_lastname(String lastName) {
            assertThatThrownBy(() -> new Student(lastName, "firstName"));
        }

        @ParameterizedTest
        @NullAndEmptySource
        void fails_without_firstname(String firstName) {
            assertThatThrownBy(() -> new Student("lastName", firstName));
        }
    }
}
