package persistence;

import domain.*;
import org.junit.jupiter.api.*;
import persistence.setup.TestConnectionSupplier;

import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

public class JdbcCourseRepositoryTest {

    private final TestConnectionSupplier connectionSupplier = new TestConnectionSupplier();
    private CourseRepository courseRepository;
    private Connection connection;

    @BeforeEach
    void createRepository() throws SQLException {
        connection = connectionSupplier.getConnection();
        courseRepository = new JdbcCourseRepository(connection);
    }

    @AfterEach
    void closeConnection() throws SQLException {
        connection.close();
    }

    @Test
    void finds_all() throws SQLException {
        var courses = courseRepository.findAll();

        assertThat(courses)
                .extracting(Course::getId)
                .containsExactlyInAnyOrder(1, 2, 3, 4, 5, 6);
    }

    @Nested
    class FindingAllByProfessor {

        @Test
        void works() throws SQLException {
            var professor = new Professor(4, "lastName", "firstName");

            var courses = courseRepository.findAllByProfessor(professor);

            assertThat(courses)
                    .extracting(Course::getDescription)
                    .containsExactlyInAnyOrder("HTML", "Servlets");
        }

        @Test
        void fails_without_id() throws SQLException {
            var professor = new Professor(null, "lastName", "firstName");

            assertThatThrownBy(() -> courseRepository.findAllByProfessor(professor));
        }
    }

    @Nested
    class FindingAllByStudent {
        //TODO
    }

    @Nested
    class Unenrolling {

        @Test
        void works() throws SQLException {
            var student = new Student(1, "lastName", "firstName");
            var unaffectedStudent = new Student(5, "lastName", "firstName");
            var course = courseRepository.findById(3)
                    .orElseThrow();

            courseRepository.unenrollFromCourse(student, course);
            assertThat(courseRepository.findAllByStudent(student))
                    .extracting(Course::getId)
                    .doesNotContain(3);
            assertThat(courseRepository.findAllByStudent(unaffectedStudent))
                    .extracting(Course::getId)
                    .contains(3);
        }

        @Test
        void fails_if_not_enrolled() throws SQLException {
            var student = new Student(1, "lastName", "firstName");
            var course = courseRepository.findById(1)
                    .orElseThrow();

            assertThatThrownBy(() -> courseRepository.unenrollFromCourse(student, course));
        }

        @Test
        void fails_without_student_id() throws SQLException {
            var student = new Student(null, "lastName", "firstName");
            var professor = new Professor(4, "lastName", "firstName");
            var type = new CourseType('P', "Programming");
            var beginning = LocalDate.of(2038, 1, 20);
            var course = new Course(type, professor, "description", beginning);

            assertThatThrownBy(() -> courseRepository.unenrollFromCourse(student, course));
        }

        @Test
        void fails_without_course_id() throws SQLException {
            var student = new Student(10, "lastName", "firstName");
            var professor = new Professor(4, "lastName", "firstName");
            var type = new CourseType('P', "Programming");
            var beginning = LocalDate.of(2038, 1, 20);
            var course = new Course(null, type, professor, "description", beginning);

            assertThatThrownBy(() -> courseRepository.unenrollFromCourse(student, course));
        }
    }

    @Nested
    class Enrolling {

        @Test
        void works() throws SQLException {
            //TODO
        }

        @Test
        void fails_for_unpersisted_student() throws SQLException {
            var student = new Student(200, "lastName", "firstName");
            var course = courseRepository.findById(1)
                    .orElseThrow();

            assertThatThrownBy(() -> courseRepository.enrollInCourse(student, course));
        }

        @Test
        void fails_if_already_enrolled_in_same_course() throws SQLException {
            var student = new Student(1, "lastName", "firstName");
            var course = courseRepository.findById(3)
                    .orElseThrow();

            assertThatThrownBy(() -> courseRepository.enrollInCourse(student, course));
        }

        @Test
        void fails_without_student_id() throws SQLException {
            var student = new Student(null, "lastName", "firstName");
            var professor = new Professor(4, "lastName", "firstName");
            var type = new CourseType('P', "Programming");
            var beginning = LocalDate.of(2038, 1, 20);
            var course = new Course(type, professor, "description", beginning);

            assertThatThrownBy(() -> courseRepository.enrollInCourse(student, course));
        }

        @Test
        void fails_without_course_id() throws SQLException {
            var student = new Student(1, "lastName", "firstName");
            var professor = new Professor(4, "lastName", "firstName");
            var type = new CourseType('P', "Programming");
            var beginning = LocalDate.of(2038, 1, 20);
            var course = new Course(null, type, professor, "description", beginning);

            assertThatThrownBy(() -> courseRepository.enrollInCourse(student, course));
        }
    }

    @Nested
    class Finding {

        @Test
        void existing_works() throws SQLException {
            var optionalCourse = courseRepository.findById(1);

            assertThat(optionalCourse)
                    .get()
                    .hasNoNullFieldsOrProperties()
                    .extracting(Course::getId)
                    .isEqualTo(1);
        }

        @Test
        void unknown_returns_empty_optional() throws SQLException {
            var optionalCourse = courseRepository.findById(404);

            assertThat(optionalCourse)
                    .isEmpty();
        }
    }

    @Nested
    class Saving {

        @Test
        void works() throws SQLException {
            var professor = new Professor(4, "lastName", "firstName");
            var type = new CourseType('P', "Programming");
            var beginning = LocalDate.of(2038, 1, 20);
            var course = new Course(type, professor, "description", beginning);

            var saved = courseRepository.save(course);

            assertThat(saved.getId())
                    .isNotNull();
            assertThat(courseRepository.findById(saved.getId()))
                    .get()
                    .extracting(Course::getDescription)
                    .isEqualTo("description");
        }

        @Test
        void fails_if_course_has_id() {
            var professor = new Professor(4, "lastName", "firstName");
            var type = new CourseType('P', "Programming");
            var beginning = LocalDate.of(2038, 1, 20);
            var course = new Course(42, type, professor, "description", beginning);

            assertThatThrownBy(() -> courseRepository.save(course));
        }

        @Test
        void fails_if_begin_in_past() {
            var professor = new Professor(4, "lastName", "firstName");
            var type = new CourseType('P', "Programing");
            var beginningInPast = LocalDate.of(1970, 1, 1);
            var course = new Course(type, professor, "description", beginningInPast);

            assertThatThrownBy(() -> courseRepository.save(course));
        }
    }
}
