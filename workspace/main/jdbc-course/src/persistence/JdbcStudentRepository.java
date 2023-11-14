package persistence;

import domain.Student;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public record JdbcStudentRepository(Connection connection) implements StudentRepository {

    @Override
    public List<Student> findAll() throws SQLException {
        List<Student> studentList = new ArrayList<>();
        String sql = """
                SELECT student_id, last_name, first_name
                FROM students
                """;
        try (var statement = connection.prepareStatement(sql)) {
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                studentList.add(
                        new Student(
                                resultSet.getInt("student_id"),
                                resultSet.getString("last_name"),
                                resultSet.getString("first_name")
                        ));
            }
            return studentList;
        }
    }

    @Override
    public Optional<Student> findById(int id) throws SQLException {
        String sql = """
                SELECT student_id, last_name, first_name
                FROM students
                WHERE student_id = ?
                """;
        try (var statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);

            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return Optional.of(new Student(
                        resultSet.getInt("student_id"),
                        resultSet.getString("last_name"),
                        resultSet.getString("first_name")
                        ));
            }
            else {
                return Optional.empty();
            }
        }
    }

    @Override
    public Student save(Student student) throws SQLException {
        if (student.getId() != null) {
            throw new SQLException("saving student failed");
        }

        String sql = """
                INSERT INTO students (last_name, first_name)
                VALUES (?,?)
                """;
        try (var statement = connection.prepareStatement(sql,
                Statement.RETURN_GENERATED_KEYS)) {
            statement.setString(1, student.getLastName());
            statement.setString(2, student.getFirstName());
            statement.executeUpdate();

            ResultSet generatedKeys = statement.getGeneratedKeys();
            if (generatedKeys.next()) {
                return new Student(
                        generatedKeys.getInt("student_id"),
                        student.getLastName(),
                        student.getFirstName()
                );
            }
            else {
                throw new SQLException("Saving student failed");
            }
        }
    }

    @Override
    public void update(Student student) throws SQLException {
        Optional<Student> studentOptional = findById(student.getId());

        if (studentOptional.isEmpty()) {
            save(student);
        }
        else {
            Student studentFromOptional = studentOptional.get();
            String sql = """
                    UPDATE students
                    SET last_name = ?, first_name = ?
                    WHERE student_id = ?
                    """;
            try (var statement = connection.prepareStatement(sql)) {
                statement.setString(1, studentFromOptional.getLastName());
                statement.setString(2, studentFromOptional.getFirstName());
                statement.setInt(3, studentFromOptional.getId());
                statement.executeUpdate();
            }
        }
    }

    @Override
    public void delete(Student student) throws SQLException {
        String sql = """
                DELETE FROM students
                WHERE student_id = ?
                """;
        try (var statement = connection.prepareStatement(sql)) {
            statement.setInt(1, student.getId());
            statement.executeUpdate();
        }
    }

}
