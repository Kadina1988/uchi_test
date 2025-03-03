school = School.create

SchoolClass.create(number: 1, letter: 'j', school_id: school.id)

Student.create(first_name: 'John', last_name: 'Doe', surname: 'Mike', school_id: school.id, class_id: SchoolClass.first.id)
