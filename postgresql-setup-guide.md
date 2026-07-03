# PostgreSQL User Setup Guide

## Prerequisites

Before running any commands, confirm your cluster is running and owned by the `postgres` system user:

```bash
sudo pg_lsclusters
```

Expected output should show your cluster with a **online** status. If it shows `down`, start it first:

```bash
sudo pg_ctlcluster <version> main start
# Example:
sudo pg_ctlcluster 16 main start
```

## Check Existing Roles

Connect to the PostgreSQL console as the `postgres` system user and list all roles:

```bash
sudo -u postgres psql
```

Inside the psql shell:

```sql
\du
```

To exit the shell:

```sql
\q
```

## Creating or Updating a User Role

### Option 1 — Fresh Setup (User Does Not Exist Yet)

Use this if you wiped the database or are starting from scratch. Run directly from your terminal:

```bash
sudo -u postgres psql -c "CREATE USER aa WITH PASSWORD 'your_strong_password';"
```

**To grant full admin privileges (superuser):**

```bash
sudo -u postgres psql -c "CREATE USER aa WITH SUPERUSER PASSWORD 'your_strong_password';"
```

> ⚠️ **Security note:** Only grant `SUPERUSER` if absolutely necessary (e.g., Rails migrations that need to create extensions). For most apps, prefer limited privileges.

---

### Option 2 — User Already Exists (Update Password)

If the user `aa` is already created, just update the password:

```bash
sudo -u postgres psql -c "ALTER USER aa WITH PASSWORD 'your_strong_password';"
```

---

## Connecting via psql to Verify

After creating the user, test the connection:

```bash
psql -U aa -d postgres -h 127.0.0.1
```

> Using `-h 127.0.0.1` forces a **TCP connection**, which requires password authentication. Without it, PostgreSQL may use peer auth (Unix socket) and bypass the password.

---

## Important: Password Security

The examples in this guide use `1234` as a placeholder. **Never use weak passwords in real projects.** Use a strong password, especially if your database will be accessible over a network.

**Recommended approach — use environment variables in your app:**

For Rails `database.yml`:

```yaml
default: &default
  adapter: postgresql
  username: aa
  password: <%= ENV['DB_PASSWORD'] %>
  host: localhost
```

Set the env variable in your shell or a `.env` file (with a gem like `dotenv-rails`):

```bash
export DB_PASSWORD=your_strong_password
```

## Quick Reference

| Task                  | Command                                            |
| --------------------- | -------------------------------------------------- |
| Check cluster status  | `sudo pg_lsclusters`                               |
| Open psql as postgres | `sudo -u postgres psql`                            |
| List all roles        | `\du` (inside psql)                                |
| Create new user       | `CREATE USER name WITH PASSWORD 'pass';`           |
| Grant superuser       | `CREATE USER name WITH SUPERUSER PASSWORD 'pass';` |
| Update password       | `ALTER USER name WITH PASSWORD 'pass';`            |
| Test connection       | `psql -U name -d postgres -h 127.0.0.1`            |
