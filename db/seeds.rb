# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Building.create!([
    { name: 'A23' },
    { name: 'B55' },
    { name: 'TDMA2' }
])

Room.create!([
    { building_id: 1, name: '100A' },
    { building_id: 1, name: '100B' },
    { building_id: 1, name: '116F' },
    { building_id: 1, name: '300' },
    { building_id: 2, name: '101' },
    { building_id: 2, name: '102' },
    { building_id: 2, name: '103' },
    { building_id: 2, name: '104' },
    { building_id: 3, name: '200' },
    { building_id: 3, name: '201A' },
    { building_id: 3, name: '201B' },
    { building_id: 3, name: '202' },
])

Employee.create!([
    { first_name: 'John', middle_initial: 'C', last_name: 'Doe', job_title: 'Developer', room_id: 1, email: 'john.c.doe@example.com', phone: '281-111-1111', active: true },
    { first_name: 'Steve', middle_initial: 'E', last_name: 'Smith', job_title: 'Program Manager', room_id: 5, email: 'steve.e.smith@example.com', phone: '281-222-2222', active: true },
    { first_name: 'Bob', middle_initial: 'T', last_name: 'Douglas', job_title: 'Project Manager', room_id: 10, email: 'bob.t.douglas@example.com', phone: '281-333-3333', active: true }
])

AccountType.create!([
    { name: 'Management' },
    { name: 'Custodian' },
    { name: 'Standard' }
])

CustodianAccount.create!([
    { name: 'CB1' },
    { name: 'CD2' },
    { name: 'CA39P' },
    { name: 'IX1' },
    { name: 'CO5' },
    { name: 'CO56' },
    { name: 'CA71' }
])

Account.create!([
    { employee_id: 1, account_type_id: 3, email: 'john.c.doe@example.com', :password => 'password', :password_confirmation => 'password' },
    { employee_id: 2, account_type_id: 2, email: 'steve.e.smith@example.com', :password => 'password', :password_confirmation => 'password' },
    { employee_id: 3, account_type_id: 1, email: 'bob.t.douglas@example.com', :password => 'password', :password_confirmation => 'password' }
])