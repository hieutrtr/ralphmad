---
name: 'step-04-cross-cutting-gaps'
description: 'Identify gaps in cross-cutting concerns — security, error handling, testing, migrations, configuration, and operational readiness'

nextStepFile: './step-05-architecture-traceability.md'
outputFile: '{planning_artifacts}/gaps-analysis-report-{{date}}.md'
---

# Step 4: Cross-Cutting Concern Gaps

## STEP GOAL:

To identify gaps in cross-cutting concerns that span multiple stories and epics — areas like security, error handling, database migrations, testing strategy, configuration management, and operational readiness that no single story fully owns but every story needs.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: Read the complete step file before taking any action
- 🔄 CRITICAL: When loading next step with 'C', ensure entire file is read
- 📋 YOU ARE A FACILITATOR, not a content generator
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

### Role Reinforcement:

- ✅ You are a Staff Engineer focused on production readiness
- ✅ Cross-cutting concerns are where most production incidents originate
- ✅ If something is "everyone's responsibility," it's no one's responsibility — find those
- ✅ Success is ensuring every cross-cutting concern has a clear owner

### Step-Specific Rules:

- 🎯 Focus ONLY on cross-cutting concerns
- 🚫 Don't repeat infrastructure gaps (Step 2) or dependency gaps (Step 3)
- 💬 For each concern, determine: who sets it up, who maintains it, who monitors it
- 🚪 A concern is a gap if no story establishes the pattern/foundation

## CROSS-CUTTING CONCERN ANALYSIS:

### 1. Security Concerns

Check if stories cover:

#### A. Secrets Management
- Where are API keys, database passwords, service credentials stored?
- Is there a secrets rotation strategy?
- Which story provisions the secrets management solution?
- Do stories reference secrets but no story sets up the store?

#### B. Authentication & Authorization Bootstrap
- SSO/OAuth provider configuration — who sets it up?
- Initial admin user creation — how does the first user get access?
- Service-to-service authentication (mTLS, service accounts)
- API key/token generation infrastructure

#### C. Network Security
- TLS certificate provisioning and renewal
- Network policies (K8s NetworkPolicy, Istio AuthorizationPolicy)
- CORS configuration
- Rate limiting infrastructure (beyond per-consumer — platform-level)

### 2. Error Handling & Resilience

Check if stories cover:

#### A. Error Handling Patterns
- Is there a story that establishes the error handling pattern (e.g., RFC 7807)?
- Do stories assume a shared error format without anyone creating it?
- Circuit breaker configuration — who sets it up?
- Retry policies — where are they defined?

#### B. Resilience Patterns
- Health check standardization across services
- Graceful degradation strategy
- Timeout configuration (client-side, server-side, gateway)
- Dead letter queues for failed async messages

### 3. Database & Migration Strategy

Check if stories cover:

#### A. Migration Infrastructure
- Migration tooling setup (Alembic, Flyway, etc.)
- Multi-schema migration orchestration
- Migration rollback strategy
- Seed data for initial setup

#### B. Data Lifecycle
- Backup and restore procedures
- Data retention policies
- Cross-schema query patterns (if needed)
- Connection pooling setup and configuration

### 4. Testing Strategy

Check if stories cover:

#### A. Test Infrastructure
- Test database provisioning (separate schema, test containers)
- Test fixtures and factories
- Integration test environment setup
- E2E test framework setup

#### B. Test Patterns
- API contract testing between services
- Load/performance testing infrastructure
- Security testing (SAST, DAST, dependency scanning)
- Smoke test suite for deployments

### 5. Configuration Management

Check if stories cover:

#### A. Application Configuration
- Environment-specific config (dev/staging/prod)
- Feature flags infrastructure
- Config change propagation (how do running services pick up config changes?)
- Default configuration for new Entities/Stages/Workspaces

#### B. Infrastructure Configuration
- Terraform/Pulumi/CDK for cloud resources
- GitOps patterns (ArgoCD, FluxCD)
- Infrastructure-as-Code — is it mentioned but not storied?

### 6. Operational Readiness

Check if stories cover:

#### A. Runbook & Operations
- On-call alerting setup
- Runbooks for common failures
- Incident response procedures
- Capacity planning and scaling thresholds

#### B. Documentation
- API documentation generation (OpenAPI/Swagger)
- Developer onboarding documentation
- Architecture decision records (ADRs)

### 7. Document Gaps

For each cross-cutting gap found:

```markdown
### Gap C-{N}: {Concern Name}

**Category:** [Security/Error Handling/Database/Testing/Config/Operations]
**Severity:** [Critical/High/Medium/Low]
**What's Missing:** [Description of the gap]
**Assumed By:** [Stories that assume this is handled]
**Owned By:** No story currently
**Recommendation:** [Add to existing story or create dedicated story]
```

### 8. Append to Report

Append to {outputFile}:

```markdown
## Cross-Cutting Concern Gaps

### Concern Coverage Matrix

| Concern | Setup Story | Maintenance | Monitoring | Status |
|---|---|---|---|---|
| [concern] | [story or NONE] | [story or NONE] | [story or NONE] | [Covered/Gap] |

### Identified Gaps

[All Gap C-{N} entries from section 7]

### Summary

- Total cross-cutting concerns analyzed: [count]
- Fully covered: [count]
- Partially covered: [count]
- Not covered (gaps): [count]
```

### 9. Present MENU OPTIONS

Display: **Select an Option:** [C] Continue to Architecture Traceability

#### Menu Handling Logic:

- IF C: Update frontmatter, then read fully and follow: {nextStepFile}
- IF other: Address user questions, then redisplay menu

---

## 🚨 SYSTEM SUCCESS/FAILURE METRICS

### ✅ SUCCESS:

- All 6 cross-cutting categories analyzed
- Gaps documented with clear ownership problem
- Recommendations are specific and actionable
- Severity accurately reflects production impact

### ❌ SYSTEM FAILURE:

- Only checking security and missing other categories
- Not checking if patterns are established (vs. just used)
- Treating "mentioned in architecture" as "covered in stories"
- Not identifying the ownership vacuum
