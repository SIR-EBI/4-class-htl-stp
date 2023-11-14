create table professors
(
    professor_id identity not null,
    last_name  varchar(255) not null,
    first_name varchar(255) not null,
    constraint professor_pk primary key (professor_id)
);

create table course_types
(
    type_id     character(1),
    description varchar(100) not null,
    constraint course_types_pk primary key (type_id)
);

create table courses
(
    course_id identity not null,
    type_id      character(1) not null,
    professor_id integer not null,
    description  varchar(100) not null,
    begin_date   date not null,
    constraint courses_pk primary key (course_id),
    constraint courses_professors_fk foreign key (professor_id)
        references professors (professor_id),
    constraint courses__course_types__fk foreign key (type_id)
        references course_types (type_id)
);

create table students
(
    student_id identity not null,
    last_name  varchar(255) not null,
    first_name varchar(255) not null,
    constraint students_pk primary key (student_id)
);

create table courses_students
(
    course_id   integer not null,
    student_id integer not null,
    constraint courses_students_pkey primary key (student_id, course_id),
    constraint courses_students__students_fk foreign key (student_id)
        references students (student_id) on delete cascade,
    constraint courses_students__courses_fk foreign key (course_id)
        references courses (course_id)
);