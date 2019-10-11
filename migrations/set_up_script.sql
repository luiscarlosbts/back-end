/**
  Creation of the schema
 */
/* In PostgreSQL, cross-database queries can be very
costly in terms of performance, so a One database - Many schemas
approach is preferred */
-- Create the schema
CREATE SCHEMA bts_admin;

/* Setting the current schema */
SET search_path TO bts_admin, public;

/* Set up clean schema */
DROP TABLE IF EXISTS pto_days_per_location;
DROP TABLE IF EXISTS available_pto_days;
DROP TABLE IF EXISTS users_roles;
DROP TABLE IF EXISTS user_skill_levels;
DROP TABLE IF EXISTS skill_levels;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS user_experiences;
DROP TABLE IF EXISTS user_project_hours;
DROP TABLE IF EXISTS users_projects;

DROP TABLE IF EXISTS role_permissions;
DROP TABLE IF EXISTS permissions;
DROP TABLE IF EXISTS permission_categories;

DROP TABLE IF EXISTS project_roles;

DROP TABLE IF EXISTS client_project_team;
DROP TABLE IF EXISTS client_members;

DROP TABLE IF EXISTS weeklies_projects;
DROP TABLE IF EXISTS weekly_alerts;
DROP TABLE IF EXISTS weeklies;
DROP TABLE IF EXISTS timesheet_descriptions;
DROP TABLE IF EXISTS timesheet_alerts;
DROP TABLE IF EXISTS timesheets;
DROP TABLE IF EXISTS check_ins;

DROP TABLE IF EXISTS pto_status;
DROP TABLE IF EXISTS days_off_historic;
DROP TABLE IF EXISTS day_off_types;

DROP TABLE IF EXISTS wishlists;
DROP TABLE IF EXISTS votes;
DROP TABLE IF EXISTS office_wishlists;

DROP TABLE IF EXISTS users_licenses;
DROP TABLE IF EXISTS item_letters;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS invoices;
DROP TABLE IF EXISTS item_subcategories;
DROP TABLE IF EXISTS item_spec_values;
DROP TABLE IF EXISTS item_specs;
DROP TABLE IF EXISTS item_types;
DROP TABLE IF EXISTS item_categories;

DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS clients;
DROP TABLE IF EXISTS users;

DROP TABLE IF EXISTS holiday_locations;
DROP TABLE IF EXISTS company_fields;
DROP TABLE IF EXISTS company_roles;
DROP TABLE IF EXISTS company_locations;
DROP TABLE IF EXISTS company_regions;
DROP TABLE IF EXISTS company_holidays;
DROP TABLE IF EXISTS company_seniorities;
DROP TABLE IF EXISTS company_positions;

DROP TYPE IF EXISTS status;

/**
  Creation of tables
 */
