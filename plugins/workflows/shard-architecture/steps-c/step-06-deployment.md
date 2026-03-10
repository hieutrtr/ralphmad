---
name: 'step-06-deployment'
description: 'Produce 05-deployment-architecture.md — K8s resources, Helm, CI/CD, deployment strategies, DR, IaC'

nextStepFile: './step-07-network.md'
outputFile: '{output_folder}/05-deployment-architecture.md'
outputDocTemplate: '../templates/output-doc-template.md'
contentMapFile: '{output_folder}/content-map-{source_name}.md'
gapReportFile: '{output_folder}/gap-report-{source_name}.md'
mermaidStandards: '../data/mermaid-diagram-standards.md'
outputDocChecklist: '../data/output-doc-checklist.md'
advancedElicitationTask: '{project-root}/_bmad/core/workflows/advanced-elicitation/workflow.xml'
partyModeWorkflow: '{project-root}/_bmad/core/workflows/party-mode/workflow.md'
---

# Step 6: Deployment Architecture

## STEP GOAL:

To produce `05-deployment-architecture.md` containing infrastructure topology diagrams, Kubernetes resource specifications, container image strategy, Helm chart structure, CI/CD pipeline, deployment strategies, environment topology, resource sizing, health checks, local development setup, disaster recovery procedures, and Infrastructure as Code definitions.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- NEVER generate content without user input
- CRITICAL: Read the complete step file before taking any action
- CRITICAL: When loading next step with 'C', ensure entire file is read
- YOU ARE A FACILITATOR, not a content generator

### Role Reinforcement:

- You are an Architecture Document Specialist producing the deployment view
- We engage in collaborative dialogue, not command-response
- You bring expertise in Kubernetes, Helm, CI/CD pipelines, and infrastructure patterns
- User brings context about their infrastructure constraints, cloud provider, and deployment preferences

### Step-Specific Rules:

- Focus ONLY on deployment — no application design, network specifics, or database internals
- FORBIDDEN to modify the source architecture document
- ALL diagrams must use valid Mermaid syntax per {mermaidStandards}
- EXPAND beyond the source — add resource specifications, health check details, DR procedures
- Include concrete resource values (CPU, memory) not just "appropriate sizing"

## EXECUTION PROTOCOLS:

- Read the content map for deployment-related source sections
- Load Mermaid and output doc standards
- Generate each required section
- Present the complete draft for user review
- FORBIDDEN to load next step until user selects 'C'

## CONTEXT BOUNDARIES:

- Available: content map, source doc, all previous output docs (01-04)
- Focus: deployment and infrastructure only
- Dependencies: container list from 01-high-level-design.md, tech stack from 02-tech-stack.md

## MANDATORY SEQUENCE

**CRITICAL:** Follow this sequence exactly. Do not skip, reorder, or improvise.

### 1. Load Context

Read {contentMapFile} for source sections mapped to "05 Deployment."
Load {mermaidStandards} and {outputDocChecklist} section "05 — Deployment Architecture."
Read container list from 01-high-level-design.md and technology versions from 02-tech-stack.md.

### 2. Infrastructure Topology Diagram

Produce a Mermaid diagram showing:
- Kubernetes cluster(s)
- Namespaces (per tenant, per service group, system namespaces)
- Deployments/StatefulSets per namespace
- Services (ClusterIP, NodePort, LoadBalancer)
- Ingress controllers
- Persistent volumes
- External managed services (cloud databases, cache, object storage)

### 3. Kubernetes Resource Specifications

For each workload:

| Workload | Kind | Replicas | CPU Req | CPU Limit | Mem Req | Mem Limit | Storage | HPA Min/Max |
|----------|------|----------|---------|-----------|---------|-----------|---------|-------------|

Include PodDisruptionBudget (PDB) specifications for critical services.

### 4. Container Image Strategy

Document:
- Base images per language/runtime (e.g., python:3.12-slim, node:22-alpine)
- Multi-stage build pattern (builder → runtime)
- Image registry (private registry, tagging strategy: git-sha, semver)
- Image scanning integration (Trivy, Snyk, etc.)
- Image pull policies

