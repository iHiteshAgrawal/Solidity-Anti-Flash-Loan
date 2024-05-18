# Anti Flash Loan Contract

This Solidity contract demonstrates a hacky approach to handling proxy calls and implementing a basic flash loan protection mechanism using a whitelist.

**Example Usage:**

```solidity
function sensitiveFunction() external antiProxy {
    // This function is completely blocked for any proxy calls
}

function anotherSensitiveFunction() external antiFlashLoan {
    // This function allows whitelisted proxies but blocks others
}
```

## Overview

Flash loans are a DeFi feature allowing users to borrow large amounts of cryptocurrency without collateral, as long as the loan is repaid within the same transaction. While they have legitimate uses, they can also be exploited to manipulate markets or drain funds from vulnerable contracts.

This contract mitigates flash loan attacks by:

1. **Whitelist:** Maintains a list of trusted addresses (smart wallets, authorized proxies).
2. **Proxy Differentiation:** Offers two modifiers for flexible control:
   - `antiProxy`: Blocks **all** proxy calls, regardless of whitelist status.
   - `antiFlashLoan`: Allows calls from whitelisted proxies while blocking others, specifically targeting flash loan risks.

## Contract Features

- **`antiProxy` modifier:** Restricts function calls to direct user interactions only.
- **`antiFlashLoan` modifier:** Allows direct user calls and calls from whitelisted proxies.
- **`whitelistProxy(address proxy)` function:** Enables the contract owner to add addresses to the whitelist.

## Security Considerations

- **Whitelist Management:** Ensure `whitelistProxy()` is callable only by the owner or a highly trusted multi-sig wallet. Any vulnerabilities here compromise security.
- **Flash Loan Variations:** This is not foolproof. New attack techniques emerge constantly, so stay informed about security best practices.
- **Contract Audits:** Get your contract professionally audited to identify potential vulnerabilities, particularly in whitelist management logic.

## Disclaimer

This is for demonstration only. It's not production-ready and shouldn't be used to handle real assets without thorough testing, auditing, and careful consideration of your specific security requirements.
