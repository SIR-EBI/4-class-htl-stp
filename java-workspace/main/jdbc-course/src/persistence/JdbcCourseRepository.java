package persistence;

import domain.*;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public record JdbcCourseRepository(Connection connection) implements CourseRepository {

    @Override
    public List<Course> findAll() throws SQLException {
        List<Course> courseList = new ArrayList<>();
        String sql = """
                SELECT course_id, type_id, professor_id, description, begin_date
                FROM courses
                """;
        try (var statement = connection.prepareStatement(sql)) {
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                courseList.add(
                        new Course(
                                resultSet.getInt("course_id"),
                                findCourseTypes(resultSet.getString("type_id").charAt(0)),
                                new JdbcProfessorRepository(connection).findById(resultSet.getInt("professor_id")).get(),
                                resultSet.getString("description"),
                                resultSet.getDate("begin_date").toLocalDate()
                        )
                );
            }
            return courseList;
        }
    }

    @Override
    public List<Course> findAllByProfessor(Professor professor) throws SQLException {
        return null;
    }

    private CourseType findCourseTypes(char id) throws SQLException {
        String sql = """
                SELECT type_id, description
                FROM course_types
                WHERE type_id = ?
                """;
        try (var statement = connection.prepareStatement(sql)) {
            statement.setString(1, ""+id);

            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return new CourseType(
                        resultSet.getString(1).charAt(0),
                        resultSet.getString(2)
                );
            }
            else {
                throw new SQLException("CourseType not found");
            }
        }
    }

    @Override
    public Optional<Course> findById(int id) throws SQLException {
        String sql = """
                SELECT course_id, type_id, professor_id, description, begin_date
                FROM courses
                WHERE course_id = ?
                """;
        try (var statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);

            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return Optional.of(new Course(
                        resultSet.getInt("course_id"),
                        findCourseTypes(resultSet.getString("type_id").charAt(0)),
                        new JdbcProfessorRepository(connection).findById(resultSet.getInt("professor_id")).get(),
                        resultSet.getString("description"),
                        resultSet.getDate("begin_date").toLocalDate()
                ));
            }
            else {
                return Optional.empty();
            }
        }
    }

    @Override
    public Course save(Course course) throws SQLException {
        String sql = """
                INSERT INTO courses (type_id, professor_id, description, begin_date)
                VALUES (?,?,?,?)
                """;
        try (var statement = connection.prepareStatement(sql)) {
            statement.setString(1, ""+course.getType().getId());
            statement.setInt(2, course.getProfessor().getId());
            statement.setString(3, course.getDescription());
            statement.setDate(4, new Date(course.getBegin().getYear(), course.getBegin().getMonthValue(), course.getBegin().getDayOfMonth()));
            statement.executeUpdate();

            ResultSet generatedKeys = statement.getGeneratedKeys();
            if (generatedKeys.next()) {
                return new Course(
                        generatedKeys.getInt("course_id"),
                        course.getType(),
                        course.getProfessor(),
                        course.getDescription(),
                        course.getBegin());
            }
            else {
                throw new IllegalArgumentException("Saving course failed");
            }

        }
    }

    @Override
    public List<Course> findAllByStudent(Student student) throws SQLException {
        List<Course> courseList = new ArrayList<>();

        String sql = """
                SELECT course_id
                FROM courses_students
                WHERE student_id = ?
                """;
        try (var statement = connection.prepareStatement(sql)) {
            statement.setInt(1, student.getId());

            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {

            }
        }

        return null;
    }

    @Override
    public void enrollInCourse(Student student, Course course) throws SQLException {

    }

    @Override
    public void unenrollFromCourse(Student student, Course course) throws SQLException {

    }

}
