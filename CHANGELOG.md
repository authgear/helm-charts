# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [10.32.0] - 2026-05-05

[ff65cdc..a612fcc](https://github.com/authgear/helm-charts/compare/ff65cdc..a612fcc)

### Added
- Add deployments of site admin portal

## [10.31.0] - 2026-04-24

[ab7c6c7..ff65cdc](https://github.com/authgear/helm-charts/compare/ab7c6c7..ff65cdc)

### Fixed
- Fix missing env vars and volume in siteadmin deployment

## [10.30.0] - 2026-04-09

[8a533f0..ab7c6c7](https://github.com/authgear/helm-charts/compare/8a533f0..ab7c6c7)

### Added
- Update authgear config for site admin

## [10.29.0] - 2026-04-01

[a935d3a..8a533f0](https://github.com/authgear/helm-charts/compare/a935d3a..8a533f0)

### Added
- Add site admin API deployment with ingress and cert-manager certificate

## [10.28.0] - 2026-03-23

[08c4130..a935d3a](https://github.com/authgear/helm-charts/compare/08c4130..a935d3a)

### Added
- Support env values for each deployment

## [10.27.1] - 2026-03-06

[6d98692..08c4130](https://github.com/authgear/helm-charts/compare/6d98692..08c4130)

### Fixed
- Fix incorrect default command and args in `redisAutoRewriteAOFCronjob`

## [10.27.0] - 2026-03-06

[2d053c1..6d98692](https://github.com/authgear/helm-charts/compare/2d053c1..6d98692)

### Added
- Support new logging configs
- Support extra volumes in all cronjobs
- Allow redis bgrewriteaof cronjob command and args to be customized

## [10.26.1] - 2025-09-25

[ba0f9a0..2d053c1](https://github.com/authgear/helm-charts/compare/ba0f9a0..2d053c1)

### Fixed
- Fix ENTRYPOINT was incorrectly overridden in some cronjobs

## [10.26.0] - 2025-09-24

[e1fbca6..ba0f9a0](https://github.com/authgear/helm-charts/compare/e1fbca6..ba0f9a0)

### Added
- Support `extraVolumes` and `extraVolumeMounts` in all cronjobs

## [10.25.0] - 2025-09-24

[15fe085..e1fbca6](https://github.com/authgear/helm-charts/compare/15fe085..e1fbca6)

### Added
- Support Alibaba Cloud OSS
- Add app secret to WhatsApp Cloud API webhook credential
- Set `SEARCH_ENABLED` to true in portal if any search implementation is enabled

## [10.24.0] - 2025-09-16

[a1317a2..15fe085](https://github.com/authgear/helm-charts/compare/a1317a2..15fe085)

### Added
- Support Alibaba Cloud OSS
- Support WhatsApp Cloud API

## [10.23.0] - 2025-05-27

[3ebee49..a1317a2](https://github.com/authgear/helm-charts/compare/3ebee49..a1317a2)

### Added
- Support OAuth demo credentials (`sso.oauth.demo_credentials` secrets)
- Use portal endpoint as shared endpoint

## [10.22.0] - 2025-05-13

[dffc8e3..3ebee49](https://github.com/authgear/helm-charts/compare/dffc8e3..3ebee49)

### Added
- Support ingress annotations

## [10.21.0] - 2025-04-30

[cc11b0e..dffc8e3](https://github.com/authgear/helm-charts/compare/cc11b0e..dffc8e3)

### Added
- Support PodDisruptionBudget
- Set `ANALYTIC_POSTHOG_ENDPOINT` and `ANALYTIC_POSTHOG_APIKEY`

## [10.20.0] - 2025-04-24

[04437a7..cc11b0e](https://github.com/authgear/helm-charts/compare/04437a7..cc11b0e)

### Added
- Set Posthog endpoint and API key in portal server

## [10.19.0] - 2025-01-21

[3af34dd..04437a7](https://github.com/authgear/helm-charts/compare/3af34dd..04437a7)

### Added
- Support `AUTHGEAR_WEB_SDK_SESSION_TYPE`
- Set `SEARCH_DATABASE_URL` and `SEARCH_DATABASE_SCHEMA`

## [10.18.1] - 2024-11-26

[ca8f7cc..3af34dd](https://github.com/authgear/helm-charts/compare/ca8f7cc..3af34dd)

### Added
- Support PostgreSQL search

### Fixed
- Fix `SEARCH_DATABASE_URL` and `SEARCH_DATABASE_SCHEMA` configuration

## [10.18.0] - 2024-11-26

[1dd6457..ca8f7cc](https://github.com/authgear/helm-charts/compare/1dd6457..ca8f7cc)

### Added
- Support PostgreSQL search (disabled by default)

## [10.17.0] - 2024-11-08

[5fa1f76..1dd6457](https://github.com/authgear/helm-charts/compare/5fa1f76..1dd6457)

### Added
- Add a cronjob to auto rewrite Redis AOF file

## [10.16.0] - 2024-09-30

[e0544f8..5fa1f76](https://github.com/authgear/helm-charts/compare/e0544f8..5fa1f76)

### Added
- Support user export environment variables

## [10.15.0] - 2024-09-30

[b75f1f3..e0544f8](https://github.com/authgear/helm-charts/compare/b75f1f3..e0544f8)

### Added
- Add customizing service account annotations

### Fixed
- Fix missing scheduling fields on analytic hourly and weekly cronjob

## [10.14.0] - 2024-09-06

[038d933..b75f1f3](https://github.com/authgear/helm-charts/compare/038d933..b75f1f3)

### Added
- Support Google Workload Identity Federation

### Fixed
- Fix missing scheduling fields on analytic hourly and weekly cronjob

## [10.13.0] - 2024-08-30

[0e31086..038d933](https://github.com/authgear/helm-charts/compare/0e31086..038d933)

### Added
- Support providing a service account to images server
- Allow GCS service account key to be optional

## [10.12.1] - 2024-08-22

[573cc84..0e31086](https://github.com/authgear/helm-charts/compare/573cc84..0e31086)

### Fixed
- Fix if block placed incorrectly inside a range loop

## [10.12.0] - 2024-08-22

[de6d95d..573cc84](https://github.com/authgear/helm-charts/compare/de6d95d..573cc84)

### Added
- Support `SAML_IDP_ENTITY_ID_TEMPLATE`

## [10.11.0] - 2024-07-03

[cf6d7e0..de6d95d](https://github.com/authgear/helm-charts/compare/cf6d7e0..de6d95d)

### Added
- Set `AUTH_UI_WINDOW_MESSAGE_ALLOWED_ORIGINS` to the host of the portal

## [10.10.0] - 2024-06-25

[a69fa38..cf6d7e0](https://github.com/authgear/helm-charts/compare/a69fa38..cf6d7e0)

### Added
- Set `ALLOWED_FRAME_ANCESTORS` to the host of the portal

## [10.9.0] - 2024-05-07

[35f3d9c..a69fa38](https://github.com/authgear/helm-charts/compare/35f3d9c..a69fa38)

### Added
- Support per-default-domain Issuer

## [10.8.0] - 2024-05-03

[d23a648..35f3d9c](https://github.com/authgear/helm-charts/compare/d23a648..35f3d9c)

### Added
- Support HorizontalPodAutoscaler
- Support another Posthog cronjob

## [10.7.0] - 2024-04-26

[0b0f874..d23a648](https://github.com/authgear/helm-charts/compare/0b0f874..d23a648)

### Added
- Support an additional Posthog cronjob

## [10.6.0] - 2024-04-22

[ee7273d..0b0f874](https://github.com/authgear/helm-charts/compare/ee7273d..0b0f874)

### Added
- Support Posthog cronjob

## [10.5.1] - 2024-04-08

[fbff8b5..ee7273d](https://github.com/authgear/helm-charts/compare/fbff8b5..ee7273d)

### Security
- Hide server header and turn off server tokens in portal nginx

## [10.5.0] - 2023-11-22

[c22b840..fbff8b5](https://github.com/authgear/helm-charts/compare/c22b840..fbff8b5)

### Added
- Allow customizing pod scheduling fields for deno

## [10.4.0] - 2023-08-26

[4077fb7..c22b840](https://github.com/authgear/helm-charts/compare/4077fb7..c22b840)

### Added
- Support `APP_HOST_SUFFIXES` in other servers

## [10.3.1] - 2023-08-14

[33071e6..4077fb7](https://github.com/authgear/helm-charts/compare/33071e6..4077fb7)

### Fixed
- Fix wildcard Certificate being merged into previous Ingress

## [10.3.0] - 2023-07-30

[c4f8e89..33071e6](https://github.com/authgear/helm-charts/compare/c4f8e89..33071e6)

### Added
- Support `PORTAL_FRONTEND_SENTRY_DSN`

## [10.2.1] - 2023-07-28

[f1f6256..c4f8e89](https://github.com/authgear/helm-charts/compare/f1f6256..c4f8e89)

### Fixed
- Fix analytic hourly cronjob to run for this-hour instead of last-hour

## [10.2.0] - 2023-07-27

[bb37dc5..f1f6256](https://github.com/authgear/helm-charts/compare/bb37dc5..f1f6256)

### Added
- Support project-hourly-report analytic cronjob

## [10.1.1] - 2023-07-20

[254e848..bb37dc5](https://github.com/authgear/helm-charts/compare/254e848..bb37dc5)

### Fixed
- Fix typo

## [10.1.0] - 2023-07-20

[fa2cdbd..254e848](https://github.com/authgear/helm-charts/compare/fa2cdbd..254e848)

### Added
- Support `APP_HOST_SUFFIXES`

## [10.0.0] - 2023-07-20

[9b93739..fa2cdbd](https://github.com/authgear/helm-charts/compare/9b93739..fa2cdbd)

### Breaking Changes
- Replace `.authgear.tls.wildcard` with `.authgear.defaultDomains`
- Allow configuring usage record WhatsApp event name

[10.32.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.32.0
[10.31.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.31.0
[10.30.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.30.0
[10.29.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.29.0
[10.28.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.28.0
[10.27.1]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.27.1
[10.27.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.27.0
[10.26.1]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.26.1
[10.26.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.26.0
[10.25.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.25.0
[10.24.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.24.0
[10.23.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.23.0
[10.22.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.22.0
[10.21.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.21.0
[10.20.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.20.0
[10.19.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.19.0
[10.18.1]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.18.1
[10.18.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.18.0
[10.17.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.17.0
[10.16.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.16.0
[10.15.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.15.0
[10.14.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.14.0
[10.13.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.13.0
[10.12.1]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.12.1
[10.12.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.12.0
[10.11.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.11.0
[10.10.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.10.0
[10.9.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.9.0
[10.8.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.8.0
[10.7.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.7.0
[10.6.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.6.0
[10.5.1]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.5.1
[10.5.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.5.0
[10.4.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.4.0
[10.3.1]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.3.1
[10.3.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.3.0
[10.2.1]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.2.1
[10.2.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.2.0
[10.1.1]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.1.1
[10.1.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.1.0
[10.0.0]: https://github.com/authgear/authgear-helm-charts/releases/tag/authgear-10.0.0
