const { DefaultAzureCredential } = require("@azure/identity");
const { BlobServiceClient } = require("@azure/storage-blob");

module.exports = async function (context, req) {
  try {
    const accountName = process.env.STORAGE_ACCOUNT_NAME;
    const containerName = process.env.STORAGE_CONTAINER_NAME;

    const credential = new DefaultAzureCredential();

    const blobServiceClient = new BlobServiceClient(
      `https://${accountName}.blob.core.windows.net`,
      credential
    );

    const containerClient = blobServiceClient.getContainerClient(containerName);

    const fileName = `sample-${Date.now()}.txt`;
    const content = req.body?.content || "Hello from Azure Function using Managed Identity";

    const blockBlobClient = containerClient.getBlockBlobClient(fileName);
    await blockBlobClient.upload(content, Buffer.byteLength(content));

    context.res = {
      status: 200,
      body: {
        message: "File created successfully in Blob Storage",
        fileName: fileName
      }
    };
  } catch (error) {
    context.log.error("WriteBlob error:", error);
    context.res = {
      status: 500,
      body: error.message
    };
  }
};