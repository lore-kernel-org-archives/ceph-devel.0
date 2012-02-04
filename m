From: Masuko Tomoya <tomoya.masuko@gmail.com>
Subject: (unknown)
Date: Fri, 3 Feb 2012 20:46:46 -0800
Message-ID: <CAM2zNoPgP-=s+d44x4VUTXUf2Gru1a5JaecEy=hjq1nn799tLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:60855 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751561Ab2BDEqr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Feb 2012 23:46:47 -0500
Received: by lagu2 with SMTP id u2so2174447lag.19
        for <ceph-devel@vger.kernel.org>; Fri, 03 Feb 2012 20:46:46 -0800 (PST)
Subject: 
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi, all.

I'm trying to attach rbd volume from instance on KVM.
But I have problem.
Could you help me ?

---
I tried to attach rbd volume on ceph01 to instance on compute1 with
virsh command.

root@compute1:~# virsh attach-device test-ub16 /root/testvolume.xml
error: Failed to attach device from /root/testvolume.xml
error: cannot resolve symlink rbd/testvolume: No such file or directory

/var/log/messages
Feb  3 20:14:48 compute1 libvirtd: 20:14:48.717: 3234: error :
qemuMonitorTextAddDevice:2417 : operation failed: adding
virtio-blk-pci,bus=pci.0,addr=0x9,drive=drive-virtio-disk4,id=virtio-disk4
device failed: Device needs media, but drive is empty#015#012Device
'virtio-blk-pci' could not be initialized#015#012
Feb  3 20:14:48 compute1 libvirtd: 20:14:48.717: 3234: warning :
qemuDomainAttachPciDiskDevice:188 : qemuMonitorAddDevice failed on
file=rbd:rbd/testvolume,if=none,id=drive-virtio-disk4,format=raw
(virtio-blk-pci,bus=pci.0,addr=0x9,drive=drive-virtio-disk4,id=virtio-disk4)
Feb  3 20:14:48 compute1 libvirtd: 20:14:48.717: 3234: error :
virSecurityDACRestoreSecurityFileLabel:143 : cannot resolve symlink
rbd/testvolume: No such file or directory
Feb  3 20:14:48 compute1 libvirtd: 20:14:48.717: 3234: warning :
qemuDomainAttachPciDiskDevice:229 : Unable to restore security label
on rbd/testvolume

there is no log in /var/log/ceph/mon.0.log of host ceph01.
---


My environment is below.
*There are two servers. All server are ubuntu 10.10 x86_64.
*ceph01: single server configured ceph.(version: 0.41-1maverick)
*compute1: kvm hypervisor
 -librados2 and librbd1 packages are installed.
 (version: 0.41-1maverick)
 -qemu-kvm is 0.14.0-rc1. I built qemu with rbd enable.
  the output of run 'qemu-img' show 'rbd' at supported formats field.
  (I built qemu reffering this page.
  http://ceph.newdream.net/wiki/QEMU-RBD)
 -apparmor is disable.
 -libvirt is 0.8.8

====
 -there is ceph.conf on compute1.
root@compute1:~# ls -l /etc/ceph/
total 20
-rw-r--r-- 1 root root 508 2012-02-03 14:38 ceph.conf
-rw------- 1 root root  63 2012-02-03 17:04 keyring.admin
-rw------- 1 root root  63 2012-02-03 14:38 keyring.bin
-rw------- 1 root root  56 2012-02-03 14:38 keyring.mds.0
-rw------- 1 root root  56 2012-02-03 14:38 keyring.osd.0

=====
 -contents of ceph.conf is below.
root@compute1:~# cat /etc/ceph/ceph.conf
[global]
        auth supported = cephx
        keyring = /etc/ceph/keyring.bin
[mon]
        mon data = /data/data/mon$id
        debug ms = 1
[mon.0]
        host = ceph01
        mon addr = 10.68.119.191:6789
[mds]
        keyring = /etc/ceph/keyring.$name
[mds.0]
        host = ceph01
[osd]
        keyring = /etc/ceph/keyring.$name
        osd data = /data/osd$id
        osd journal = /data/osd$id/journal
        osd journal size = 512
        osd class tmp = /var/lib/ceph/tmp
        debug osd = 20
        debug ms = 1
        debug filestore = 20
[osd.0]
        host = ceph01
        btrfs devs = /dev/sdb1

===
*conten of keyring.admin is below
root@compute1:~# cat /etc/ceph/keyring.admin
[client.admin]
        key = AQDFeCxPyBlNIRAAxS1DcRHpMXRpcjY/GNMwYg==


===
*output of run 'ceph auth list'
root@ceph01:/etc/ceph# ceph auth list
2012-02-03 20:34:59.507451 mon <- [auth,list]
2012-02-03 20:34:59.508785 mon.0 -> 'installed auth entries:
mon.
        key: AQDFeCxPiK04IxAAslDBNkrOGKWxcbCh2iysqg==
mds.0
        key: AQDFeCxPsJ+LGhAAJ3/rmkAtGXSv/eHh0yXgww==
        caps: [mds] allow
        caps: [mon] allow rwx
        caps: [osd] allow *
osd.0
        key: AQDFeCxPoEK+ExAAecD7+tWgpIRoZx2AT7Jwbg==
        caps: [mon] allow rwx
        caps: [osd] allow *
client.admin
        key: AQDFeCxPyBlNIRAAxS1DcRHpMXRpcjY/GNMwYg==
        caps: [mds] allow
        caps: [mon] allow *
        caps: [osd] allow *
' (0)

====
*xml file is below.
root@compute1:~# cat /root/testvolume.xml
<disk type='network' device='disk'>
  <driver name='qemu' type='raw'/>
  <source protocol='rbd' name='rbd/testvolume'>
    <host name='10.68.119.191' port='6789'/>
  </source>
  <target dev='vde' bus='virtio'/>
</disk>

====
*testvolume is on rados pools.
root@compute1:~# qemu-img info rbd:rbd/testvolume
image: rbd:rbd/testvolume
file format: raw
virtual size: 1.0G (1073741824 bytes)
disk size: unavailable


Waiting for reply,

Tomoya.
