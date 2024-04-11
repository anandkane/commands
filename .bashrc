# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
export JAVA_HOME=/home/akane/.jdks/corretto-1.8.0_352
alias cls=clear
alias no-line-history='history -w /dev/stdout'
source /etc/profile.d/bash_completion.sh
source <(kubectl completion bash)
alias k=kubectl
complete -F __start_kubectl k
source <(helm completion bash)
alias hem=helm
complete -F __start_helm hem
alias heml=helm
complete -F __start_helm heml
source <(minikube completion bash)
#HISTTIMEFORMAT="%Y-%m-%d %T "
#HISTCONTROL=ignoreboth
alias mndocker='eval $(minikube docker-env)'
alias umndocker='eval $(minikube docker-env -u)'
# . ~/project/set-env-for-local-run.sh
alias mvnjib='mvn jib:build -DskipTests=true'
alias mvnjibcln='mvn clean jib:build -DskipTests=true'
alias setns='kubectl config set-context minikube --namespace '
alias socatprocs='ps aux | grep -i socat'
alias cmcorednscreate='k apply -f ~/project/k8s/resources/minikube-connectivity/configmap-coredns-new.yaml'
alias cmcorednsdel='k delete -f ~/project/k8s/resources/minikube-connectivity/configmap-coredns-new.yaml'
alias cmcorednsedit='k edit cm --namespace kube-system coredns'
alias cmcorednsreplace='k replace -f ~/project/k8s/resources/minikube-connectivity/configmap-coredns-new.yaml'
alias socatstart='sudo socat UDP4-RECVFROM:54,fork UDP4-SENDTO:10.160.0.220:53 &'

alias cddbeaverscripts='cd /home/akane/.local/share/DBeaverData/workspace6/General/Scripts'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

complete -C /usr/bin/vault vault
export VAULT_ADDR=https://vault-dev-mgmt156.aws.merchante.com
complete -C /usr/bin/consul consul
alias dnsutil='kubectl apply -f https://k8s.io/examples/admin/dns/dnsutils.yaml'
source <(kn completion bash)
alias set-java-20='. /home/akane/project/scripts/setEnvJava20.sh'
source <(kind completion bash)

# >>>> Vagrant command completion (start)
. /opt/vagrant/embedded/gems/gems/vagrant-2.3.7/contrib/bash/completion.sh
# <<<<  Vagrant command completion (end)
. /usr/share/autojump/autojump.bash
export deplocal=-Ddeployment.type=local
