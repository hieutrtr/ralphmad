---
name: 'step-02-infrastructure-gaps'
description: 'Identify infrastructure, platform services, and DevOps setup that stories assume exist but no story provisions'

nextStepFile: './step-03-dependency-gaps.md'
outputFile: '{planning_artifacts}/gaps-analysis-report-{{date}}.md'
---

# Step 2: Infrastructure & Platform Gaps

## STEP GOAL:

To identify every piece of infrastructure, platform service, and DevOps tooling that stories assume exists but no story explicitly provisions. These are the "Day 0" gaps — things that must exist before any story can start.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- 🛑 NEVER generate content without user input
- 📖 CRITICAL: Read the complete step file before taking any action
- 🔄 CRITICAL: When loading next step with 'C', ensure entire file is read
- 📋 YOU ARE A FACILITATOR, not a content generator
- ✅ YOU MUST ALWAYS SPEAK OUTPUT In your Agent communication style with the config `{communication_language}`

### Role Reinforcement:

- ✅ You are a Staff Engineer who has deployed multi-service platforms
- ✅ You know that code cannot run without infrastructure
- ✅ You are skeptical of "it just works" — every dependency must be provisioned
- ✅ Success is measured in finding gaps BEFORE devs hit blockers

### Step-Specific Rules:

- 🎯 Focus ONLY on infrastructure and platform-level gaps
- 🚫 Don't analyze story quality or FR coverage (other steps)
- 💬 For each gap, cite the story that assumes it and the architecture ref that defines it
- 🚪 Categorize by severity: blocks all stories, blocks specific epics, or nice-to-have

## INFRASTRUCTURE GAP ANALYSIS PROCESS:

### 1. Extract Architecture Infrastructure Requirements

From the Architecture document, list ALL infrastructure components mentioned:

**Compute & Orchestration:**
- Kubernetes cluster (type, configuration)
- Container registry (Artifact Registry, ECR, etc.)
- Service mesh (Istio, Linkerd)
- Namespace management

**Data Stores:**
- Databases (PostgreSQL, etc.) — provisioning, not schema
- Caching (Redis) — deployment, not application config
- Search engines (Elasticsearch) — cluster setup
- Message brokers (NATS, Kafka, Redis Streams)

**Networking & Security:**
- API Gateway (Kong, etc.) — deployment and base config
- Load balancers
- TLS/mTLS certificate management
- Secrets management (Vault, K8s Secrets, cloud KMS)
- OPA/policy engine deployment

**Observability:**
- Metrics (Prometheus, Grafana)
- Logging (Fluentd, ELK)
- Tracing (OpenTelemetry collector, Jaeger/Langfuse)
- Alerting rules

**CI/CD & DevOps:**
- Container build pipeline (Dockerfile templates, build automation)
- Deployment tooling (Helm, Kustomize, Skaffold)
- Local development environment (Docker Compose)
- Image promotion between environments

### 2. Check Each Component Against Stories

For each infrastructure component identified:

1. Search ALL stories for explicit provisioning of this component
2. Determine if any story has acceptance criteria that CREATE or DEPLOY this component
3. Note stories that ASSUME this component exists (use it without creating it)

Classification:

- **PROVISIONED:** A story explicitly creates/deploys this — no gap
- **PARTIALLY PROVISIONED:** A story mentions it but doesn't fully cover setup — partial gap
- **ASSUMED:** Stories use it but no story creates it — **GAP**
- **NOT REFERENCED:** Architecture mentions it but no story uses or creates it — potential gap or deferred

### 3. Document Infrastructure Gaps

For each gap found, document:

```markdown
### Gap I-{N}: {Component Name}

**Severity:** [Critical/High/Medium/Low]
**Architecture Ref:** [AR-XX or section reference]
**Assumed By:** [List stories that assume this exists]
**What's Missing:** [Specific description of what needs to be provisioned]
**Recommendation:** [Add to existing story X, or create new Story Y.Z]
```

### 4. Special Checks

#### A. "First Story" Viability Test

Take Epic 1, Story 1 (or whatever the first story is):
- Can a developer ACTUALLY start this story from a fresh git clone?
- What must exist before they can even begin?
- Is there a gap between "git clone" and "run first story"?

#### B. Environment Parity Check

- Local dev (Docker Compose) — is setup covered?
- Staging/CI environment — who provisions it?
- Production — who provisions it?
- Are there gaps in any environment tier?

#### C. Container Image Lifecycle

- Who builds container images for services?
- Where are they stored?
- How are they deployed to K8s?
- Is there a story for the build/push/deploy pipeline?

### 5. Append to Report

Append to {outputFile}:

```markdown
## Infrastructure & Platform Gaps

### Infrastructure Inventory

| Component | Architecture Ref | Story Coverage | Status |
|---|---|---|---|
| [component] | [AR-XX] | [Story X.Y or NONE] | [Provisioned/Gap] |

### Identified Gaps

[All Gap I-{N} entries from section 3]

### First Story Viability

[Results of section 4A check]

### Environment Parity

[Results of section 4B check]

### Container Lifecycle

[Results of section 4C check]
```

### 6. Present MENU OPTIONS

Display: **Select an Option:** [C] Continue to Dependency Gap Analysis

#### Menu Handling Logic:

- IF C: Update frontmatter, then read fully and follow: {nextStepFile}
- IF other: Address user questions, then redisplay menu

---

## 🚨 SYSTEM SUCCESS/FAILURE METRICS

### ✅ SUCCESS:

- Every architecture infrastructure component checked against stories
- Clear gap/no-gap determination for each
- Gaps documented with severity, evidence, and recommendation
- First-story viability test performed

### ❌ SYSTEM FAILURE:

- Only checking obvious infrastructure (K8s, DB) and missing subtle ones (secrets, certs, OPA)
- Not citing specific stories that assume infrastructure
- Missing the "Day 0" problem entirely
- Not checking environment parity
