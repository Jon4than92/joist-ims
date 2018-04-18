Manufacturer.create!([
    { name: 'Dell' },
    { name: 'Apple' },
    { name: 'Hewlett-Packard' },
    { name: 'ASUS' }
])

Vendor.create!([
    { name: 'Google' },
    { name: 'Microsoft' },
    { name: 'Autodesk' },
    { name: 'Adobe' }
])

Building.create!([
    { name: 'A23' },
    { name: 'B55' },
    { name: 'TDMA2' }
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

AccountType.create!([
    { name: 'Management' },
    { name: 'Custodian' },
    { name: 'Standard' }
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

Account.create!([
    { employee_id: 1, account_type_id: 3, email: 'john.c.doe@example.com', :password => 'password', :password_confirmation => 'password' },
    { employee_id: 2, account_type_id: 2, email: 'steve.e.smith@example.com', :password => 'password', :password_confirmation => 'password' },
    { employee_id: 3, account_type_id: 1, email: 'bob.t.douglas@example.com', :password => 'password', :password_confirmation => 'password' }
])

Custodian.create!([
    { employee_id: 2, custodian_account_id: 3 },
    { employee_id: 2, custodian_account_id: 5 },
    { employee_id: 2, custodian_account_id: 6 }
])

Hardware.create!([
    { name: 'HP G200 Desktop', manufacturer_id: 4, year: 2017, model_num: 'AA321', tag_num: '210103', serial_num: 'ACG2111V31', cost: 10000, condition: 'New', room_id: 2, custodian_id: 2 },
    { name: 'MacBook Pro', manufacturer_id: 2, year: 2010, model_num: '53JX9', tag_num: '210177', serial_num: 'VBR4H669WE', cost: 1500, condition: 'Used', room_id: 5, custodian_id: 3 }
])

Software.create!([
    { name: 'Word', vendor_id: 2, version: '2015.64.1_A', year: 2015, license_start_date: Date.new(2015,9,1), license_end_date: Date.new(2019,8,5), hardware_id: 1, custodian_id: 1, cost: 100, license_key: 'A231-234AS-5E6TC-ZDSA64' },
    { name: 'Photoshop CC', vendor_id: 4, version: '2017.1.20', year: 2017, license_start_date: Date.new(2018,3,11), license_end_date: Date.new(2019,5,26), hardware_id: 2, custodian_id: 3, cost: 800, license_key: '1111-234AS-455DC-D454S' },
    { name: '3dsMax', vendor_id: 3, version: '7.2.1_R3', year: 2018, license_start_date: Date.new(2018,3,11), license_end_date: Date.new(2019,3,11), hardware_id: 1, custodian_id: 2, cost: 1200, license_key: '1111-234AS-455DC-D454S' }
])
