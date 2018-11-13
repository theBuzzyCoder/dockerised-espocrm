#!/usr/bin/env python

from shutil import copy2

src = '/crm/repo_tools/pre-commit'
dst = '/crm/.git/hooks/pre-commit'

# shutil.copy2 can copy file metadata, permissions and data
# while shutil.copy can only copy data and permissions.
print("Copying %s to %s ..." % (src, dst))
copy2(src, dst)
print("Copy completed. Git's pre-commit hook has been setup!")
