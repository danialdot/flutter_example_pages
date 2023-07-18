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
  if (request.method === "GET" && request.url.endsWith("/api/v1/app-config/app-update/get-version")) {
    const versions = [
      {
        text: "Version 1.0.1",
        version: "1.0.1",
        image: "https://example.com/images/v1.png",
        forced: false,
      },
      {
        text: "Version 1.0.2",
        version: "1.0.2",
        image: "https://example.com/images/v2.png",
        forced: true,
      },
    ];

    const responseResult = new VersionResponseResult({
      versions: versions,
      updateIsNeeded: true, // Set this to true if an update is required
    });

    const response = new VersionResponse(200, null, Date.now(), responseResult);
    return response;
  }

  // Handle 404 for other routes
  return new Response("Not found", { status: 404 });
}
