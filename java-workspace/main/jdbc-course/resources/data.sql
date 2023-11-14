insert into professors (last_name, first_name)
values ('Leutner', 'Brigitte'),
       ('Gernhardt', 'Wolfgang'),
       ('Weizenbaum', 'Josephine'),
       ('Ludwig', 'Luigi'),
       ('Mergel', 'Boris'),
       ('Duffing', 'Julienne'),
       ('Meyer', 'Julius');

insert into course_types (type_id, description)
values ('P', 'Programming'),
       ('S', 'Scripting'),
       ('W', 'Webdev');

insert into courses (type_id, professor_id, description, begin_date)
values ('P', 2, 'OOP', '2010-08-27'),
       ('S', 3, 'JavaScript', '2010-06-29'),
       ('P', 2, 'JDBC', '2010-06-30'),
       ('W', 4, 'HTML', '2010-07-13'),
       ('P', 5, 'GUIs', '2010-10-09'),
       ('W', 4, 'Servlets', '2010-10-10');

insert into students (last_name, first_name)
values ('Bauer', 'Hannes'),
       ('Khan', 'Dschingis'),
       ('Schmidt', 'Lothar'),
       ('Kunze', 'Sieglinde'),
       ('Hintze', 'Franz'),
       ('Kaiser', 'Leo');

insert into courses_students (student_id, course_id)
values (6, 1),
       (3, 2),
       (3, 1),
       (4, 1),
       (5, 3),
       (5, 2),
       (1, 3),
       (4, 2);
