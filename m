From: Patrick Donnelly <pdonnell@redhat.com>
Subject: ceph-ansible support for Linode cloud VMs w/ SSD storage
Date: Wed, 21 Sep 2016 18:04:52 -0400
Message-ID: <CA+2bHPaV3iBLwfRYR_Aj9XD78j-MKevdtgF48+FSp5mmyKT_TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35829 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753010AbcIUWFY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2016 18:05:24 -0400
Received: by mail-qk0-f177.google.com with SMTP id t7so59940918qkh.2
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 15:05:23 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hello ceph-devel,

I have added support for the Linode cloud VM provider to ceph-ansible (merged
PR #982 [1]).  Using ceph-ansible and Linode, you can very quickly deploy a
cluster in the cloud using VMs as cheap as 0.015$/hour/vm. This makes it very
cost-effective to do large-scale testing on transient clusters. The end goal of
this effort is to examine the feasability/usefulness of performance testing of
CephFS in the cloud.

I'm hoping others will also find this useful so I've documented the steps to
setup a cluster here. You will need a Linode account and API key [2]. I've also
attached a Dockerfile which allows you to create a dev environment for
launching Ceph clusters on Linode. You can also just follow the steps in the
Dockerfile (adapted for your distribution) to achieve the same thing.

Steps:

(1) Get a Linode account and API key [2].
   NOTE: they have a promotion code in this documentation link for a 10$ credit
   on your account. That credit alone can pay for a hundred or so small cluster
   instances.

(2) Use the attached Dockerfile to create a dev environment for launching the
    cluster:

$ docker build -t ceph-linode - < Linode.dockerfile

(3) Launch a container:

$ docker run -ti ceph-linode

(4) Edit vagrant_variables.yml.linode as desired. Copy config files:

root@34aa495a54ba:~/ceph-ansible# cp site.yml.sample site.yml; cp
vagrant_variables.yml.linode vagrant_variables.yml

(5) Create the cluster (first without provisioning to get all Linode
VMs up before Ansible is run):

root@34aa495a54ba:~/ceph-ansible# time env LINODE_API_KEY='...'
vagrant up --provider=linode --no-provision

(6) Provision the cluster with Ansible:

root@34aa495a54ba:~/ceph-ansible# time env LINODE_API_KEY='...'
vagrant provision

(7) Explore and profit:

root@cc9b119c9f29:~/ceph-ansible# time env LINODE_API_KEY='...' vagrant ssh mon0
==> mon0: Machine State ID: active
==> mon0: IP Address: 23.239.8.249
Last login: Wed Sep 21 01:29:40 2016 from XXX.XXX.XXX.XXX
[vagrant@ceph-mon0 ~]$ sudo ceph status
    cluster 05eb997d-3354-4644-a729-95713d83d4ce
     health HEALTH_WARN
            too many PGs per OSD (320 > max 300)
     monmap e1: 3 mons at
{ceph-mon0=192.168.199.218:6789/0,ceph-mon1=192.168.208.230:6789/0,ceph-mon2=192.168.218.207:6789/0}
            election epoch 10, quorum 0,1,2 ceph-mon0,ceph-mon1,ceph-mon2
      fsmap e6: 1/1/1 up {0=ceph-mds0=up:active}
     osdmap e10: 3 osds: 3 up, 3 in
            flags sortbitwise,require_jewel_osds,require_kraken_osds
      pgmap v21: 320 pgs, 3 pools, 2148 bytes data, 20 objects
            109 MB used, 60613 MB / 60722 MB avail
                 320 active+clean

Now that you have your cluster up, you can use Ansible to trivially run tests
on the clients in an ad-hoc way (or using playbooks). For example, here's how
you can execute a test using ceph-fuse:

# Install and mount ceph-fuse on /mnt
env ANSIBLE_HOST_KEY_CHECKING=false ansible --become
--inventory-file=.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory
--module-name=yum --args="name=ceph-fuse" clients
env ANSIBLE_HOST_KEY_CHECKING=false ansible --become
--inventory-file=.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory
--module-name=command --args="ceph-fuse /mnt/" clients

# Run some script in /mnt:
env ANSIBLE_HOST_KEY_CHECKING=false ansible --become
--inventory-file=.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory
--module-name=copy --args="src=foo.sh dest=/ owner=root group=root
mode=755" clients
env ANSIBLE_HOST_KEY_CHECKING=false ansible --become
--inventory-file=.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory
--module-name=command --args="chdir=/mnt/ /foo.sh" clients


Comments and questions welcome!

[1] https://github.com/ceph/ceph-ansible/pull/982
[2] https://www.linode.com/docs/platform/api/api-key


-- 
Patrick Donnelly
