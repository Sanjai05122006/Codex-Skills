# Database Schema
Sync with supabase/migrations/ after every migration.

## Tables

### [table_name]
| Column     | Type        | Nullable | Description          |
|------------|-------------|----------|----------------------|
| id         | uuid        | NO       | Primary key          |
| created_at | timestamptz | NO       |                      |
| org_id     | uuid        | NO       | Tenant isolation key |

## Migration Log
| File                        | Summary       |
|-----------------------------|---------------|
| 0001_initial_schema.sql     |               |
