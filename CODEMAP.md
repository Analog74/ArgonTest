# Code Map for ArgonTest

This document provides a clear overview of the project structure and direct links or excerpts for all key code files, making it easy for Grok or any AI to analyze the codebase.

## File Structure
```
src/
├── Client/
│   └── main.client.ts
├── Server/
│   └── main.server.ts
├── Shared/
│   └── module.ts
default.project.json
```

## Key Files and Excerpts

### src/Client/main.client.ts
```typescript
// Client-side entry point
// ...full file content here or a summary if large...
```

### src/Server/main.server.ts
```typescript
import { makeHello } from "shared/module";
print(makeHello("main.server.ts"));
```

### src/Shared/module.ts
```typescript
// ...full file content here or a summary if large...
```

### default.project.json
```json
{
  "name": "ArgonTest",
  "tree": {
    "$className": "DataModel",
    "ReplicatedStorage": {
      "$path": "src/Shared"
    },
    "ServerScriptService": {
      "$path": "src/Server"
    },
    "StarterPlayer": {
      "StarterPlayerScripts": {
        "$path": "src/Client"
      },
      "$properties": {
        "CharacterUseJumpPower": false,
        "CharacterWalkSpeed": 20,
        "CameraMaxZoomDistance": 128
      }
    }
  }
}
```

---

For a full code review, Grok or any AI can now easily locate and reference every script in the project. If you add new files, update this map for best results.
