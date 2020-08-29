import { MongoMemoryServer } from "mongodb-memory-server";
import mongooseLoader from "../../src/loaders/mongoose";
import mongoose from "mongoose";
import dataset from "./dataset";

const mongod = new MongoMemoryServer({
    instance: { dbName: "katia-test" }
});

/**
 * @description Create a new Db instance
 * @return {Promise<Db>} A Promise of Db instance
 */
export async function connect() {
  const uri = await mongod.getUri();
  await mongooseLoader(uri);
}

/**
 * @description Disconnect from MongoDb
 */
export async function disconnect() {
    await mongoose.disconnect();
}

/**
 * @description Load dataset to MongoDb
 */
export async function loadDataset() {
    await dataset.load();
}

/**
 * @description Clear all collections
 */
export async function resetDb() {
    const collections = mongoose.connection.collections;

    for (const key in collections) {
        const collection = collections[key];
        await collection.deleteMany({});
    }
}