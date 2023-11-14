package persistence;

import domain.Student;
import org.junit.jupiter.api.*;
import persistence.setup.TestConnectionSupplier;

import java.sql.Connection;
import java.sql.SQLException;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

public class JdbcStudentRepositoryTest {

    private final TestConnectionSupplier connectionSupplier = new TestConnectionSupplier();
    private StudentRepository studentRepository;
    private Connection connection;

    @BeforeEach
    void createRepository() throws SQLException {
        connection = connectionSupplier.getConnection();
        studentRepository = new JdbcStudentRepository(connection);
    }

    @AfterEach
    void closeConnection() throws SQLException {
        connection.close();
    }


    @Test
    void finds_all() throws SQLException {
        var students = studentRepository.findAll();

        assertThat(students)
                .extracting(Student::getId)
                .containsExactlyInAnyOrder(1, 2, 3, 4, 5, 6);
    }

    @Nested
    class Saving {

        @Test
        void works() throws SQLException {
            var student = new Student("lastName", "firstName");

            var saved = studentRepository.save(student);

            var assignedId = saved.getId();
            assertThat(assignedId)
                    .isNotNull();
            assertThat(studentRepository.findById(assignedId))
                    .get()
                    .extracting(Student::getLastName)
                    .isEqualTo("lastName");
        }

        @Test
        void fails_if_student_has_id() {
            var student = new Student(42, "lastName", "firstName");

            assertThatThrownBy(() -> studentRepository.save(student));
        }
    }

    @Nested
    class Deleting {

        @Test
        void existing_without_assigned_course() throws SQLException {
            var student = new Student(2, "lastName", "firstName");
            studentRepository.delete(student);

            assertThat(studentRepository.findById(2))
                    .isEmpty();
        }

        @Test
        void existing_with_assigned_courses_unsubscribes_courses() throws SQLException {
            var student = new Student(4, "lastName", "firstName");
            studentRepository.delete(student);

            assertThat(studentRepository.findById(4))
                    .isEmpty();

            var courseRepository = new JdbcCourseRepository(connection);

            assertThat(courseRepository.findAllByStudent(student))
                    .isEmpty();
        }

        @Test
        void fails_without_id() {
            var student = new Student(null, "lastName", "firstName");

            assertThatThrownBy(() -> studentRepository.delete(student));
        }
    }

    @Nested
    class Updating {

        @Test
        void works() throws SQLException {
            //TODO
        }

        @Test
        void fails_for_unpersisted_student() {
            var student = new Student(200, "lastName", "firstName");

            assertThatThrownBy(() -> studentRepository.update(student));
        }

        @Test
        void fails_without_id() {
            var student = new Student(null, "lastName", "firstName");

            assertThatThrownBy(() -> studentRepository.update(student));
        }
    }

    @Nested
    class Finding {

        @Test
        void existing_works() throws SQLException {
            var optionalStudent = studentRepository.findById(1);

            assertThat(optionalStudent)
                    .get()
                    .extracting(Student::getId)
                    .isEqualTo(1);
        }

        @Test
        void unknown_returns_empty_optional() throws SQLException {
            var optionalStudent = studentRepository.findById(404);

            assertThat(optionalStudent).isEmpty();
        }
    }
}
