# Variables creation using Airflow UI


## Create using UI
```
Left hand side menu >> Admin >> Variables
```
## Verify in database
```
SELECT * FROM variable;
```

## Access in code
```
from airflow.models import Variable

# Get variable value
my_var = Variable.get("my_variable_name")

# Get variable value with default
my_var = Variable.get("my_variable_name", default_var="default_value")

# Get JSON variable as dict
my_json_var = Variable.get("my_json_var", deserialize_json=True)
```


## Using CLI
```
# List all variables
airflow variables list

# Get a specific variable
airflow variables get my_variable_name

# Set a variable
airflow variables set my_variable_name "value"

# Delete a variable
airflow variables delete my_variable_name
```
