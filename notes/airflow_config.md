# Intro
It’s the standard INI file format (Airflow uses Python’s configparser under the hood).
Key points

Each section groups related configuration keys.

The most important sections you’ll see in airflow.cfg are:

[core] → fundamental settings (DAGs folder, executor, logging, etc.)

[scheduler] → scheduler behavior tuning

[webserver] → UI / API server settings

[database] → DB connection settings

[logging], [metrics], [secrets], [celery], [kubernetes], etc. depending on your setup.

Some keys have moved to new sections in Airflow 3.x (e.g. [dag_processor] split from [scheduler]).

Sections are case-insensitive ([Core] = [core]).

# airflow.cfg is the main configuration file for Airflow

replace # lines before promt
find and ^\s*#.*$

## Steps to Generate airflow.cfg
1) The airflow.cfg file is automatically generated the first time you run an Airflow command.

2) generate the airflow.cfg file, initializing the database is a common first step and will trigger the airflow.cfg creation.
airflow db init


### QLAlchemy, for example, is a Python library for database interaction:

“SQLAlchemy” = turning SQL statements into Python objects (like magic → transformation).

It acts as an Object-Relational Mapper (ORM), converting database rows into Python objects and vice versa.

### hange in .cfg file
1) Edit airflow.cfg (or env variable) and set:
load_examples = False
2) Then clear the DB and restart:
airflow db reset
airflow db init

### To give UI name
```
Open your airflow.cfg file >> Find the section: [webserver]

Add or modify this setting:

instance_name = My Data Platform

restart app-server
```
