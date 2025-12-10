---
description: Represents the errors during Xbox authentication.
---

# XboxAuthException

{% hint style="warning" %}
**This document is outdated!** The latest documentation has moved to [here](https://cmllib.github.io/CmlLib.Core-wiki/en/).
{% endhint %}

`ErrorCode` and `ErrorMessage` describe the error in detail.

**If you purchased Minecraft, most of the errors below will not occur. Make sure the account you are trying to log in with is the account that purchased Minecraft.**

Age-related issues can be resolved by changing the login mode to `Full` or `Sisu`. [xboxauth.md](xboxauth.md "mention")

## ErrorCode

### 0x8015dc03

The device or user was banned.

### 0x8015dc04

The device or user was banned.

### 0x8015dc0b

This resource is not available in the country associated with the user.

### 0x8015dc0c

Access to this resource requires age verification.

### 0x8015dc0d

Access to this resource requires age verification.

### 0x8015dc0e

ACCOUNT\_CHILD\_NOT\_IN\_FAMILY

### 0x8015dc09

ACCOUNT\_CREATION\_REQUIRED

### 0x8015dc10

ACCOUNT\_MAINTENANCE\_REQUIRED

### Others

All error codes: [here](https://github.com/microsoft/xbox-live-api/blob/730f579d41b64df5b57b52e629d12f23c6fb64ac/Source/Shared/errors_legacy.h#L924)
