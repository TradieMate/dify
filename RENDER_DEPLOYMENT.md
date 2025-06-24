# Dify Deployment on Render

This repository has been optimized for deployment on Render. The following files and directories have been removed to reduce size and improve deployment efficiency:

## Removed Files
- Multiple language README files (README_*.md)
- Multiple language CONTRIBUTING files (CONTRIBUTING_*.md)
- `/docker/` directory (Docker configuration not needed for Render)
- `/dev/` directory (Development scripts)
- `/images/` directory (Only used in documentation)
- `/sdks/` directory (Client SDKs not needed for main app)
- Development and testing files
- `.devcontainer`, `.vscode`, `.github` directories

## Deployment Instructions

### Prerequisites
1. A Render account
2. A PostgreSQL database (can be created on Render)
3. A Redis instance (can be created on Render)

### Deployment Options

#### Option 1: Docker Deployment (Recommended)

Dify includes optimized Dockerfiles for both API and Web services.

**API Service (Python/Flask)**
1. Create a new Web Service on Render
2. Connect your GitHub repository
3. Configure the service:
   - **Root Directory**: `api`
   - **Dockerfile Path**: `api/Dockerfile`
   - **Docker Command**: Leave empty (uses ENTRYPOINT)
   - **Environment**: Docker

**Web Service (Next.js)**
1. Create a new Web Service on Render
2. Connect your GitHub repository  
3. Configure the service:
   - **Root Directory**: `web`
   - **Dockerfile Path**: `web/Dockerfile`
   - **Docker Command**: Leave empty (uses ENTRYPOINT)
   - **Environment**: Docker

#### Option 2: Native Buildpack Deployment

**API Service (Python)**
1. Create a new Web Service on Render
2. Connect your GitHub repository
3. Configure the service:
   - **Root Directory**: `api`
   - **Build Command**: `pip install -r requirements.txt`
   - **Start Command**: `python app.py`
   - **Environment**: Python 3

**Web Service (Node.js)**
1. Create a new Web Service on Render
2. Connect your GitHub repository  
3. Configure the service:
   - **Root Directory**: `web`
   - **Build Command**: `pnpm install && pnpm build`
   - **Start Command**: `pnpm start`
   - **Environment**: Node.js

### Environment Variables

#### For the API Service
Set these environment variables in your Render API service:

```bash
# Required
SECRET_KEY=your-secret-key-here
DB_USERNAME=your-db-username
DB_PASSWORD=your-db-password
DB_HOST=your-db-host
DB_PORT=5432
DB_DATABASE=dify
REDIS_HOST=your-redis-host
REDIS_PORT=6379
REDIS_PASSWORD=your-redis-password

# URLs (adjust based on your Render service URLs)
CONSOLE_API_URL=https://your-api-service.onrender.com
CONSOLE_WEB_URL=https://your-web-service.onrender.com
SERVICE_API_URL=https://your-api-service.onrender.com
APP_WEB_URL=https://your-web-service.onrender.com
FILES_URL=https://your-api-service.onrender.com
```

#### For the Web Service
Set these environment variables in your Render Web service:

```bash
# Required
NEXT_PUBLIC_DEPLOY_ENV=PRODUCTION
NEXT_PUBLIC_EDITION=SELF_HOSTED
NEXT_PUBLIC_API_PREFIX=https://your-api-service.onrender.com/console/api
NEXT_PUBLIC_PUBLIC_API_PREFIX=https://your-api-service.onrender.com/api

# Optional
NEXT_TELEMETRY_DISABLED=1
NEXT_PUBLIC_TEXT_GENERATION_TIMEOUT_MS=60000
```

### Deployment Steps

1. **Create API Service**
   - Create a new Web Service on Render
   - Connect your repository
   - Set the root directory to `api`
   - Set the build command: `pip install -r requirements.txt`
   - Set the start command: `python app.py`
   - Add all required environment variables

2. **Create Web Service**
   - Create a new Web Service on Render
   - Connect your repository
   - Set the root directory to `web`
   - Set the build command: `npm install && npm run build`
   - Set the start command: `npm start`
   - Add all required environment variables

3. **Create Database Services**
   - Create a PostgreSQL database on Render
   - Create a Redis instance on Render
   - Update the environment variables with the connection details

### Important Notes

- The API service has been configured to use the `PORT` environment variable (Render requirement)
- Both services bind to `0.0.0.0` as required by Render
- Make sure to update the URL environment variables to match your actual Render service URLs
- The web service is configured with `output: 'standalone'` for optimal Render deployment

### Post-Deployment

After deployment, you'll need to:
1. Run database migrations on the API service
2. Configure your AI model providers
3. Set up any required integrations

For more detailed configuration options, refer to the original Dify documentation.