# Source - https://superuser.com/a/1593856
# Posted by EntangledLoops, modified by community. See post 'Timeline' for change history
# Retrieved 2026-02-26, License - CC BY-SA 4.0

import os
    
# grab $PATH
path = os.environ['PATH'].split(':')

# normalize all paths
path = map(os.path.normpath, path)

# remove duplicates via a dictionary
clean = dict.fromkeys(path)

# combine back into one path
clean_path = ':'.join(clean.keys())

# dump to stdout
print(f"PATH={clean_path}")
