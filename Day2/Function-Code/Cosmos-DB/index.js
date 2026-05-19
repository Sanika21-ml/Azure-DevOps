const { DefaultAzureCredential } = require("@azure/identity");
const { CosmosClient } = require("@azure/cosmos");

module.exports = async function (context, req) {
  try {
    const endpoint = process.env.COSMOSDB_ENDPOINT;
    const databaseName = process.env.COSMOSDB_DATABASE_NAME;
    const containerName = process.env.COSMOSDB_CONTAINER_NAME;

    const credential = new DefaultAzureCredential();

    const client = new CosmosClient({
      endpoint,
      aadCredentials: credential
    });

    const database = client.database(databaseName);
    const container = database.container(containerName);

    const item = {
      id: `${Date.now()}`,
      message: req.body?.message || "Hello from Azure Function to Cosmos DB",
      createdAt: new Date().toISOString()
    };

    const { resource } = await container.items.create(item);

    context.res = {
      status: 200,
      body: {
        message: "Document written successfully to Cosmos DB",
        item: resource
      }
    };
  } catch (error) {
    context.log.error("WriteCosmos error:", error);
    context.res = {
      status: 500,
      body: error.message
    };
  }
};