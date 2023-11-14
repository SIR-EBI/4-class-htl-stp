package domain;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.NullAndEmptySource;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

class CourseTypeTest {

    @ParameterizedTest
    @NullAndEmptySource
    void construction_fails_without_description(String description) {
        assertThatThrownBy(() -> new CourseType('X', description));
    }

    @Test
    void correctly_identified_by_id() {
        var type1 = new CourseType('X', "description");
        var type2 = new CourseType('X', "other description");

        assertThat(type1).hasSameHashCodeAs(type2);
        assertThat(type1).isEqualTo(type2);
    }
}