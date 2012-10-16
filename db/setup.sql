drop table if exists people;
create table people (
	name varchar(255),
	description text,
	dbpedia_uri varchar(255),
	image_uri varchar(255),
	cooccurence_count int
);

drop table if exists organisations;
create table organisations (
	name varchar(255),
	description text,
	dbpedia_uri varchar(255),
	image_uri varchar(255),
	cooccurence_count int
);

drop table if exists articles;
create table articles (
	cps_id varchar(255),
	headline varchar(255),
	uri varchar(255),
	published_at datetime
);

drop table if exists programmes;
create table programmes (
	pid varchar(20),
	title varchar(255),
	subtitle varchar(255),
	synopsis text
);