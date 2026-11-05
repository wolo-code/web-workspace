#!/usr/bin/env bash

set -u

workspace=$(pwd -P)
top_level_only=0
recurse_submodules=0

usage() {
    printf 'Usage: %s [--top-level-only] [--recurse-submodules]\n' "$(basename "$0")"
}

for argument in "$@"; do
    case "$argument" in
        --top-level-only) top_level_only=1 ;;
        --recurse-submodules) recurse_submodules=1 ;;
        -h|--help) usage; exit 0 ;;
        *) printf 'Unknown option: %s\n' "$argument" >&2; usage >&2; exit 2 ;;
    esac
done

repositories=()
while IFS= read -r git_path; do
    repositories+=("${git_path%/.git}")
done < <(find "$workspace" -type d -name .git -prune -print)

if (( top_level_only )); then
    filtered=()
    for repository in "${repositories[@]}"; do
        if [[ "$repository" == "$workspace" || "${repository#"$workspace"/}" != */* ]]; then
            filtered+=("$repository")
        fi
    done
    repositories=("${filtered[@]}")
fi

failed=()
for repository in "${repositories[@]}"; do
    display_path=${repository#"$workspace"/}
    [[ "$repository" == "$workspace" ]] && display_path='.'

    branch=$(git -C "$repository" branch --show-current)
    if [[ -z "$branch" ]]; then
        printf 'Skipping %s: detached HEAD.\n' "$display_path" >&2
        continue
    fi

    if [[ -n "$(git -C "$repository" status --porcelain)" ]]; then
        printf 'Skipping %s: working tree has local changes.\n' "$display_path" >&2
        continue
    fi

    printf 'Updating %s (%s)...\n' "$display_path" "$branch"
    if ! git -C "$repository" pull --ff-only; then
        failed+=("$display_path")
        continue
    fi

    if (( recurse_submodules )) && ! git -C "$repository" submodule update --init --recursive; then
        failed+=("$display_path (submodules)")
    fi
done

if ((${#failed[@]} > 0)); then
    printf 'Repository update completed with failures: %s\n' "${failed[*]}" >&2
    exit 1
fi

printf 'Repository update completed successfully.\n'
