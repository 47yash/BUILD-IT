# Table Roles, Key Columns, and Uses

## `project`
| Column        | Description                           |
|---------------|---------------------------------------|
| `id`          | Unique identifier for the project.    |
| `pkey`        | Project key (e.g., "PROJ1").            |
| `name`        | Name of the project.                  |
| `description` | Description of the project.           |

**Use**: 
- The `project` table stores information about individual projects in Jira. 
- It helps in organizing and categorizing issues under different projects.
- Used to retrieve details about projects and to associate issues with specific projects.

## `priority`
| Column        | Description                           |
|---------------|---------------------------------------|
| `id`          | Unique identifier for the priority.   |
| `name`        | Name of the priority (e.g., "High").   |
| `description` | Description of the priority level.    |

**Use**: 
- The `priority` table defines various levels of issue priority (e.g., High, Medium, Low).
- Used to categorize and sort issues based on their importance.
- Allows users to filter and prioritize issues based on their urgency.

## `status`
| Column        | Description                           |
|---------------|---------------------------------------|
| `id`          | Unique identifier for the status.     |
| `name`        | Name of the status (e.g., "To Do").   |
| `description` | Description of the status.            |

**Use**: 
- The `status` table contains the statuses an issue can have (e.g., To Do, In Progress, Done).
- Helps track the lifecycle of issues by updating and querying their current state.
- Allows for filtering and reporting issues based on their status.

## `user`
| Column        | Description                           |
|---------------|---------------------------------------|
| `user_key`    | Unique identifier for the user (e.g., username). |
| `display_name`| Display name of the user.             |
| `email_address`| Email address of the user.            |
| `active`      | Indicates if the user account is active. |

**Use**: 
- The `user` table stores information about users who interact with Jira.
- Used for assigning issues to users, tracking who reported or is working on issues, and managing user accounts.
- Provides user-related information for notifications and user-specific queries.

## `jiraissue`
| Column        | Description                           |
|---------------|---------------------------------------|
| `id`          | Unique identifier for the issue.      |
| `summary`     | Brief summary of the issue.           |
| `description` | Detailed description of the issue.    |
| `status_id`   | References the `status` table to indicate the issue's status. |
| `priority_id` | References the `priority` table to indicate the issue's priority. |
| `project_id`  | References the `project` table to specify the project. |
| `reporter_key`| References the `user` table to show the issue reporter. |
| `assignee_key`| References the `user` table to show the issue assignee. |
| `created`     | Timestamp when the issue was created. |
| `updated`     | Timestamp when the issue was last updated. |

**Use**: 
- The `jiraissue` table holds all information about individual issues or tickets.
- Essential for tracking issues' details, statuses, priorities, and assignments.
- Central to issue management and querying within Jira.

## `customfield`
| Column        | Description                           |
|---------------|---------------------------------------|
| `id`          | Unique identifier for the custom field.|
| `name`        | Name of the custom field.             |
| `description` | Description of the custom field.      |

**Use**: 
- The `customfield` table defines additional fields that can be used to store extra data on issues.
- Allows customization of the issue tracking process by adding fields specific to the needs of different projects or teams.

## `customfieldvalue`
| Column           | Description                               |
|------------------|-------------------------------------------|
| `id`             | Unique identifier for the custom field value. |
| `customfield_id` | References the `customfield` table to specify the custom field. |
| `issue_id`       | References the `jiraissue` table to link the value to an issue. |
| `value`          | Value of the custom field for the issue.  |

**Use**: 
- The `customfieldvalue` table stores the values for custom fields associated with issues.
- Facilitates the tracking and reporting of additional data on issues based on the custom fields defined.

## `changegroup`
| Column        | Description                           |
|---------------|---------------------------------------|
| `id`          | Unique identifier for the change group.|
| `issue_id`    | References the `jiraissue` table to indicate the issue being changed. |
| `author_key`  | Key of the user who made the changes (no foreign key). |
| `created`     | Timestamp when the change group was created. |

**Use**: 
- The `changegroup` table records changes made to issues, grouping them by the time they were made.
- Helps in tracking the history of changes for an issue and identifying who made those changes.

## `changeitem`
| Column        | Description                           |
|---------------|---------------------------------------|
| `id`          | Unique identifier for the change item.|
| `group_id`    | References the `changegroup` table to link the change item to a change group. |
| `field`       | Field that was changed (e.g., status).|
| `old_value`   | Previous value of the field.          |
| `new_value`   | New value of the field.               |

**Use**: 
- The `changeitem` table details specific changes within a change group, such as field modifications.
- Essential for auditing and reviewing the history of changes made to issues.
