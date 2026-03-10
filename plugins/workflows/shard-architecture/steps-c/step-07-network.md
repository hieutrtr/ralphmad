---
name: 'step-07-network'
description: 'Produce 06-network-architecture.md — network topology, ingress, service mesh, DNS, network policies, firewall, API gateway, security zones'

nextStepFile: './step-08-database-design.md'
outputFile: '{output_folder}/06-network-architecture.md'
outputDocTemplate: '../templates/output-doc-template.md'
contentMapFile: '{output_folder}/content-map-{source_name}.md'
gapReportFile: '{output_folder}/gap-report-{source_name}.md'
mermaidStandards: '../data/mermaid-diagram-standards.md'
outputDocChecklist: '../data/output-doc-checklist.md'
advancedElicitationTask: '{project-root}/_bmad/core/workflows/advanced-elicitation/workflow.xml'
partyModeWorkflow: '{project-root}/_bmad/core/workflows/party-mode/workflow.md'
---

# Step 7: Network Architecture

## STEP GOAL:

To produce `06-network-architecture.md` containing network topology diagrams, ingress architecture, service mesh configuration, DNS strategy, Kubernetes network policies, firewall rules, API gateway configuration, inter-service communication details, external integration networking, observability networking, security zones, and CDN configuration.

## MANDATORY EXECUTION RULES (READ FIRST):

### Universal Rules:

- NEVER generate content without user input
- CRITICAL: Read the complete step file before taking any action
- CRITICAL: When loading next step with 'C', ensure entire file is read
- YOU ARE A FACILITATOR, not a content generator

### Role Reinforcement:

- You are an Architecture Document Specialist producing the network view
- We engage in collaborative dialogue, not command-response
- You bring expertise in network topology, service mesh, DNS, and security zone design
- User brings context about their cloud provider, compliance requirements, and network constraints

### Step-Specific Rules:

- Focus ONLY on network architecture — no application logic or database internals
- FORBIDDEN to modify the source architecture document
- ALL diagrams must use valid Mermaid syntax per {mermaidStandards}
- EXPAND beyond the source — many architecture docs underspecify networking
- Include specific CIDR ranges, ports, and protocols where determinable

## EXECUTION PROTOCOLS:

- Read the content map for network-related source sections
- Load standards and checklists
- Generate each required section
- Present the complete draft for user review
- FORBIDDEN to load next step until user selects 'C'

## CONTEXT BOUNDARIES:

- Available: content map, source doc, all previous output docs (01-05)
- Focus: network topology, security, and communication only
- Dependencies: infrastructure topology from 05-deployment.md, service list from 03-detailed-design.md

## MANDATORY SEQUENCE

**CRITICAL:** Follow this sequence exactly. Do not skip, reorder, or improvise.

### 1. Load Context

Read {contentMapFile} for source sections mapped to "06 Network."
Load {mermaidStandards} and {outputDocChecklist} section "06 — Network Architecture."
Read infrastructure topology from 05-deployment-architecture.md.
Read service communication patterns from 03-detailed-design.md.

### 2. Network Topology Diagram

Produce a Mermaid diagram showing:
- VPCs / virtual networks
- Subnets (public, private, data) with CIDR ranges
- Availability zones
- VPC peering / transit gateway
- Internet gateway, NAT gateway
- Network boundaries and trust zones

### 3. Ingress Architecture

Document:
- Load balancer type (ALB, NLB, cloud LB, Nginx Ingress)
- TLS termination point and certificate management
- WAF rules (OWASP top 10, custom rules, rate limiting)
- Rate limiting strategy (per-client, per-endpoint, global)
- Request routing rules (path-based, host-based)
- SSL/TLS configuration (minimum version, cipher suites)

### 4. Service Mesh Configuration

Document:
- Sidecar proxy technology (Istio/Envoy, Linkerd, none)
- mTLS configuration between services
- Traffic policies (retries, timeouts, circuit breaking)
- Observability integration (distributed tracing headers)
- Traffic management (canary routing, fault injection)

If no service mesh: document direct service-to-service communication patterns and how mTLS/observability is handled without a mesh.

### 5. DNS Strategy

| DNS Zone | Type | Records | TTL | Provider |
|----------|------|---------|-----|----------|

Document:
- External DNS (public-facing domains)
- Internal service discovery (Kubernetes DNS, CoreDNS)
- DNS caching strategy
- Failover DNS configuration

### 6. Kubernetes Network Policies

For each namespace, document allowed ingress/egress:

**Namespace: {name}**
| Direction | From/To | Port | Protocol | Action |
|-----------|---------|------|----------|--------|

Include default-deny policies and specific allow rules.

### 7. Firewall Rules

| Tier | Direction | Source | Destination | Port | Protocol | Action |
|------|-----------|--------|-------------|------|----------|--------|

Tiers: Public (DMZ), Application, Data, Management

### 8. API Gateway Configuration

Document:
- Routing rules (path → service mapping)
- Authentication integration (JWT validation, API key check)
- Request/response transformation
- Throttling and quota policies
- CORS configuration
- Request/response logging

### 9. Inter-Service Communication

| From | To | Protocol | Port | Encryption | Auth | Timeout | Retry |
|------|-----|----------|------|-----------|------|---------|-------|

Document: synchronous vs asynchronous, service mesh managed vs direct.

### 10. External Integration Networking

| Integration | Connection Type | Endpoint | Auth | Encryption | IP Allowlist |
|------------|----------------|----------|------|-----------|-------------|

Connection types: Public API, VPN, Private Endpoint, VPC Peering

### 11. Observability Networking

Document how telemetry data flows:
- Metrics: service → collector → backend (Prometheus, Datadog, etc.)
- Logs: service → log agent → aggregator → storage
- Traces: service → trace agent → collector → backend
- Include ports, protocols, and buffering strategies

### 12. Security Zones

Produce a Mermaid diagram showing security zone boundaries:
- DMZ / public zone
- Application tier
- Data tier
- Management tier
- Bastion / jump host access

### 13. CDN Configuration

Document:
- CDN provider and configuration
- Cache rules (static assets, API responses, TTLs)
- Origin shield configuration
- Edge functions / workers (if any)
- Purge/invalidation strategy

### 14. Assemble and Present Draft

Assemble all sections into {outputFile} using {outputDocTemplate}.

"**06 — Network Architecture (Draft)**

{present the complete document}

**Checklist:**
{list each required section from outputDocChecklist with pass/fail}

**Gaps flagged:** {count}

Review the draft. Any corrections or additions before finalizing?"

### 15. Present MENU OPTIONS

Display: **Network Architecture Complete - Select an Option:** [A] Advanced Elicitation [P] Party Mode [C] Continue to Database Design

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

- Network topology in valid Mermaid with zones and subnets
- Ingress with TLS, WAF, rate limiting documented
- Network policies per namespace
- Firewall rules per tier
- Security zone diagram
- External integration networking documented
- Draft presented and confirmed by user

### FAILURE:

- Generic "use a firewall" instead of specific rules
- Missing network policies
- No security zone boundaries
- Diagrams not in Mermaid syntax
- Not covering external integrations

**Master Rule:** Skipping steps is FORBIDDEN.
