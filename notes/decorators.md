### How decorator works in Apache Airflow 3.1.x, Explain in details
The TaskFlow decorators let you write plain Python functions and turn them into Airflow Tasks (operator instances) without manually instantiating an Operator class each time.
 @dag turns a function into a DAG factory;
 @task turns a function into a task (an operator wrapper).

When you decorate a function (e.g. @task), Airflow wraps that function in a small wrapper object.
Calling the wrapped function at DAG definition time does not immediately execute the function body;
instead it builds a Task (operator) node and returns an XComArg / proxy that represents the task's future output.
The wrapper holds metadata (operator class, arguments, etc.) used later by the scheduler/executor.


### List of decorators in Apache airflow 3.1.x with examples
```
1) @dag(...)

Creates a DAG factory: decorate a function whose body defines tasks and dependencies and calling it returns a DAG object. Use this for DAG-level arguments (dag_id, schedule, start_date, catchup, etc.).
Apache Airflow
+1

# example_dag.py
from airflow.sdk import dag, task
import pendulum

@dag(schedule=None, start_date=pendulum.datetime(2025,1,1), catchup=False)
def my_pipeline():
    @task
    def say_hi():
        return "hi"
    t = say_hi()

dag = my_pipeline()

2) @task(...)

The basic TaskFlow decorator: converts a Python function into an Airflow task (operator). When called during DAG definition it returns an XComArg (a proxy for that task's future output). You can pass operator kwargs (e.g., retries, pool) to the decorator.
Apache Airflow
+1

from airflow.sdk import task

@task(retries=2)
def get_numbers():
    return [1,2,3]

@task
def sum_numbers(nums):
    return sum(nums)

sum_numbers(get_numbers())

3) @task.branch(...)

Like @task but used for branching logic: the decorated function should return a task_id (or list of task_ids) to follow; other downstream tasks will be skipped. Use for conditional paths inside DAGs.
Apache Airflow
+1

from airflow.sdk import dag, task
import pendulum

@dag(schedule=None, start_date=pendulum.datetime(2025,1,1))
def branch_example():
    @task.branch
    def choose_path(x):
        return "task_b" if x > 5 else "task_a"

    @task
    def task_a(): pass

    @task
    def task_b(): pass

    chosen = choose_path(10)
    task_a()  # downstream of chosen
    task_b()

branch_example()

4) @task.sensor(...)

Create inline sensors: turns a Python callable into a BaseSensorOperator-like task. Useful when no built-in sensor exists for your check. (Sensor decorator often returns PokeReturnValue or True/False depending on implementation.)
Astronomer
+1

from airflow.sdk import dag, task
import pendulum

@dag(schedule=None, start_date=pendulum.datetime(2025,1,1))
def sensor_dag():
    @task.sensor(poke_interval=60, timeout=3600)
    def wait_for_condition():
        # return True when the condition is met (or PokeReturnValue)
        return True

    wait_for_condition()

sensor_dag()

5) @task_group(...) (or @taskgroup)

Wraps a function that defines multiple tasks into a TaskGroup (UI grouping). Handy for organizing complex DAGs and for composing reusable groups. You can also use task_group as a context manager.
Marc Lamberti
+1

from airflow.sdk import dag, task_group, task
import pendulum

@dag(schedule=None, start_date=pendulum.datetime(2025,1,1))
def tg_dag():
    @task
    def a(): return 1
    @task
    def b(x): return x+1

    @task_group
    def group_work():
        x = a()
        b(x)

    group_work()

tg_dag()

6) Provider-style @task.<something> decorators (examples: @task.bash, @task.docker, @task.virtualenv, etc.)

Providers and the standard provider bundle expose specialized task decorators that create provider-specific operator instances (for example @task.bash creates a BashOperator-like task; @task.docker maps to DockerOperator behavior). These were added/expanded through Airflow 2.x/2.9+ and are available in 3.x via the providers packages. Use them when you want operator-specific features with TaskFlow syntax.
Apache Airflow
+1

from airflow.sdk import dag, task
import pendulum

@dag(schedule=None, start_date=pendulum.datetime(2025,1,1))
def provider_decorators():
    @task.bash(env={"MY_VAR": "Hello"})
    def say():
        return "echo $MY_VAR"

    say()

provider_decorators()


Note: the exact set of @task.<provider> decorators available depends on which provider packages you have installed (e.g., apache-airflow-providers-docker, apache-airflow-providers-standard). See the provider docs for a full list.
Apache Airflow
+1

7) @setup and @teardown (setup / teardown tasks)

Special decorators to mark tasks that must run before (setup) or after (teardown) tasks within the DAG/TaskGroup; useful for resource initialization and guaranteed cleanup. Teardown can be configured to run or not depending on upstream outcomes.
Apache Airflow
+1

from airflow.sdk import dag, task, setup, teardown
import pendulum

@dag(schedule=None, start_date=pendulum.datetime(2025,1,1))
def setup_teardown_dag():
    @setup
    def provision():
        print("provision resources")

    @task
    def worker():
        print("work")

    @teardown
    def cleanup():
        print("cleanup")

    provision() >> worker() >> cleanup()

setup_teardown_dag()

8) @task.*.override() (operator arg overrides)

Not a separate decorator but a pattern: decorated tasks expose .override(...) so you can change operator-level kwargs (queue, pool, retries, executor_config) programmatically after decoration. See TaskFlow docs for .override().
Apache Airflow

from airflow.sdk import task

@task
def heavy(x): return x

heavy.override(retries=3, pool="heavy_pool")

Quick summary / pointers

Minimal core list you’ll use most: @dag, @task, @task.branch, @task.sensor, @task_group, and @setup / @teardown.
Apache Airflow
+3
Apache Airflow
+3
Apache Airflow
+3

Provider-specific decorated tasks (e.g. @task.bash, @task.docker, @task.virtualenv, @task.spark, etc.) are implemented in provider packages — install the provider and check its docs/examples.
Apache Airflow
+1

Prefer airflow.sdk imports in Airflow 3.x (examples above use airflow.sdk). If you see airflow.decorators in older docs, map to airflow.sdk in 3.x.
Apache Airflow

```
