// Helper function to convert an array of version details to JSON
function versionsToJsonArray(versions) {
  return versions.map((version) => ({
    text: version.text,
    version: version.version,
    image: version.image,
    forced: version.forced,
  }));
}

class VersionResponseResult {
  constructor({ versions, updateIsNeeded }) {
    this.versions = versions;
    this.updateIsNeeded = updateIsNeeded;
  }

  toJson() {
    return {
      versions: versionsToJsonArray(this.versions),
      updateIsNeeded: this.updateIsNeeded,
    };
  }
}

class VersionResponse extends Response {
  constructor(status, error, timestamp, result) {
    const body = {
      status: status,
      error: error,
      timestamp: timestamp,
      result: result.toJson(),
    };

    super(JSON.stringify(body), {
      headers: { "Content-Type": "application/json" },
    });
  }
}

addEventListener("fetch", (event) => {
  event.respondWith(handleRequest(event.request));
});

async function handleRequest(request) {
  if (request.method === "POST" && request.url.endsWith("/api/v1/app-config/app-update/get-version")) {
    try {
      const requestBody = await request.json();
      const clientVersion = requestBody.version;

      // Your logic to determine the latest version and whether an update is needed
      const latestVersion = "1.0.2"; // Replace this with the actual latest version
      const isForcedUpdate = true; // Replace this with your forced update check logic

      const versions = [
        {
          text: "Version 1.0.1",
          version: "1.0.1",
          image: "updated.png",
          forced: false,
        },
        {
          text: "Version 1.0.2",
          version: "1.0.2",
          image: "updated.png",
          forced: true,
        },
      ];

      // Determine if an update is needed based on the client version and forced update status
      const updateIsNeeded = isForcedUpdate && clientVersion < latestVersion;

      const responseResult = new VersionResponseResult({
        versions: versions,
        updateIsNeeded: updateIsNeeded,
      });

      const response = new VersionResponse(200, {}, Date.now(), responseResult);
      return response;
    } catch (err) {
      // Handle any potential errors during request processing
      return new VersionResponse(400, "Bad Request", Date.now(), null);
    }
  }

  // Handle 404 for other routes
  return new Response("Not found", { status: 404 });
}
