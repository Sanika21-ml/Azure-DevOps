package com.example;

import com.microsoft.azure.functions.*;
import com.microsoft.azure.functions.annotation.*;

import com.azure.identity.DefaultAzureCredential;
import com.azure.identity.DefaultAzureCredentialBuilder;
import com.azure.storage.blob.*;
import com.azure.storage.blob.models.*;

import java.util.Optional;

public class BlobFunction {

    @FunctionName("WriteBlob")
    public HttpResponseMessage run(
            @HttpTrigger(
                    name = "req",
                    methods = {HttpMethod.POST},
                    authLevel = AuthorizationLevel.FUNCTION)
            HttpRequestMessage<Optional<String>> request,
            final ExecutionContext context) {

        try {

            String accountName = System.getenv("STORAGE_ACCOUNT_NAME");
            String containerName = System.getenv("STORAGE_CONTAINER_NAME");

            // Managed Identity Credential
            DefaultAzureCredential credential = new DefaultAzureCredentialBuilder().build();

            // Blob Service Client
            String endpoint = "https://" + accountName + ".blob.core.windows.net";

            BlobServiceClient blobServiceClient =
                    new BlobServiceClientBuilder()
                            .endpoint(endpoint)
                            .credential(credential)
                            .buildClient();

            BlobContainerClient containerClient =
                    blobServiceClient.getBlobContainerClient(containerName);

            String fileName = "sample-" + System.currentTimeMillis() + ".txt";

            String content = request.getBody().orElse(
                    "Hello from Azure Function using Managed Identity"
            );

            BlobClient blobClient = containerClient.getBlobClient(fileName);

            blobClient.upload(
                    new java.io.ByteArrayInputStream(content.getBytes()),
                    content.length(),
                    true
            );

            return request.createResponseBuilder(HttpStatus.OK)
                    .body("File created successfully: " + fileName)
                    .build();

        } catch (Exception e) {
            context.getLogger().severe("WriteBlob error: " + e.getMessage());

            return request.createResponseBuilder(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(e.getMessage())
                    .build();
        }
    }
}