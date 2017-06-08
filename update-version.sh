grep -rl '2\.0\.4' .  --exclude-dir={"Build","libs","Pods",".git"} --exclude={"Podfile.lock","CHANGELOG.md","update-version.sh"} | xargs sed -i.bak 's/2\.0\.4/2\.0\.5/g';

find . -type f -name '*.bak' -delete
