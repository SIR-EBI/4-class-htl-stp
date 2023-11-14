package persistence;

import domain.Professor;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public record JdbcProfessorRepository(Connection connection) implements ProfessorRepository {

    @Override
    public List<Professor> findAll() throws SQLException {
        List<Professor> professorList = new ArrayList<>();
        String sql = """
                SELECT professor_id, last_name, first_name
                FROM professors
                """;
        try (var statement = connection.prepareStatement(sql)) {
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                professorList.add(
                        new Professor(
                                resultSet.getInt("professor_id"),
                                resultSet.getString("last_name"),
                                resultSet.getString("first_name")
                        ));
            }
            return professorList;
        }
    }

    @Override
    public Optional<Professor> findById(int id) throws SQLException {
        String sql = """
                SELECT  professor_id, last_name, first_name
                FROM professors
                WHERE professor_id = ?
                """;
        try (var statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);

            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return Optional.of(new Professor(
                        resultSet.getInt("professor_id"),
                        resultSet.getString("last_name"),
                        resultSet.getString("first_name")
                ));
            }
        }
        return Optional.empty();
    }

    @Override
    public Professor save(Professor professor) throws SQLException {
        if (professor.getId() != null) {
            throw new SQLException("saving professor failed");
        }

        String sql = """
                INSERT INTO professors (last_name, first_name)
                VALUES (?,?)
                """;
        try (var statement = connection.prepareStatement(sql,
                Statement.RETURN_GENERATED_KEYS)) {
            statement.setString(1, professor.getLastName());
            statement.setString(2, professor.getFirstName());
            statement.executeUpdate();

            ResultSet generatedKeys = statement.getGeneratedKeys();
            if (generatedKeys.next()) {
                return new Professor(
                        generatedKeys.getInt("professor_id"),
                        professor.getLastName(),
                        professor.getFirstName()
                );
            }
            else {
                throw new SQLException("Saving professor failed");
            }

        }
    }

    @Override
    public void delete(Professor professor) throws SQLException {
        String sql = """
                DELETE FROM professors
                WHERE professor_id = ?
                """;
        try (var statement = connection.prepareStatement(sql)) {
            statement.setInt(1, professor.getId());
            statement.executeUpdate();
        }
    }

}
