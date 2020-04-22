FROM docker.io/kindest/node:v1.17.2

RUN echo "Installing crio ..." \
    && DEBIAN_FRONTEND=noninteractive clean-install gnupg \
    && echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_19.10/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list \
    && curl -fSL https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/xUbuntu_19.10/Release.key | apt-key add - \
    && rm -rf /etc/crictl.yaml \
    && DEBIAN_FRONTEND=noninteractive clean-install cri-o-1.17 libglib2.0-0
RUN echo "Installing crun ..." \
    && curl -fSL https://github.com/containers/crun/releases/download/0.13/crun-0.13-static-x86_64 -o /usr/local/bin/crun \
    && chmod a+x /usr/local/bin/crun

COPY crio.conf /etc/crio/crio.conf
RUN systemctl disable containerd && systemctl enable crio

# This needs to be done in kind config?
# RUN sed -i 's;/run/containerd/containerd.sock;/var/run/crio/crio.sock;g' /var/lib/kubelet/kubeadm-flags.env
