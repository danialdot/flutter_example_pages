class UserResponseResult {
	constructor({ id, username, image }) {
		this.id = id;
		this.username = username;
		this.image = image;
	}

	toJson() {
		return {
			id: this.id,
			username: this.username,
			image: this.image,
		};
	}
}

class UserResponse extends Response {
	constructor(status, error, timestamp, result) {
		const body = {
			status: status,
			error: error,
			timestamp: timestamp,
			result: result,
		};

		super(JSON.stringify(body), {
			headers: { 'Content-Type': 'application/json' },
		});
	}
}

addEventListener('fetch', (event) => {
	event.respondWith(handleRequest(event.request));
});

async function handleRequest(request) {
	if (request.method === 'GET' && request.url.endsWith('/api/v1/user')) {
		try {
			const authorizationHeader = request.headers.get('Authorization');
			if (!authorizationHeader || !authorizationHeader.startsWith('Bearer ')) {
				// If "Authorization" header is missing or token is not in the correct format
				return new UserResponse(401, 'Unauthorized', Date.now(), null);
			}

			const token = authorizationHeader.substring('Bearer '.length);
			const username = await getUsernameFromToken(token);

			if (!username) {
				// Invalid or tampered token
				return new UserResponse(401, 'Unauthorized', Date.now(), null);
			}
			// // Assuming your token contains the username in the payload, parse it appropriately
			// const decodedToken = parseToken(token);

			// if (!decodedToken || !decodedToken.username) {
			// 	// If the token is invalid or does not contain the username
			// 	return new UserResponse(401, 'Unauthorized', Date.now(), null);
			// }

			// const username = decodedToken.username;

			// Calculate the hash of the username
			var usernameHash = hashString(username);

			// Define the available images
			const availableImages = ['man-1.png', 'man-2.png', 'woman-1.png', 'woman-2.png'];

			// Select the image based on the username hash
			if (usernameHash < 0) {
				usernameHash = usernameHash * -1;
			}
			const imageIndex = usernameHash % availableImages.length;
			const image = availableImages[imageIndex];

			// Replace the following sample data with your actual data
			const userData = {
				id: '12345',
				username: username,
				image: image,
			};

			const responseResult = new UserResponseResult(userData);

			const response = new UserResponse(200, {}, Date.now(), responseResult);
			return response;
		} catch (err) {
			// Handle any potential errors during request processing
			return new UserResponse(500, 'Invalid Request', Date.now(), null);
		}
	}

	// Handle 404 for other routes
	return new Response('Not found', { status: 404 });
}

// Simple hash function to hash the username string
function hashString(str) {
	let hash = 0;
	if (str.length === 0) return hash;
	for (let i = 0; i < str.length; i++) {
		const char = str.charCodeAt(i);
		hash = (hash << 5) - hash + char;
		hash = hash & hash; // Convert to 32bit integer
	}
	return hash;
}

// Parse the token and extract the username
// function parseToken(token) {
// 	try {
// 		// Implement your token parsing logic here, assuming the token contains the necessary payload
// 		// You may use a JWT library to decode the token and extract the relevant data
// 		// For example, using jwt-decode library: https://www.npmjs.com/package/jwt-decode
// 		// Note: For security, always verify the token signature in a production environment
// 		// and handle token expiration, etc.
// 		return { username: getUsernameFromToken(token) }; // Replace this with the actual token parsing logic
// 	} catch (err) {
// 		return null;
// 	}
// }

// Helper function to compute HMAC with SHA-256
async function hmacSHA256(message, secretKey) {
	const encoder = new TextEncoder();
	const keyData = encoder.encode(secretKey);
	const messageData = encoder.encode(message);

	const cryptoKey = await crypto.subtle.importKey('raw', keyData, { name: 'HMAC', hash: 'SHA-256' }, false, ['sign']);
	const signatureBuffer = await crypto.subtle.sign('HMAC', cryptoKey, messageData);

	const signatureArray = Array.from(new Uint8Array(signatureBuffer));
	return uint8ArrayToBase64Url(signatureArray);
}

function uint8ArrayToBase64Url(array) {
	return btoa(String.fromCharCode.apply(null, array)).replace(/=/g, '').replace(/\+/g, '-').replace(/\//g, '_');
}

async function getUsernameFromToken(token) {
	const [encodedHeader, encodedToken, signature] = await token.split('.');

	const header = JSON.parse(base64urlDecode(encodedHeader));
	const payload = JSON.parse(base64urlDecode(encodedToken));

	if (header.alg !== 'HS256') {
		// Token has an unsupported algorithm
		return null;
	}

	// Validate token signature
	const secretKey = 'your-secret-key'; // Replace with your actual secret key
	const expectedSignature = await hmacSHA256(`${encodedHeader}.${encodedToken}`, secretKey);
	const decodedSignature = base64urlDecode(signature);

	if (expectedSignature !== decodedSignature) {
		// Token signature doesn't match
		return null;
	}

	// Token is valid, extract the username from the payload
	return payload.sub;
}

// Helper function to Base64 URL decode a string
function base64urlDecode(input) {
	input = input.replace(/-/g, '+').replace(/_/g, '/');
	const pad = input.length % 4;
	if (pad) {
		input += '===='.slice(pad);
	}
	return atob(input);
}
