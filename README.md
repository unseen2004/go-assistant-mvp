# go-assistant

Real-time AI task assistant in Go with location-based geofencing and multi-platform integrations.

## Architecture

- **Gateway Service:** The central entry point handling HTTP routes, WebSocket upgrades, and orchestrating other internal services.
- **Tasks Service:** Manages task lifecycle with persistent storage in PostgreSQL and support for location triggers.
- **Location Service:** Handles real-time location tracking and calculates proximity using the Haversine formula.
- **Notification Service:** Manages WebSocket connections via a Hub to broadcast real-time task reminders.
- **Integration Engine:** Synchronizes data with external platforms like Google Calendar and Notion.
- **AI Context Engine:** Analyzes current user context (location, time, tasks) using OpenAI GPT to provide smart suggestions.

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | /health | System health check |
| GET | /api/tasks | List all pending tasks |
| POST | /api/tasks | Create a new task |
| POST | /api/location | Record current user location |
| POST | /api/location/check | Check proximity between two points |
| GET | /ws | WebSocket endpoint for real-time notifications |
| GET | /auth/google/start | Start Google OAuth2 flow |
| GET | /auth/google/callback | Google OAuth2 callback |
| GET | /api/calendar/today | Sync today's Google Calendar events |
| GET | /api/notion/status | Check Notion integration status |
| POST | /api/notion/sync | Sync tasks from Notion database |
| GET | /api/ai/status | Check AI context engine status |
| POST | /api/ai/suggest | Get smart AI suggestions in Polish |

## Quick Start

```bash
# Clone the repository
git clone github.com/go-assistant/core
cd go-assistant

# Setup environment
cp .env.example .env

# Start with Docker Compose
make docker-up

# Verify health
make health
```

## E2E Test

Run the full "paczkomat scenario" to verify all components:

```bash
make e2e-test
```

## Kubernetes Deploy

```bash
# Deploy full stack
make k8s-deploy

# Check status
make k8s-status
```

## Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| POSTGRES_URL | PostgreSQL connection string | Yes |
| REDIS_URL | Redis connection string | Yes |
| OPENAI_API_KEY | OpenAI API Key for GPT suggestions | No (Demo mode available) |
| GMAIL_CLIENT_ID | Google Cloud Client ID | No |
| GMAIL_CLIENT_SECRET | Google Cloud Client Secret | No |
| NOTION_API_KEY | Notion Integration Token | No |
| NOTION_DATABASE_ID | Notion Database ID | No |

## Tech Stack

| Layer | Technology |
|-------|------------|
| Language | Go 1.22 |
| Database | PostgreSQL 16 |
| Cache | Redis 7 |
| Containerization | Docker & Compose |
| Orchestration | Kubernetes |
| IaC | Terraform |
| AI | OpenAI GPT-4o-mini |

