grep -rl '1\.0\.0' .  --exclude-dir={"Build","libs","Pods",".git"} --exclude={"Podfile.lock","CHANGELOG.md","update-version.sh"} | xargs sed -i.bak 's/1\.0\.0/1\.0\.1/g';

find . -type f -name '*.bak' -delete