-- here is the DOCTOR DATA: 100 doctors across 40 hospitals
INSERT INTO doctor (hospital_id, first_name, last_name, date_of_birth, address) VALUES
    (1,  'John',     'Smith',        '1975-04-12', '10 King Street, London, England'),
    (1,  'Emily',    'Jones',        '1980-09-23', '5 River Road, London, England'),
    (1,  'Peter',    'White',        '1972-01-08', '21 Oak Lane, London, England'),

    (2,  'Michael',  'Brown',        '1968-05-15', '14 Market Street, Birmingham, England'),
    (2,  'Sarah',    'Taylor',       '1979-11-18', '7 Victoria Road, Birmingham, England'),
    (2,  'Daniel',   'Young',        '1983-02-02', '3 Hill View, Birmingham, England'),

    (3,  'Laura',    'Davies',       '1981-03-09', '8 Church Lane, Manchester, England'),
    (3,  'David',    'Wilson',       '1974-09-27', '12 Brook Street, Manchester, England'),
    (3,  'Olivia',   'Miller',       '1986-06-30', '40 Lake Road, Manchester, England'),

    (4,  'Thomas',   'Evans',        '1969-12-21', '19 Station Road, Leeds, England'),
    (4,  'Anna',     'Roberts',      '1978-07-02', '7 Park Avenue, Leeds, England'),
    (4,  'James',    'Cook',         '1982-10-14', '25 Maple Close, Leeds, England'),

    (5,  'Rebecca',  'Johnson',      '1976-05-29', '3 Queen Street, Newcastle, England'),
    (5,  'Henry',    'Hughes',       '1965-08-07', '44 Park Road, Newcastle, England'),
    (5,  'Sophie',   'Ward',         '1984-01-17', '16 Elm Street, Newcastle, England'),

    (6,  'Robert',   'Walker',       '1971-02-03', '18 Market Street, Bristol, England'),
    (6,  'Chloe',    'Morgan',       '1985-10-09', '27 Oak Avenue, Bristol, England'),
    (6,  'Martin',   'Gray',         '1977-06-11', '9 River Close, Bristol, England'),

    (7,  'Isabelle', 'Parker',       '1983-09-19', '32 Mill Lane, Bath, England'),
    (7,  'Luke',     'Harrison',     '1970-04-25', '5 Garden Road, Bath, England'),
    (7,  'Grace',    'Price',        '1987-12-03', '14 Church Road, Bath, England'),

    (8,  'Ethan',    'Bell',         '1979-01-30', '22 Bridge Street, Gloucester, England'),
    (8,  'Natalie',  'Reed',         '1982-07-15', '6 Highfield Road, Gloucester, England'),
    (8,  'Simon',    'Cole',         '1966-03-04', '11 Meadow Close, Gloucester, England'),

    (9,  'Katherine','Bailey',       '1973-05-05', '2 Kingfisher Way, Swindon, England'),
    (9,  'Owen',     'Russell',      '1981-11-28', '9 New Street, Swindon, England'),
    (9,  'Megan',    'Harper',       '1988-02-20', '33 Birch Close, Swindon, England'),

    (10, 'Andrew',   'Foster',       '1967-03-08', '8 Riverbank Road, Coventry, England'),
    (10, 'Lucy',     'Howard',       '1976-09-10', '19 Station View, Coventry, England'),
    (10, 'Adam',     'Stephens',     '1983-01-26', '41 Green Lane, Coventry, England'),

    (11, 'Zoe',      'Wallace',      '1978-06-14', '12 Oak Grove, Salford, England'),
    (11, 'Ben',      'Matthews',     '1984-10-03', '27 Canal Street, Salford, England'),
    (11, 'Harriet',  'Jenkins',      '1970-12-19', '5 Hillcrest Road, Salford, England'),

    (12, 'Ryan',     'Phillips',     '1972-08-08', '4 Church Street, Stockport, England'),
    (12, 'Amelia',   'Cross',        '1986-04-01', '30 School Lane, Stockport, England'),
    (12, 'Marcus',   'Berry',        '1975-01-23', '18 Park Rise, Stockport, England'),

    (13, 'Holly',    'Simpson',      '1980-09-11', '7 Brookside, Bolton, England'),
    (13, 'Kyle',     'Burton',       '1973-07-07', '13 Elm Grove, Bolton, England'),
    (13, 'Rachel',   'Lawrence',     '1985-02-28', '21 Church View, Bolton, England'),

    (14, 'Nathan',   'Powell',       '1974-05-09', '25 Station Road, Huddersfield, England'),
    (14, 'Ella',     'Barrett',      '1981-03-21', '6 Garden Close, Huddersfield, England'),
    (14, 'Gareth',   'Poole',        '1969-10-02', '17 Highfield Close, Huddersfield, England'),

    (15, 'Molly',    'Nichols',      '1983-08-16', '31 River Street, Wakefield, England'),
    (15, 'Jason',    'Norman',       '1977-02-10', '9 Church Close, Wakefield, England'),
    (15, 'Abigail',  'Kerr',         '1988-01-05', '15 Park Lane, Wakefield, England'),

    (16, 'Dominic',  'Walsh',        '1972-11-29', '11 King Street, Sunderland, England'),
    (16, 'Katie',    'Lane',         '1985-06-07', '4 Mill Road, Sunderland, England'),
    (16, 'Stuart',   'Hayes',        '1970-03-19', '22 Oak Road, Sunderland, England'),

    (17, 'Leah',     'Sanders',      '1984-04-04', '2 Victoria Street, Middlesbrough, England'),
    (17, 'Aiden',    'Burns',        '1976-09-12', '18 River View, Middlesbrough, England'),
    (17, 'Paige',    'Fox',          '1987-07-30', '29 Church Hill, Middlesbrough, England'),

    (18, 'Gavin',    'Morley',       '1968-01-27', '12 Station Close, Durham, England'),
    (18, 'Bethany',  'Atkins',       '1982-03-03', '7 Green Street, Durham, England'),
    (18, 'Joel',     'Khan',         '1979-08-22', '24 High Street, Durham, England'),

    (19, 'Lauren',   'French',       '1981-10-18', '6 Lake View, Nottingham, England'),
    (19, 'Callum',   'Rees',         '1975-06-05', '20 Brook Lane, Nottingham, England'),
    (19, 'Chantelle','Goodwin',      '1986-12-09', '33 Park View, Nottingham, England'),

    (20, 'Elliot',   'Hayward',      '1973-09-01', '3 Church Road, Derby, England'),
    (20, 'Naomi',    'Blake',        '1984-05-06', '16 Market Close, Derby, England'),
    (20, 'Patrick',  'Rowe',         '1966-02-11', '28 Station Road, Derby, England'),

    -- hospitals 21–40: 2 doctors each (40 doctors)
    (21, 'Hannah',   'Sharpe',       '1982-07-15', '19 Oak Avenue, Leicester, England'),
    (21, 'Liam',     'Bond',         '1974-01-23', '8 Hill Road, Leicester, England'),

    (22, 'Chelsea',  'Sutton',       '1985-11-08', '12 Riverside Way, Lincoln, England'),
    (22, 'Jacob',    'Doyle',        '1977-09-29', '5 Mill Close, Lincoln, England'),

    (23, 'Phoebe',   'Todd',         '1983-03-17', '7 Park Terrace, Sheffield, England'),
    (23, 'Connor',   'Milton',       '1971-08-02', '22 Church Lane, Sheffield, England'),

    (24, 'Imogen',   'Field',        '1980-12-14', '3 King Street, Doncaster, England'),
    (24, 'Reece',    'Humphreys',    '1976-04-19', '18 Brook Road, Doncaster, England'),

    (25, 'Georgia',  'Hammond',      '1986-01-26', '11 New Road, Rotherham, England'),
    (25, 'Shaun',    'Middleton',    '1973-05-30', '27 Garden Street, Rotherham, England'),

    (26, 'Clara',    'Allan',        '1984-09-03', '14 Oakfield Road, Chesterfield, England'),
    (26, 'Darren',   'Swift',        '1969-07-21', '6 Church Walk, Chesterfield, England'),

    (27, 'Tara',     'Walters',      '1982-02-18', '20 High Street, Bath, England'),
    (27, 'Marcus',   'Nash',         '1975-10-10', '9 Hilltop Road, Bath, England'),

    (28, 'Nadia',    'Farrell',      '1987-06-22', '31 River Road, Gloucester, England'),
    (28, 'Ollie',    'Rhodes',       '1972-03-28', '4 Market Street, Gloucester, England'),

    (29, 'Kayleigh', 'Flynn',        '1985-05-13', '2 Station View, Swindon, England'),
    (29, 'Harvey',   'Thorpe',       '1978-11-01', '13 Oak Crescent, Swindon, England'),

    (30, 'Millie',   'Benson',       '1983-08-07', '8 Churchfield Road, Coventry, England'),
    (30, 'Declan',   'Kirk',         '1970-06-16', '26 Park Crescent, Coventry, England'),

    (31, 'Annie',    'Sykes',        '1981-05-24', '3 Bridge Way, Leeds, England'),
    (31, 'Jon',      'Parsons',      '1967-09-09', '17 Forest Road, Leeds, England'),

    (32, 'Ria',      'Dawson',       '1984-04-30', '15 Manor Road, Nottingham, England'),
    (32, 'Lewis',    'Pritchard',    '1976-01-18', '21 Mill Lane, Nottingham, England'),

    (33, 'Willow',   'Norton',       '1987-03-27', '7 Brookfield Close, Derby, England'),
    (33, 'Fraser',   'Cameron',      '1973-12-06', '10 Newfield Road, Derby, England'),

    (34, 'Jade',     'McLean',       '1982-09-14', '4 Kingfisher Close, Leicester, England'),
    (34, 'Euan',     'Clements',     '1971-07-05', '19 Meadow Road, Leicester, England'),

    (35, 'Alisha',   'Buckley',      '1985-02-08', '23 Station Lane, Lincoln, England'),
    (35, 'Ross',     'Haines',       '1974-03-31', '6 Oak Way, Lincoln, England'),

    (36, 'Natalia',  'Rowlands',     '1980-10-25', '34 Highgate Road, Sheffield, England'),
    (36, 'Adrian',   'Fielding',     '1968-08-16', '11 Church Rise, Sheffield, England'),

    (37, 'Sian',     'Mercer',       '1983-01-12', '18 Riverbank Close, Doncaster, England'),
    (37, 'Lewis',    'Rogers',       '1972-05-27', '9 Mill View, Doncaster, England'),

    (38, 'Ella',     'Radcliffe',    '1986-07-19', '3 Greenhill Road, Rotherham, England'),
    (38, 'Brandon',  'Hurst',        '1977-02-09', '20 Oak Grove, Rotherham, England'),

    (39, 'Katy',     'Gallagher',    '1984-11-23', '12 Churchfield Close, Chesterfield, England'),
    (39, 'Callan',   'Potter',       '1975-04-04', '27 Park Drive, Chesterfield, England'),

    (40, 'Maya',     'Holland',      '1982-06-02', '4 River View, York, England'),
    (40, 'Elliott',  'Shepherd',     '1970-09-20', '15 Station Close, York, England');
