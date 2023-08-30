INSERT INTO quest (first_name, last_name, member_since)
VALUES
    ('Ivan', 'Smirnov', '2018-05-15'),
    ('Natalya', 'Popova', '2019-02-28'),
    ('Sergei', 'Kuznetsov', '2020-11-10'),
    ('Olga', 'Vasilieva', '2017-09-22'),
    ('Dmitri', 'Romanov', '2021-07-04');

-- Room 
INSERT INTO room_type (description_, max_capacity)
VALUES
    ('Cozy Single', 1),
    ('Double Deluxe', 2),
    ('Luxury Suite', 3),
    ('Family Fun', 4),
    ('Penthouse Paradise', 2);

-- Reservation
INSERT INTO reservation (date_in, date_out, made_by, guest_id)
VALUES
    ('2023-09-10', '2023-09-15', 'Natalya Popova', 2),
    ('2023-08-20', '2023-08-25', 'Sergei Kuznetsov', 3),
    ('2023-10-05', '2023-10-10', 'Ivan Smirnov', 1),
    ('2023-11-18', '2023-11-22', 'Olga Vasilieva', 4),
    ('2023-09-05', '2023-09-09', 'Dmitri Romanov', 5);

-- Reserved Room
INSERT INTO reserved_room (number_of_rooms, room_type_id, reservation_id, status_)
VALUES
    (1, 1, 1, 'Confirmed'),
    (2, 3, 2, 'Pending'),
    (1, 2, 3, 'Confirmed'),
    (1, 4, 4, 'Confirmed'),
    (1, 5, 5, 'Confirmed');

-- Room 
INSERT INTO room (number, name_, status_, smoke, room_type_id)
VALUES
    ('101', 'Sunny Suite', 'Vacant', 0, 1),
    ('202', 'Deluxe Den', 'Vacant', 0, 2),
    ('303', 'Luxury Loft', 'Vacant', 0, 3),
    ('404', 'Family Fiesta', 'Vacant', 0, 4),
    ('505', 'Penthouse Panorama', 'Vacant', 0, 5);

-- Occupied Room 
INSERT INTO occupied_room (check_in, check_out, room_id, resservation_id)
VALUES
    ('2023-09-10 14:00:00', '2023-09-15 12:00:00', 1, 1),
    ('2023-08-20 15:00:00', '2023-08-25 11:00:00', 2, 2),
    ('2023-10-05 13:00:00', '2023-10-10 10:00:00', 3, 3),
    ('2023-11-18 14:30:00', '2023-11-22 11:30:00', 4, 4),
    ('2023-09-05 16:00:00', '2023-09-09 10:30:00', 5, 5);

-- Hosted At 
INSERT INTO hosted_at (guest_id, occupied_room_id)
VALUES
    (2, 1),
    (3, 2),
    (1, 3),
    (4, 4),
    (5, 5);