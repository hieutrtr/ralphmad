# Source Section → Output Document Mapping Rules

Rules for mapping sections of a monolithic architecture document to the 7 output sub-documents.

## Mapping Matrix

| Source Content Type | Primary Output Doc | Secondary Output Docs |
|--------------------|--------------------|----------------------|
| System context, actors, external systems | 01-high-level-design | |
| Architectural drivers, quality attributes | 01-high-level-design | 03-detailed-design |
| Architecture style rationale | 01-high-level-design | |
| Domain boundaries, bounded contexts | 01-high-level-design | 03-detailed-design |
| Architecture decision records (ADRs) | 01-high-level-design | All (as relevant) |
| Non-functional requirements | 01-high-level-design | 05-deployment, 07-database |
| Technology choices with versions | 02-tech-stack | All (as relevant) |
| License and vendor information | 02-tech-stack | |
| Starter templates, scaffolding | 02-tech-stack | 05-deployment |
| API contracts, endpoints, schemas | 03-detailed-design | 04-sequence-diagrams |
| Service communication patterns | 03-detailed-design | 04-sequence-diagrams, 06-network |
| Domain model, entities, aggregates | 03-detailed-design | 07-database |
| Error handling, retry, circuit breaker | 03-detailed-design | 04-sequence-diagrams |
| Caching strategy | 03-detailed-design | 07-database |
| Multi-tenancy implementation | 03-detailed-design | 07-database, 06-network |
| Naming conventions, coding standards | 03-detailed-design | |
| Authentication/authorization flows | 04-sequence-diagrams | 03-detailed-design, 06-network |
| User journey descriptions | 04-sequence-diagrams | |
| Event publishing/consuming | 04-sequence-diagrams | 03-detailed-design |
| Background/async processing | 04-sequence-diagrams | 05-deployment |
| Kubernetes, containers, pods | 05-deployment | |
| Helm charts, values | 05-deployment | |
| CI/CD pipeline | 05-deployment | |
| Deployment strategies | 05-deployment | |
| Docker Compose, local dev | 05-deployment | |
| Resource sizing, scaling | 05-deployment | |
| Infrastructure as Code | 05-deployment | 06-network |
| Network topology, VPCs, subnets | 06-network | 05-deployment |
| Ingress, load balancer, TLS | 06-network | 05-deployment |
| Service mesh, mTLS | 06-network | 03-detailed-design |
| Network policies, firewall rules | 06-network | |
| API gateway configuration | 06-network | 03-detailed-design |
| Database schema, tables, columns | 07-database | |
| Index strategy | 07-database | |
| Migration strategy | 07-database | 05-deployment |
| Connection pooling | 07-database | 05-deployment |
| Backup and recovery | 07-database | 05-deployment |
| Vector database schema | 07-database | 02-tech-stack |
| Cache schema (Redis) | 07-database | 03-detailed-design |
| Directory/file structure | 03-detailed-design | 05-deployment |

## Mapping Principles

1. **Every source section** must map to at least one output document
2. **Cross-cutting decisions** (like ADRs) may map to multiple output docs
3. **Technology mentions** always map to 02-tech-stack plus the relevant concern doc
4. **Gaps** (topics an output doc requires but the source lacks) must be flagged
5. **Expansion** is expected — output docs should contain 2-5x more detail than the source section
