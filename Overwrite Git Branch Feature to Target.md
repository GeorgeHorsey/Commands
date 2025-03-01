# Overwrite target bracnh with contents of feature branch Feature > Target
``git checkout "feature_branch_name"``       # source name

``git merge -s ours "target_branch_name"``  # target name

``git checkout "target_branch_name"``       # target name

``git merge "feature_branch_name"``          # source name
