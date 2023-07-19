class OtpResponseResult {
  constructor({ code, message }) {
    this.code = code;
    this.message = message;
  }

  toJson() {
    return {
      code: this.code,
      message: this.message,
    };
  }
}

class OtpModelResponse extends Response {
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
  if (request.method === 'POST' && request.url.endsWith('/api/v1/auth/get-otp')) {
    const requestData = await request.json();
    const { mobile } = requestData;

    // Fixed OTP value for demonstration purposes
    const generatedOtp = '000000';

    // Simulate sending OTP to the mobile number (placeholder function)
    const otpMessage = `Your OTP is: ${generatedOtp}`;
    sendOtpToMobile(mobile, otpMessage);

    const responseResult = new OtpResponseResult({
      code: generatedOtp,
      message: 'OTP sent successfully',
    });

    const response = new OtpModelResponse(200, {}, Date.now(), responseResult);
    return response;
  }

  if (request.method === 'POST' && request.url.endsWith('/api/v1/auth/login')) {
    const requestData = await request.json();
    const { otp, mobile } = requestData;

    // Replace this logic with actual login validation and response generation
    // For demonstration, let's assume the OTP validation is successful
    const isComplete = true;

    // Generate JWT tokens as example_access_token and example_refresh_token
    const accessToken = generateJwtToken({ sub: mobile });
    const refreshToken = generateJwtToken({ sub: mobile, type: 'refresh' });

    const responseResult = new LoginResponseResult({
      isComplete: isComplete,
      accessToken: accessToken,
      refreshToken: refreshToken,
    });

    const response = new LoginModelResponse(200, {}, Date.now(), responseResult);
    return response;
  }

  // Handle 404 for other routes
  return new Response('Not found', { status: 404 });
}

// Helper function to simulate sending OTP to mobile
function sendOtpToMobile(mobile, otpMessage) {
  // This is a placeholder function; replace with your actual OTP sending mechanism
  console.log(`Sending OTP to ${mobile}: ${otpMessage}`);
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
