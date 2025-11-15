# Changelog

All notable changes to this project will be documented in this file.

## [v1.2.1] - 2025-11-14

### Bug Fixes
- **Fixed CloudFront distribution perpetual updates**: Removed `min_ttl`, `default_ttl`, and `max_ttl` parameters from `default_cache_behavior` block when using managed cache policies. These parameters are incompatible with `cache_policy_id` and caused CloudFront to continuously report configuration drift on every `terraform apply`.

### Improvements
- **Better support for Next.js/React applications**: The `default_root_object` variable now defaults to `null` instead of `"index.html"`, allowing modern JavaScript frameworks that handle their own routing to work correctly without CloudFront trying to append a default file.
- **Enhanced variable documentation**: Updated `default_root_object` variable description to clarify when to use `null` (for Next.js/React apps) vs a specific file (for static sites).

### Changes
- `default_root_object` variable default changed from `"index.html"` to `null`
- Removed TTL parameters (`min_ttl`, `default_ttl`, `max_ttl`) from `default_cache_behavior` as they are managed by the cache policy

### Migration Notes
If upgrading from v1.2.0 or earlier:
- If you rely on the default `index.html` behavior, explicitly set `default_root_object = "index.html"` in your variables
- After applying v1.2.1, you may need to run one final `terraform apply` to sync the TTL settings with AWS
- Subsequent applies should show no changes if your configuration is stable
