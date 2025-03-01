# Overwrite target bracnh with contents of feature branch Feature > Target
``git checkout "source_branch_name"``       # source name
``git merge -s ours "target_branch_name"``  # target name
``git checkout "target_branch_name"``       # target name
``git merge "source_branch_name"``          # source name
