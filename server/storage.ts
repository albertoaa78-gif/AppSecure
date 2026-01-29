import { db } from "./db";
import {
  inquiries,
  services,
  type InsertInquiry,
  type InsertService,
  type Inquiry,
  type Service,
} from "@shared/schema";
import { eq } from "drizzle-orm";

export interface IStorage {
  createInquiry(inquiry: InsertInquiry): Promise<Inquiry>;
  getServices(): Promise<Service[]>;
  createService(service: InsertService): Promise<Service>;
}

export class DatabaseStorage implements IStorage {
  async createInquiry(insertInquiry: InsertInquiry): Promise<Inquiry> {
    // db is expected to be initialized when using DatabaseStorage
    if (!db) throw new Error("Database not initialized");
    const [inquiry] = await db.insert(inquiries).values(insertInquiry).returning();
    return inquiry;
  }

  async getServices(): Promise<Service[]> {
    if (!db) throw new Error("Database not initialized");
    return await db.select().from(services);
  }

  async createService(insertService: InsertService): Promise<Service> {
    if (!db) throw new Error("Database not initialized");
    const [service] = await db.insert(services).values(insertService).returning();
    return service;
  }
}

// Simple in-memory storage fallback used when no DATABASE_URL is provided.
class InMemoryStorage implements IStorage {
  private services: Service[] = [];
  private inquiries: Inquiry[] = [];
  private nextServiceId = 1;
  private nextInquiryId = 1;

  async createInquiry(insertInquiry: InsertInquiry): Promise<Inquiry> {
    const inquiry: Inquiry = {
      id: this.nextInquiryId++,
      name: insertInquiry.name,
      email: insertInquiry.email,
      phone: insertInquiry.phone ?? null,
      message: insertInquiry.message,
      createdAt: new Date(),
    } as unknown as Inquiry;
    this.inquiries.push(inquiry);
    return inquiry;
  }

  async getServices(): Promise<Service[]> {
    return this.services;
  }

  async createService(insertService: InsertService): Promise<Service> {
    const service: Service = {
      id: this.nextServiceId++,
      title: insertService.title,
      description: insertService.description,
      category: insertService.category,
      icon: insertService.icon,
    } as unknown as Service;
    this.services.push(service);
    return service;
  }
}

export const storage: IStorage = db ? new DatabaseStorage() : new InMemoryStorage();
