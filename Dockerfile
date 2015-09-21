FROM centos:7.1.1503
MAINTAINER woshilaiceshide<woshilaiceshide@qq.com>

RUN yum install openssh-server -y
RUN yum update -y && yum clean all
RUN groupadd sftponly
#use '-M' to instruct "NOT CREATE THE HOME DIR"
RUN useradd -s /sbin/nologin -M -g sftponly sftponlyuser
#the target dir of chroot should be owned by root, and could not be written by others.
RUN mkdir -p /home/sftponlyuser/upload
RUN chown sftponlyuser: /home/sftponlyuser/upload
#no `passwd` on the official centos:7.1.1503
RUN echo 'sftponlyuser:123' | chpasswd
#or "Could not load host key: /etc/ssh/ssh_host_xxx_key"
RUN ssh-keygen -A
#modifications in sshd_config
#1. sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_confi 
#2. add `AllowGroups sftponly`
#3. add the section `Match Group sftponly ...`
ADD ["sshd_config", "/etc/ssh/sshd_config"]
ADD ["sshd", "/etc/pam.d/sshd"]

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]