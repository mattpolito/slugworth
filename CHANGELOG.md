# Changelog

## 1.2.0

- Uniqueness scoping for a slug
- Auto incrementing of slug
- Slugs can be monitored for updates

## 1.1.0

- `#find_by_slug` has been changed to `#find_by_slug` to keep in line with AR
  finder syntax

## 1.0.2

- [Bug fix] Bypassing validations for `#find_by_slug` spec in shared example.
  This will allow the example group to run in other app test suites without
  worrying about existing validations.

## 1.0.1

- [Bug fix] Shared example had `User` class hard coded

## 1.0.0

- Initial functionality
