import "reflect-metadata";
import Container, { ObjectType } from "typedi";

export function setupModels(modelNames: string[]) {
    // const models = modelNames.map(name => ({name: name, value: require("../../src/models/user").default}))
    // models.forEach(model => Container.set(model.name, model.value))
    Container.set("userModel", require("../../src/models/user").default)
    Container.set("mediaModel", require("../../src/models/media").default)
}

/**
 * @description Retrieves a component by name or type from Container
 * @param {ObjectType<T>} componentType 
 * @return {T} Type of the component
 */
export function getComponent<T>(componentType: ObjectType<T>) {
    return Container.get(componentType)
}

/**
 * @description Remove all registered services and handlers from the Container
 */
export function resetContainer() {
    Container.reset()
}