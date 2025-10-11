# Asset is a logical representation of data hat DAGs can produce or consume
In Apache Airflow 3.x (including 3.1), an Asset is a logical representation of data (or a data product) that DAGs can produce or consume. The concept evolves from what was earlier called a Dataset in Airflow 2.x.

### What Is an Asset?

An asset is a data object or output (e.g., a file, table, model, report) that is maintained, updated, or consumed by your workflows. 

Assets allow you to declare data dependencies between workflows (DAGs) in terms of data, not just task-level wiring. 

When an asset is updated (or an “asset event” occurs), Airflow can trigger downstream DAGs that depend on that asset. This enables event- or data-driven scheduling.

### Why Use Assets?

| Problem / limitation in task-centric Airflow         | How Assets help                                                                         |
| ---------------------------------------------------- | --------------------------------------------------------------------------------------- |
| Hard to see “which data changed, when?”              | Assets provide lineage and visibility over data products                                |
| DAGs may run before data upstream is fresh           | DAGs can be scheduled to run when assets they depend on are updated                     |
| Wiring between DAGs is manual and brittle            | Defining assets lets dependencies be inferred from data flows                           |
| Hard to combine event-driven + time-based scheduling | Assets support complex scheduling expressions (AND, OR, aliasing) ([Apache Airflow][1]) |

[1]: https://airflow.apache.org/docs/apache-airflow/stable/authoring-and-scheduling/asset-scheduling.html?utm_source=chatgpt.com "Asset-Aware Scheduling — Airflow 3.0.3 Documentation"

### An Asset is a collection of related data:
A table in a DB
A Persisted ML Model
A report
A directory
The output of an API
A file


