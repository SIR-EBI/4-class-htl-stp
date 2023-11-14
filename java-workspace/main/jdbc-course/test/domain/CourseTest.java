package domain;

import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.NullAndEmptySource;

import java.time.LocalDate;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

class CourseTest {

    @Test
    void correctly_identified_by_id() {
        var type = new CourseType('X', "description");
        var professor = new Professor("lastName", "firstName");
        var begin = LocalDate.of(2300, 1, 1);
        var course1 = new Course(1, type, professor, "description", begin);
        var course2 = new Course(1, type, professor, "description", begin);


        assertThat(course1).hasSameHashCodeAs(course2);
        assertThat(course1).isEqualTo(course2);
    }

    @Nested
    class Construction {

        @Test
        void fails_without_type() {
            var professor = new Professor("lastName", "firstName");
            var begin = LocalDate.of(2300, 1, 1);

            assertThatThrownBy(() -> new Course(null, professor, "description", begin));
        }

        @Test
        void fails_without_professor() {
            var type = new CourseType('X', "description");
            var begin = LocalDate.of(2300, 1, 1);

            assertThatThrownBy(() -> new Course(type, null, "description", begin));
        }

        @ParameterizedTest
        @NullAndEmptySource
        void fails_without_description(String description) {
            var type = new CourseType('X', "description");
            var professor = new Professor("lastName", "firstName");
            var begin = LocalDate.of(2300, 1, 1);

            assertThatThrownBy(() -> new Course(type, professor, description, begin));
        }

        @Test
        void fails_without_begin() {
            var type = new CourseType('X', "description");
            var professor = new Professor("lastName", "firstName");

            assertThatThrownBy(() -> new Course(type, professor, "description", null));
        }
    }
}