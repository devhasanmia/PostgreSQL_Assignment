-- Active: 1745317865410@@127.0.0.1@5432@conservation_db
-- Create a new database
CREATE DATABASE "conservation_db";


-- Create rangers Table
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(120) NOT NULL
)

-- Create Species Table
CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(100) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) NOT NULL
)

-- Create sightings Table

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INT REFERENCES species (species_id) NOT NULL,
    ranger_id INT REFERENCES rangers (ranger_id) NOT NULL,
    location VARCHAR(160),
    sighting_time TIMESTAMP NOT NULL,
    notes TEXT
)

-- Insert rangers Sample Data
INSERT INTO
    rangers (name, region)
VALUES (
        'Alice Green',
        'Northern Hills'
    ),
    (
        'Bob White', 
        'River Delta'),
    (
        'Carol King',
        'Mountain Range'
    );

-- Insert species Sample Data
INSERT INTO
    species (
        common_name,
        scientific_name,
        discovery_date,
        conservation_status
    )
VALUES (
        'Snow Leopard',
        'Panthera uncia',
        '1775-01-01',
        'Endangered'
    ),
    (
        'Bengal Tiger',
        'Panthera tigris',
        '1758-01-01',
        'Endangered'
    ),
    (
        'Red Panda',
        'Ailurus fulgens',
        '1825-01-01',
        'Vulnerable'
    ),
    (
        'Asiatic Elephant',
        'Elephas maximus indicus',
        '1758-01-01',
        'Endangered'
    );

-- Insert sightings Sample Data
INSERT INTO
    sightings (
        species_id,
        ranger_id,
        location,
        sighting_time,
        notes
    )
VALUES (
        1,
        1,
        'Peak Ridge',
        '2024-05-10 07:45:00',
        'Camera trap image captured'
    ),
    (
        2,
        2,
        'Bankwood Area',
        '2024-05-12 16:20:00',
        'Juvenile seen'
    ),
    (
        3,
        3,
        'Bamboo Grove East',
        '2024-05-15 09:10:00',
        'Feeding observed'
    ),
    (
        1,
        2,
        'Snowfall Pass',
        '2024-05-18 18:30:00',
        NULL
    );

-- Problem 1 
-- Description: Register a new ranger with provided data with name = 'Derek Fox' and region = 'Coastal Plains'

INSERT INTO
    rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

-- Problem 2
-- Description: Count unique species ever sighted.

SELECT COUNT(DISTINCT species_id) FROM sightings;

-- Problem 3
-- Description: Find all sightings where the location includes "Pass".

SELECT * FROM sightings
    WHERE location ILIKE '%Pass%';


-- Problem 4
-- Description: List each ranger's name and their total number of sightings.

SELECT rangers.name, COUNT(sightings.sighting_id) AS total_sightings
FROM rangers
LEFT JOIN sightings ON rangers.ranger_id = sightings.ranger_id
GROUP BY rangers.name;


-- Problem 5
-- Description: List species that have never been sighted.

SELECT common_name FROM species
    WHERE species_id NOT IN (
    SELECT DISTINCT species_id FROM sightings
);


-- Problem 6
-- Description: Show the most recent 2 sightings.

SELECT sp.common_name, s.sighting_time, r.name
FROM sightings s
JOIN species sp ON s.species_id = sp.species_id
JOIN rangers r ON s.ranger_id = r.ranger_id
ORDER BY s.sighting_time DESC
LIMIT 2;


