package com.example;

import com.microsoft.azure.functions.*;
import com.microsoft.azure.functions.annotation.*;

import com.azure.identity.DefaultAzureCredential;
import com.azure.identity.DefaultAzureCredentialBuilder;

import com.azure.cosmos.*;
import com.azure.cosmos.models.*;

import java.util.Optional;
import java.time.Instant;
import java.util.UUID;

public class CosmosFunction {

    @FunctionName("WriteCosmos")
    public HttpResponseMessage run(
            @HttpTrigger(
                    name = "req",
                    methods = {HttpMethod.POST},
                    authLevel = AuthorizationLevel.FUNCTION)
            HttpRequestMessage<Optional<String>> request,
            final ExecutionContext context) {

        try {

            String endpoint = System.getenv("COSMOSDB_ENDPOINT");
            String databaseName = System.getenv("COSMOSDB_DATABASE_NAME");
            String containerName = System.getenv("COSMOSDB_CONTAINER_NAME");

            // Managed Identity Credential
            DefaultAzureCredential credential =
                    new DefaultAzureCredentialBuilder().build();

            // Cosmos Client with AAD authentication
            CosmosClient client = new CosmosClientBuilder()
                    .endpoint(endpoint)
                    .credential(credential)
                    .consistencyLevel(ConsistencyLevel.EVENTUAL)
                    .buildClient();

            CosmosDatabase database = client.getDatabase(databaseName);
            CosmosContainer container = database.getContainer(containerName);

            String message = request.getBody().orElse(
                    "Hello from Azure Function to Cosmos DB"
            );

            // Item to insert
            CosmosItem item = new CosmosItem(
                    UUID.randomUUID().toString(),
                    message,
                    Instant.now().toString()
            );

            container.createItem(item);

            return request.createResponseBuilder(HttpStatus.OK)
                    .body("Document written successfully to Cosmos DB")
                    .build();

        } catch (Exception e) {
            context.getLogger().severe("WriteCosmos error: " + e.getMessage());

            return request.createResponseBuilder(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(e.getMessage())
                    .build();
        }
    }

    // Simple POJO class for document
    public static class CosmosItem {
        public String id;
        public String message;
        public String createdAt;

        public CosmosItem(String id, String message, String createdAt) {
            this.id = id;
            this.message = message;
            this.createdAt = createdAt;
        }
    }
}