/* Company Tables */
CREATE TABLE company_fields (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    is_approved BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE company_roles (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    is_approved BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE company_regions (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE company_locations (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    region_id INT NOT NULL REFERENCES company_regions(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE available_pto_days (
    id SERIAL PRIMARY KEY,
    min_years INT NOT NULL,
    max_years INT NOT NULL,
    amount INT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- New table
CREATE TABLE pto_days_per_location (
    available_pto_day_id INT NOT NULL REFERENCES available_pto_days(id) ON DELETE CASCADE,
    company_location_id INT NOT NULL REFERENCES company_locations(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (available_pto_day_id, company_location_id)
);

CREATE TABLE company_holidays (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    name TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE company_seniorities (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    is_approved BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE company_positions (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    is_approved BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE holiday_locations (
    holiday_id INT NOT NULL REFERENCES company_holidays(id) ON DELETE CASCADE,
    location_id INT NOT NULL REFERENCES company_locations(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY(holiday_id, location_id)
);

/* Employees Tables */
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    password TEXT NOT NULL,
    photo TEXT NOT NULL,
    description TEXT NOT NULL,
    start_date DATE NOT NULL DEFAULT NOW(), -- NEW
    end_date DATE, -- NEW
    company_field_id INT NOT NULL REFERENCES company_fields(id) ON DELETE NO ACTION,
    company_seniority_id INT NOT NULL REFERENCES company_seniorities(id) ON DELETE NO ACTION,
    company_position_id INT NOT NULL REFERENCES company_positions(id) ON DELETE NO ACTION,
    company_location_id INT NOT NULL REFERENCES company_locations(id) ON DELETE NO ACTION,
    -- Removed available_pto_day_id field
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (email)
);

CREATE TABLE users_roles (
    user_id INT NOT NULL REFERENCES users(id),
    role_id INT NOT NULL REFERENCES company_roles(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE skills (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    is_approved BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE skill_levels (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE user_skill_levels (
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    skill_id INT NOT NULL REFERENCES skills(id) ON DELETE CASCADE,
    skill_level_id INT NOT NULL REFERENCES skill_levels(id) ON DELETE CASCADE,
    PRIMARY KEY(user_id, skill_id)
);

CREATE TABLE user_experiences (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(id),
    position TEXT NOT NULL,
    company TEXT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    responsibilities TEXT[] NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE permission_categories (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE permissions (
    id SERIAL PRIMARY KEY,
    permission_category_id INT NOT NULL REFERENCES permission_categories(id) ON DELETE CASCADE,
    description TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE role_permissions (
    role_id INT NOT NULL REFERENCES company_roles(id) ON DELETE CASCADE,
    permission_id INT NOT NULL REFERENCES permissions(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (role_id, permission_id)
);

/* Clients Table */
CREATE TABLE clients (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT,
    is_approved BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (email)
);

CREATE TABLE client_members (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    position_id INT NOT NULL REFERENCES company_positions(id),
    email TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (email)
);

/* Project Tables */
CREATE TABLE projects (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    image TEXT,
    start_date DATE NOT NULL, -- NEW
    end_date DATE, -- NEW
    client_id INT NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ, -- NEW
    UNIQUE (name)
);

CREATE TABLE client_project_team (
    client_id INT NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
    project_id INT NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    member_id INT NOT NULL REFERENCES client_members(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,
    PRIMARY KEY (client_id, project_id, member_id)
);

CREATE TABLE project_roles (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    is_approved BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE users_projects (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    project_id INT NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    project_role_id INT NOT NULL REFERENCES project_roles(id) ON DELETE CASCADE,
    start_date DATE NOT NULL DEFAULT NOW(), -- NEW
    -- Removed expected_hours_per_week
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ, -- This determines user's (employee's) inactivity
    UNIQUE (user_id, project_id, project_role_id) -- NEW
);

-- New table
CREATE TABLE user_project_hours (
    id SERIAL PRIMARY KEY,
    user_project_id INT NOT NULL REFERENCES users_projects(id) ON DELETE CASCADE,
    expected_hours_per_week INT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

/* Employee's Reports Tables */
CREATE TABLE weeklies (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    week INT NOT NULL,
    country_activities TEXT[] NOT NULL,
    company_activities TEXT[] NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE weeklies_projects (
    weekly_id INT NOT NULL REFERENCES weeklies(id) ON DELETE CASCADE,
    project_id INT NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    activities TEXT[] NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE weekly_alerts (
    id SERIAL PRIMARY KEY,
    weekly_id INT NOT NULL REFERENCES weeklies(id) ON DELETE CASCADE,
    solved_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE timesheets (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    date DATE NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE timesheet_alerts (
    id SERIAL PRIMARY KEY,
    timesheet_id INT NOT NULL REFERENCES timesheets(id) ON DELETE CASCADE,
    solved_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE timesheet_descriptions (
    id SERIAL PRIMARY KEY,
    timesheet_id INT NOT NULL REFERENCES timesheets(id) ON DELETE CASCADE,
    project_id INT NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    dedicated_hours INT NOT NULL,
    task TEXT NOT NULL,
    is_happy BOOLEAN NOT NULL DEFAULT TRUE,
    note TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE check_ins (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    arrival TEXT NOT NULL,
    leave_lunch TEXT,
    arrival_lunch TEXT,
    leave TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

/* Employee's Days Off Tables */
CREATE TABLE day_off_types (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Setting the status ENUM type
CREATE TYPE status AS ENUM ('pending', 'accepted', 'declined');

CREATE TABLE days_off_historic (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    days_off_type_id INT NOT NULL REFERENCES day_off_types(id) ON DELETE CASCADE,
    from_date DATE NOT NULL,
    to_date DATE,
    total_work_days INT NOT NULL,
    notes TEXT, -- NEW
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE pto_status (
    id SERIAL PRIMARY KEY,
    days_off_historic_id INT NOT NULL REFERENCES days_off_historic(id) ON DELETE CASCADE,
    status status NOT NULL DEFAULT 'pending',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

/* Inventory Tables */
CREATE TABLE invoices (
    id SERIAL PRIMARY KEY,
    fiscal_number TEXT NOT NULL,
    date DATE NOT NULL,
    supplier_name TEXT NOT NULL,
    supplier_location TEXT NOT NULL,
    supplier_rfc TEXT NOT NULL,
    doc_url TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE item_categories (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE items (
    id SERIAL PRIMARY KEY,
    company_location_id INT REFERENCES company_locations(id) ON DELETE RESTRICT,
    item_category_id INT NOT NULL REFERENCES item_categories(id) ON DELETE RESTRICT,
    invoice_id INT REFERENCES invoices(id) ON DELETE RESTRICT,
    data JSON NOT NULL,
    purchase_date DATE NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE item_subcategories (
    id SERIAL PRIMARY KEY,
    item_category_id INT NOT NULL REFERENCES item_categories(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE item_letters (
    id SERIAL PRIMARY KEY,
    item_id INT NOT NULL REFERENCES items(id) ON DELETE CASCADE,
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    signed_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE item_specs (
    id SERIAL PRIMARY KEY,
    item_category_id INT NOT NULL REFERENCES item_categories(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE item_spec_values (
    id SERIAL PRIMARY KEY,
    item_spec_id INT NOT NULL REFERENCES item_specs(id) ON DELETE CASCADE,
    value TEXT NOT NULL,
    is_approved BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE users_licenses (
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    item_id INT NOT NULL REFERENCES items(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (user_id, item_id)
);

CREATE TABLE item_types (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE wishlists (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    item_subcategory_id INT NOT NULL REFERENCES item_subcategories(id) ON DELETE RESTRICT,
    product TEXT NOT NULL,
    url TEXT NOT NULL,
    reason TEXT NOT NULL,
    status status NOT NULL DEFAULT 'pending',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE office_wishlists (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    item_category_id INT NOT NULL REFERENCES item_categories(id) ON DELETE RESTRICT,
    item_type_id INT NOT NULL REFERENCES item_types(id) ON DELETE RESTRICT,
    product TEXT NOT NULL,
    price NUMERIC(8,2) NOT NULL,
    url TEXT NOT NULL,
    status status NOT NULL DEFAULT 'pending',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE votes (
    id SERIAL PRIMARY KEY,
    office_wishlist_id INT NOT NULL REFERENCES office_wishlists(id) ON DELETE CASCADE,
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);