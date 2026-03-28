#!/bin/bash
set -euo pipefail

# Install package files
mkdir -p "$PREFIX/lib/tir-learner"
cp -r TIR-Learner3/* "$PREFIX/lib/tir-learner/"

# Fix shebang in main script (original has #!/usr/app/env python3, a typo)
sed -i '1s|.*|#!/usr/bin/env python3|' "$PREFIX/lib/tir-learner/TIR-Learner.py"

# Create CLI wrapper
mkdir -p "$PREFIX/bin"
cat > "$PREFIX/bin/TIR-Learner" << 'EOF'
#!/bin/bash
exec python3 "$(dirname "$(dirname "$(readlink -f "$0")")")/lib/tir-learner/TIR-Learner.py" "$@"
EOF
chmod +x "$PREFIX/bin/TIR-Learner"
