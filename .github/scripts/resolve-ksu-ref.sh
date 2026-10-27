# Emit KEY=VALUE into the GitHub Actions step environment.
emit_env() { printf '%s=%s\n' "$1" "$2" >> "${GITHUB_ENV:?GITHUB_ENV is not set}"; }

# ==================== ADVANCED ARCHITECTURE TRACKING BASELINES ====================
# Stable / Dev = Static pinned commit layers targeting the tracking repositories.
# Pinned commits guarantee reproducible compilation matrices without API feature breaks.
# 
# Pinned to latest main HEAD arrays matching current system compatibility frames.

# 1. KernelSU-Next Baseline Pins (Your Core Selected Target Platform)
NEXT_STABLE_REF="6c1b489d81d764724b17e4f9b88523c921356f18"   # KernelSU-Next main HEAD tracking reference
NEXT_DEV_REF="6c1b489d81d764724b17e4f9b88523c921356f18"      # KernelSU-Next development baseline offset

# 2. Existing Legacy Variable Array Reference Trees
OFFICIAL_STABLE_REF="08a3b087e49227c8a6731c5f1114998b5e25255b"  # tiann/KernelSU main HEAD
SUKISU_STABLE_REF="cf87e3f4ddd3f6e5464d85acf56aaa6950e70841"    # SukiSU-Ultra main HEAD
BAKASU_STABLE_REF="9dbce02e511ea6b6305a238b84e456f6a92e1d0b"    # Baka-SU/BakaSU main HEAD

OFFICIAL_DEV_REF="08a3b087e49227c8a6731c5f1114998b5e25255b"
SUKISU_DEV_REF="cf87e3f4ddd3f6e5464d85acf56aaa6950e70841"
BAKASU_DEV_REF="9dbce02e511ea6b6305a238b84e456f6a92e1d0b"

# ==================== ENGINE LOOKUP MAP RESOLUTION ====================
# Intercepts incoming KSU_VARIANT strings to map correct repository coordinates

echo "==> [Ref Resolver] Processing target branch logic for: $KSU_VARIANT"

case "$KSU_VARIANT" in
  "KernelSU-Next")
    TARGET_REPO="KernelSU-Next/KernelSU-Next"
    if [ "$KSU_BRANCH" = "Stable(标准)" ]; then
        RESOLVED_BRANCH_REF="$NEXT_STABLE_REF"
    elif [ "$KSU_BRANCH" = "Dev(开发)" ]; then
        RESOLVED_BRANCH_REF="$NEXT_DEV_REF"
    else
        # Dynamic Latest Tracking Path
        RESOLVED_BRANCH_REF="main"
    fi
    ;;
  "Official")
    TARGET_REPO="tiann/KernelSU"
    RESOLVED_BRANCH_REF="$OFFICIAL_STABLE_REF"
    ;;
  "SukiSU")
    TARGET_REPO="SukiSU-Ultra/SukiSU-Ultra"
    RESOLVED_BRANCH_REF="$SUKISU_STABLE_REF"
    ;;
  "BakaSU")
    TARGET_REPO="Baka-SU/BakaSU"
    RESOLVED_BRANCH_REF="$BAKASU_STABLE_REF"
    ;;
esac

# Export calculated branch definitions directly into the active GitHub Environment
emit_env "BRANCH" "$RESOLVED_BRANCH_REF"
emit_env "KSU_REPO" "$TARGET_REPO"

echo "==> [Ref Resolver] Target locked successfully: ${TARGET_REPO}@${RESOLVED_BRANCH_REF}"
