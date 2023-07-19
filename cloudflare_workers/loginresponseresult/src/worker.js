class LoginResponseResult {
  constructor({ isComplete, accessToken, refreshToken }) {
    this.isComplete = isComplete;
    this.accessToken = accessToken;
    this.refreshToken = refreshToken;
  }

  toJson() {
    return {
      isComplete: this.isComplete,
      accessToken: this.accessToken,
      refreshToken: this.refreshToken,
    };
  }
}

class LoginModelResponse extends Response {
  constructor(status, error, timestamp, result) {
    const body = {
      status: status,
      error: error,
      timestamp: timestamp,
      result: result.toJson(),
    };

    super(JSON.stringify(body), {
      headers: { 'Content-Type': 'application/json' },
    });
  }
}

addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request));
});

async function handleRequest(request) {
  if (request.method === 'POST' && request.url.endsWith('/api/v1/auth/login')) {
    const requestData = await request.json();
    const { username, password } = requestData;

    // Replace this logic with actual login validation and response generation
    const isComplete = validateUserCredentials(username, password);

    if (isComplete) {
      // User authentication successful, generate JWT tokens
      const accessToken = generateJwtToken({ sub: username });
      const refreshToken = generateJwtToken({ sub: username, type: 'refresh' });

      const responseResult = new LoginResponseResult({
        isComplete: true,
        accessToken: accessToken,
        refreshToken: refreshToken,
      });

      const response = new LoginModelResponse(200, {}, Date.now(), responseResult);
      return response;
    } else {
      // User authentication failed
      const responseResult = new LoginResponseResult({
        isComplete: false,
        accessToken: null,
        refreshToken: null,
      });

      const response = new LoginModelResponse(401, 'Unauthorized', Date.now(), responseResult);
      return response;
    }
  }

  // Handle 404 for other routes
  return new Response('Not found', { status: 404 });
}

// Helper function to generate JWT tokens
function generateJwtToken(payload) {
  // Replace 'your-secret-key' with your actual secret key in a real application
  const header = {
    alg: 'HS256', // HS256 algorithm for HMAC with SHA-256
    typ: 'JWT',
  };

  // Set the expiration time to 1 hour from the current time
  const expiresIn = 60 * 60;

  const token = {
    ...payload,
    iat: Math.floor(Date.now() / 1000),
    exp: Math.floor(Date.now() / 1000) + expiresIn,
  };

  // Encode and sign the JWT token with a secret key
  const secretKey = 'your-secret-key';
  const encodedHeader = base64urlEncode(JSON.stringify(header));
  const encodedToken = base64urlEncode(JSON.stringify(token));
  const signature = base64urlEncode(hmacSHA256(`${encodedHeader}.${encodedToken}`, secretKey));

  return `${encodedHeader}.${encodedToken}.${signature}`;
}

// Helper function to Base64 URL encode a string
function base64urlEncode(input) {
  return btoa(input)
    .replace(/=/g, '')
    .replace(/\+/g, '-')
    .replace(/\//g, '_');
}

// Helper function to compute HMAC with SHA-256
async function hmacSHA256(message, secretKey) {
  const encoder = new TextEncoder();
  const keyData = encoder.encode(secretKey);
  const messageData = encoder.encode(message);

  const cryptoKey = await crypto.subtle.importKey('raw', keyData, 'HMAC', { name: 'SHA-256' }, false);
  const signatureBuffer = await crypto.subtle.sign('HMAC', cryptoKey, messageData);

  const signatureArray = Array.from(new Uint8Array(signatureBuffer));
  return uint8ArrayToBase64Url(signatureArray);
}

// Helper function to convert Uint8Array to Base64 URL format
function uint8ArrayToBase64Url(array) {
  return btoa(String.fromCharCode.apply(null, array))
    .replace(/=/g, '')
    .replace(/\+/g, '-')
    .replace(/\//g, '_');
}

// Helper function to validate user credentials (replace with your actual logic)
function validateUserCredentials(username, password) {
  // For demonstration purposes, we assume valid credentials if the password is "password"
  return password === 'password';
}
