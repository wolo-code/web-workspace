1. Start docker
2. /app/project/render.sh
3. push : /app/build -> https://github.com/wolo-code/web-public

## Update repositories

From the workspace root, run:

```powershell
.\Update-Repositories.ps1 -RecurseSubmodules
```

The script fast-forwards clean repositories only. Repositories with local changes
or a detached `HEAD` are skipped and reported; a pull failure in one repository
does not stop the remaining repositories from being processed.

Use `-TopLevelOnly` when only the aggregator checkout should be updated.

On macOS, run the shell version:

```bash
./update-repositories.sh --recurse-submodules
```
