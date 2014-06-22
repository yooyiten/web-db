-- ******************************************************
-- syllabusDB.sql
--
-- Loader for Open Syllabus Project DB
--
-- Description:	This script contains the DDL to load
--              the tables of the OSP database
--
-- There are 7 tables in this DB
--
-- Template Author:  Maria R. Garcia
--
-- Student:  Yoora Yi Tenen
--
-- Modified:   December, 2012
--
-- ******************************************************

-- ******************************************************
--    SPOOL SESSION
-- ******************************************************

spool fp.lst

-- ******************************************************
--    DROP TABLES
-- Note:  Issue the appropiate commands to drop tables
-- ******************************************************

DROP table syllabus_tag purge;
DROP table syllabus purge;
DROP table course purge;
DROP table department purge;
DROP table university purge;
DROP table instructor purge;
DROP table tag purge;

-- ******************************************************
--    DROP SEQUENCES
-- Note:  Issue the appropiate commands to drop sequences
-- ******************************************************

DROP sequence seq_syllabus;
DROP sequence seq_course;
DROP sequence seq_department;
DROP sequence seq_university;
DROP sequence seq_instructor;
DROP sequence seq_tag;

-- ******************************************************
--    CREATE TABLES
-- ******************************************************

CREATE table tag (
    tag_id          number(7,0)                         not null
        constraint pk_tag primary key,
    tag_desc        varchar2(50)                        not null
);

CREATE table instructor (
    i_id            number(7,0)                         not null
        constraint pk_instructor primary key,
    title           varchar2(30)                        null,
    first_name      varchar2(30)                        not null,
    middle_name     varchar2(30)                        null,
    last_name       varchar2(30)                        not null,
    suffix          varchar2(30)                        null,
    phone           varchar2(20)                        null,
    email           varchar2(50)                        not null
);

CREATE table university (
    uni_id          number(7,0)                         not null
        constraint pk_uni primary key,
    uni_name        varchar2(50)                        not null,
    city            varchar2(30)                        not null,
    state           char(2)                             null,
    country         varchar2(30)                        not null
);

CREATE table department (
    dept_id         number(7,0)                         not null
        constraint pk_dept primary key,
    dept_name       varchar2(50)                        not null
);

CREATE table course (
    course_id       number(7,0)                         not null
        constraint pk_course primary key,
    uni_id          number(7,0)                         null
        constraint fk_uni_id_university references university(uni_id) on delete set null,
    dept_id         number(7,0)                         null
        constraint fk_dept_id_department references department(dept_id) on delete set null,
    course_code     varchar2(20)                        not null,
    course_name     varchar2(255)                       not null
);

CREATE table syllabus (
    syllabus_id     number(7,0)                         not null
        constraint pk_syllabus primary key,
    url             varchar2(255)                       not null,
    semester        char(10)                            not null,
    year            number(4,0)                         not null,
    course_id       number(7,0)                         null
        constraint fk_course_id_course references course(course_id) on delete set null,
    i_id            number(7,0)                         null
        constraint fk_i_id_instructor references instructor(i_id) on delete set null,    
    date_created    date    default to_date(sysdate, 'DD-MON-YYYY')     not null,
    date_modified   date    default to_date(sysdate, 'DD-MON-YYYY')     not null,
    student_count   number(3,0)     default 0                           not null
        constraint rg_student_count check (student_count >= 0)
);

CREATE table syllabus_tag (
    syllabus_id     number(7,0)                         not null
        constraint fk_syllabus_id_syllabus references syllabus(syllabus_id) on delete cascade,
    tag_id          number(7,0)                         not null
        constraint fk_tag_id_tag references tag(tag_id) on delete cascade,
        constraint pk_syllabus_tag primary key (syllabus_id, tag_id)
);

-- ******************************************************
--    CREATE SEQUENCES
-- ******************************************************

CREATE sequence seq_tag
    increment by 1
    start with 1
    minvalue 1
    maxvalue 9999999;
    
CREATE sequence seq_instructor
    increment by 1
    start with 1
    minvalue 1
    maxvalue 9999999;

CREATE sequence seq_university
    increment by 1
    start with 1
    minvalue 1
   maxvalue 9999999;    
    
CREATE sequence seq_department
    increment by 1
    start with 1
    minvalue 1
    maxvalue 9999999;
    
CREATE sequence seq_course
    increment by 1
    start with 1
    minvalue 1
    maxvalue 9999999;     
    
CREATE sequence seq_syllabus
    increment by 1
    start with 1
    minvalue 1
    maxvalue 9999999;

-- ******************************************************
--    CREATE TRIGGERS
-- ******************************************************

-- create trigger AUTO_INCREMENT_SYLLABUS

CREATE or REPLACE trigger AUTO_INCREMENT_SYLLABUS
before insert on syllabus
for each row
begin
  select seq_syllabus.nextval
  into :new.syllabus_id
  from dual;
end AUTO_INCREMENT_SYLLLABUS;
/

-- create trigger AUTO_INCREMENT_INSTRUCTOR

CREATE or REPLACE trigger AUTO_INCREMENT_INSTRUCTOR
before insert on instructor
for each row
begin
  select seq_instructor.nextval
  into :new.i_id
  from dual;
end AUTO_INCREMENT_INSTRUCTOR;
/

