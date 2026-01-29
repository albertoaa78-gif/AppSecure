import { drizzle } from "drizzle-orm/node-postgres";
import pg from "pg";
import * as schema from "@shared/schema";

const { Pool } = pg;

// If DATABASE_URL is not provided, we won't initialize Postgres.
// Higher-level modules can check for `db` being undefined and
// provide an in-memory fallback for local development / preview.
if (!process.env.DATABASE_URL) {
  console.warn(
    "DATABASE_URL not set, running without Postgres. Using in-memory storage for development.",
  );
}

export const pool = process.env.DATABASE_URL
  ? new Pool({ connectionString: process.env.DATABASE_URL })
  : undefined;

export const db = pool ? drizzle(pool, { schema }) : undefined;
