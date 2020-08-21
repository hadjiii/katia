import mongoose from 'mongoose';

export async function create<I>(input: { [key: string]: any }, model: mongoose.Model<mongoose.Document>) {
  return model.create(input) as Promise<I & mongoose.Document>;
}

export async function findOne<I>(filters: { [property: string]: any }, model: mongoose.Model<mongoose.Document>) {
  return model.findOne(filters).exec() as Promise<I & mongoose.Document>;
}

export async function findMany<I>(filters: { [property: string]: any }, model: mongoose.Model<mongoose.Document>) {
  return model.find(filters).exec() as Promise<(I & mongoose.Document)[]>;
}

export async function updateOne<I>(
  filters: { [property: string]: any },
  values: { [property: string]: any },
  model: mongoose.Model<mongoose.Document>,
) {
  return model.findOneAndUpdate(filters, values).exec() as Promise<I & mongoose.Document>;
}

export async function deleteOne<I>(filters: { [property: string]: any }, model: mongoose.Model<mongoose.Document>) {
  return model.findOneAndDelete(filters).exec() as Promise<I & mongoose.Document>;
}

export async function deleteMany<I>(filters: { [property: string]: any }, model: mongoose.Model<mongoose.Document>) {
  return model.deleteMany(filters).exec() as Promise<I & mongoose.Document>;
}