-- create trigger AUTO_INCREMENT_UNIVERSITY

CREATE or REPLACE trigger AUTO_INCREMENT_UNIVERSITY
before insert on university
for each row
begin
  select seq_university.nextval
  into :new.uni_id
  from dual;
end AUTO_INCREMENT_UNIVERSITY;
/

-- create trigger AUTO_INCREMENT_DEPARTMENT

CREATE or REPLACE trigger AUTO_INCREMENT_DEPARTMENT
before insert on department
for each row
begin
  select seq_department.nextval
  into :new.dept_id
  from dual;
end AUTO_INCREMENT_DEPARTMENT;
/

-- create trigger AUTO_INCREMENT_TAG

CREATE or REPLACE trigger AUTO_INCREMENT_TAG
before insert on tag
for each row
begin
  select seq_tag.nextval
  into :new.tag_id
  from dual;
end AUTO_INCREMENT_TAG;
/

-- create trigger AUTO_INCREMENT_COURSE

CREATE or REPLACE trigger AUTO_INCREMENT_COURSE
before insert on course
for each row
begin
  select seq_course.nextval
  into :new.course_id
  from dual;
end AUTO_INCREMENT_COURSE;
/

-- create trigger DATE_MOD_UPDATE

CREATE or REPLACE trigger DATE_MOD_UPDATE
before update on syllabus
for each row
begin
  select sysdate
  into :new.date_modified
  from dual;
end DATE_MOD_UPDATE;
/

    
-- ******************************************************
--    POPULATE TABLES
-- ******************************************************

INSERT into tag values(-1,'Art');
INSERT into tag values(-1,'Biology');
INSERT into tag values(-1,'Science');
INSERT into tag values(-1,'Writing');
INSERT into tag values(-1,'English');
INSERT into tag values(-1,'Chemistry');
INSERT into tag values(-1,'Chinese');
INSERT into tag values(-1,'Introductory');
INSERT into tag values(-1,'Language');
INSERT into tag values(-1,'Philosophy');

INSERT into instructor values(-1,null,'Elizabeth',null,'Bilyeau',null,'503-977-8332','ebilyeau@pcc.edu');
INSERT into instructor values(-1,'Dr.','Dennis',null,'Yi Tenen',null,'415-215-3315','denten@gmail.com');
INSERT into instructor values(-1,null,'Tatiana',null,'Snyder',null,'503-244-6111','tatiana@pdx.edu');
INSERT into instructor values(-1,null,'Chris',null,'Cayton',null,'503-977-4289','ccayton@pcc.edu');


INSERT into university values(-1,'Columbia University','New York','NY','USA');
INSERT into university values(-1,'Harvard University','Cambridge','MA','USA');
INSERT into university values(-1,'Portland Community College','Portland','OR','USA');

INSERT into department values(-1,'English and Comparative Literature');
INSERT into department values(-1,'Chemistry');
INSERT into department values(-1,'Psychology');
INSERT into department values(-1,'Art History');
INSERT into department values(-1,'Philosophy');

INSERT into course values(-1,1,1,'ENHS W4983', 'Hacking the Archive: The Digital Humanities Toolkit');
INSERT into course values(-1,3,4,'ART 212', 'Modern Art History: Early 20th Century Art');
INSERT into course values(-1,3,3,'PSY 201A', 'General Psychology');
INSERT into course values(-1,3,5,'PHL 204', 'Philosopy of Religion');
INSERT into course values(-1,3,5,'PHL 205', 'Biomedical Ethics');

INSERT into syllabus values(-1,'http://www.pcc.edu/resources/service-learning/documents/syllabus/Art212ElizabethBilyeu.pdf','WINTER',2007,2,1,default,default,25);
INSERT into syllabus values(-1,'http://www.columbia.edu','SPRING',2013,1,2,default,default,25);
INSERT into syllabus values(-1,'http://www.pcc.edu/resources/service-learning/documents/syllabus/psychology201ATatianaSnyder.pdf','FALL',2012,3,3,default,default,25);
INSERT into syllabus values(-1,'http://www.pcc.edu/resources/service-learning/documents/syllabus/philosophy205ChrisCayton.pdf','FALL',2009,5,4,default,default,25);
INSERT into syllabus values(-1,'http://www.pcc.edu/resources/service-learning/documents/syllabus/philosophy204ChrisCayton.pdf','SPRING',2011,4,4,default,default,25);
INSERT into syllabus values(-1,'http://www.pcc.edu/resources/service-learning/documents/syllabus/philosophy204ChrisCayton.pdf','SPRING',2008,4,4,default,default,25);

INSERT into syllabus_tag values(1,1);
INSERT into syllabus_tag values(1,7);
INSERT into syllabus_tag values(2,4);
INSERT into syllabus_tag values(2,5);
INSERT into syllabus_tag values(3,3);
INSERT into syllabus_tag values(3,7);
INSERT into syllabus_tag values(4,10);
INSERT into syllabus_tag values(5,10);
INSERT into syllabus_tag values(6,10);

select * from tag;
select * from instructor;
select * from university;
select * from department;
select * from course;
select * from syllabus;
select * from syllabus_tag;


-- ******************************************************
--    END SESSION
-- ******************************************************

spool off