### 5. Helm Chart Structure

```
deploy/helm/
├── Chart.yaml
├── values.yaml
├── values-dev.yaml
├── values-staging.yaml
├── values-prod.yaml
├── templates/
│   ├── {per-service templates}
└── charts/
    ├── {dependency charts}
```

Document:
- Chart hierarchy (umbrella chart vs per-service charts)
- values.yaml schema (key configuration knobs)
- Environment-specific overrides

### 6. CI/CD Pipeline Architecture

Produce a Mermaid flowchart showing pipeline stages:

Stages: Lint → Test → Build → Scan → Deploy (per environment) → Smoke Test → Promote

For each stage:
| Stage | Tool | Trigger | Duration Target | Artifacts |
|-------|------|---------|----------------|-----------|

### 7. Deployment Strategies

| Strategy | When Used | Rollback Procedure | Risk Level |
|----------|-----------|-------------------|-----------|
| Blue/Green | | | |
| Canary | | | |
| Rolling Update | | | |

Include: rollback triggers, health check gates, traffic shifting percentages.

### 8. Environment Topology

| Environment | Purpose | Cluster | Namespace | Data | Access |
|------------|---------|---------|-----------|------|--------|
| Local Dev | | Docker Compose | N/A | Seed data | localhost |
| Dev | | | | | |
| Staging | | | | | |
| Production | | | | | |

Document promotion flow: dev → staging → production with approval gates.

### 9. Resource Sizing

Per service, document:
- Baseline resource allocation (CPU/memory)
- HPA scaling thresholds (CPU%, custom metrics)
- Peak load estimates
- Vertical scaling limits

### 10. Health Checks

| Service | Liveness | Readiness | Startup | Probe Type | Interval | Timeout | Failure Threshold |
|---------|----------|-----------|---------|-----------|----------|---------|-------------------|

### 11. Local Development Setup

Document:
- Docker Compose service definitions
- Service dependency graph (what depends on what)
- Seed data and migration strategy
- Hot-reload configuration
- Port mapping and local URLs

### 12. Disaster Recovery

| Metric | Target | Strategy |
|--------|--------|---------|
| RTO | | |
| RPO | | |

Document: backup schedule, restore procedures, failover steps, DR testing cadence.

### 13. Infrastructure as Code

Document Terraform/Pulumi modules:
| Module | Resources | Provider | State Backend |
|--------|-----------|----------|--------------|

### 14. Assemble and Present Draft

Assemble all sections into {outputFile} using {outputDocTemplate}.

"**05 — Deployment Architecture (Draft)**

{present the complete document}

**Checklist:**
{list each required section from outputDocChecklist with pass/fail}

**Gaps flagged:** {count}

Review the draft. Any corrections or additions before finalizing?"

### 15. Present MENU OPTIONS

Display: **Deployment Architecture Complete - Select an Option:** [A] Advanced Elicitation [P] Party Mode [C] Continue to Network Architecture

#### EXECUTION RULES:

- ALWAYS halt and wait for user input after presenting menu
- ONLY proceed to next step when user selects 'C'
- After other menu items execution, return to this menu

#### Menu Handling Logic:

- IF A: Execute {advancedElicitationTask}, and when finished redisplay the menu
- IF P: Execute {partyModeWorkflow}, and when finished redisplay the menu
- IF C: Save document to {outputFile}, update {gapReportFile}, then load, read entire file, then execute {nextStepFile}
- IF Any other comments or queries: help user respond, then redisplay menu

---

## SYSTEM SUCCESS/FAILURE METRICS

### SUCCESS:

- Infrastructure topology in valid Mermaid
- K8s resource specs with concrete values
- CI/CD pipeline with all stages documented
- Deployment strategies with rollback procedures
- Health checks for every service
- DR with RTO/RPO targets
- Draft presented and confirmed by user

### FAILURE:

- Generic "appropriate sizing" instead of concrete values
- Missing health checks
- No rollback procedures
- Diagrams not in Mermaid syntax
- Not covering local development setup

**Master Rule:** Skipping steps is FORBIDDEN.
