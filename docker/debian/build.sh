docker build -t nemu_kernel_4.4.0 --build-arg GIT_REPO_URL="git@nanny.netease.com:zouyongbin/nemu-androvm-kernel-4.4.0.git" --build-arg SSH_PRIVATE_KEY="$(cat /home/broler/.ssh/id_rsa)"  --build-arg PROJECT=nemu_kernel_4.4.0 .
