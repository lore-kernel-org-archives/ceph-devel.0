From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: about attaching rbd volume from instance on KVM
Date: Fri, 17 Feb 2012 18:49:15 -0800
Message-ID: <4F3F11AB.8080206@dreamhost.com>
References: <CAM2zNoMCEb+8m1SJrS_oXHhQw18L5axNRQY-RB53GfgACNN9Hg@mail.gmail.com>	<CAJafhzSa=tUJpOyLaQvde__hM+5wwN4wDjRei+HGrm5nf7VX0w@mail.gmail.com>	<CAM2zNoPg88JM=VOGUz6vE=n=xWzgOZ+Nkz2hM=ip33ojw94-nQ@mail.gmail.com>	<4F332B19.5090206@dreamhost.com> <CAM2zNoNeaNpR4N+WE2X6+eAMiQXJRspvyKNZPYGWfhnPeJOwAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:41306 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284Ab2BRCtQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Feb 2012 21:49:16 -0500
In-Reply-To: <CAM2zNoNeaNpR4N+WE2X6+eAMiQXJRspvyKNZPYGWfhnPeJOwAw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Masuko Tomoya <tomoya.masuko@gmail.com>
Cc: christian@brunner-muc.de, ceph-devel@vger.kernel.org

On 02/15/2012 07:01 PM, Masuko Tomoya wrote:
> Hi Josh,
>
> Thank you for your reply !
>
>> libvirt 0.9.9 fixes this (the applied patch is http://www.redhat.com/archives/libvir-list/2011-December/msg00506.html if you're curious).
> Finally I applied the patch to libvirt 0.9.8 and
> I fixed it.
>
> But I have another issue.
> When I tried attach rbd volume to VM on KVM, error occured.
>
> --
> root@compute04:~# virsh attach-device instance-00000027 testvolume4.xml
> error: Failed to attach device from testvolume4.xml
> error: operation failed: open disk image file failed
> --
>
> Could you advice to me ?
>
> *testvolume4.xml is below.
> <disk type='network' device='disk'>
>    <driver name='qemu' type='raw'/>
>    <source protocol='rbd' name='rbd/testvolume3'>
>      <host name='10.2.100.56' port='6789'/>
>    </source>
>    <target dev='vdm' bus='virtio'/>
> </disk>
>
> * I use this qemu-kvm with built rbd option on.
> root@compute04:/usr/bin# /usr/bin/qemu-system-x86_64 -version
> QEMU emulator version 1.0 (qemu-kvm-1.0), Copyright (c) 2003-2008
> Fabrice Bellard
>
> *libvirtd.log is below
> 2012-02-15 05:30:24.669+0000: 14034: debug :
> remoteDispatchDomainAttachDeviceHelper:297 : server=0x1dad7f0
> client=0x1e78fd0 msg=0x7fedd0003490 rerr=0x7feddeb1fc70 args=0x1e6f270
> ret=0x1e6f210
> 2012-02-15 05:30:24.669+0000: 14032: debug : virEventPollRunOnce:619 :
> EVENT_POLL_RUN: nhandles=9 imeout=5000
> 2012-02-15 05:30:24.669+0000: 14034: debug :
> virDomainAttachDevice:8542 : dom=0x1e6f230, (VM:
> name=instance-00000027, uuid=51846781-0d41-44a4-9da7-902c7c394f53),
> xml=<disk type='network' device='disk'>
>    <driver name='qemu' type='raw'/>
>    <source protocol='rbd' name='rbd/testvolume3'>
>      <host name='10.2.100.56' port='6789'/>
>    </source>
>    <target dev='vdm' bus='virtio'/>
> </disk>
>

Your xml looks fine, but libvirt has a problem:

> buf={"execute":"human-monitor-command","arguments":{"command-line":"drive_add
> dummy file=rbd:rbd/testvolume3:mon_host=10.2.100.56\\\\:6789,if=none,id=drive-virtio-disk12,format=raw"},"id":"libvirt-8"}
>   len=198 ret=198 errno=11

It looks like "10.2.100.56:6789" has been escaped twice. This makes qemu 
interpret the configuration as mon_host = 10.2.100.56\\, and then, since 
the colon is unescaped, 6789 is read as a separate option:

> 2012-02-15 05:30:24.674+0000: 14032: debug : qemuMonitorIOProcess:313
> : QEMU_MONITOR_IO_PROCESS: mon=0x1dcdf70 buf={"return": "conf option
> 6789 has no value\r\nerror setting config options\r\ncould not open
> disk image rbd:rbd/testvolume3:mon_host=10.2.100.56\\\\:6789: Invalid
> argument\r\n", "id": "libvirt-8"}
>   len=197
>

I'll look into the right way to solve this next week, but if you want a 
workaround, you can apply this patch to libvirt:

diff --git a/src/qemu/qemu_monitor_text.c b/src/qemu/qemu_monitor_text.c
index 2c68be8..3530ff4 100644
--- a/src/qemu/qemu_monitor_text.c
+++ b/src/qemu/qemu_monitor_text.c
@@ -2508,20 +2508,13 @@ int qemuMonitorTextAttachDrive(qemuMonitorPtr mon,
      char *cmd = NULL;
      char *reply = NULL;
      int ret = -1;
-    char *safe_str;
      int tryOldSyntax = 0;

-    safe_str = qemuMonitorEscapeArg(drivestr);
-    if (!safe_str) {
-        virReportOOMError();
-        return -1;
-    }
-
  try_command:
      if (virAsprintf(&cmd, "drive_add %s%.2x:%.2x:%.2x %s",
                      (tryOldSyntax ? "" : "pci_addr="),
                      controllerAddr->domain, controllerAddr->bus,
-                    controllerAddr->slot, safe_str) < 0) {
+                    controllerAddr->slot, drivestr) < 0) {
          virReportOOMError();
          goto cleanup;
      }
@@ -2555,7 +2548,6 @@ try_command:
  cleanup:
      VIR_FREE(cmd);
      VIR_FREE(reply);
-    VIR_FREE(safe_str);
      return ret;
  }

>
> Waiting for reply,
>
> Tomoya.
>
> 2012/2/9 Josh Durgin<josh.durgin@dreamhost.com>:
>> On 02/08/2012 03:42 PM, Masuko Tomoya wrote:
>>>
>>> Hi Christian,
>>>
>>> Thank you for reply !
>>>
>>> Could I ask a version of libvirt which is your patch applied ?
>>>
>>> I'm trying it with libvirt0.9.8-2ubuntu9, but there is same error.
>>> (I'm using blow package:
>>> https://launchpad.net/ubuntu/precise/+source/libvirt/0.9.8-2ubuntu9)
>>>
>>> root@compute04:~# dpkg -l | grep libvirt-bin
>>> ii  libvirt-bin                            0.9.8-2ubuntu9
>>>              programs for the libvirt library
>>>
>>> /var/log/libvirtd/libvirt.log
>>> 2012-02-08 23:33:53.800+0000: 4663: error :
>>> qemuMonitorTextAddDrive:2828 : operation failed: open disk image file
>>> failed
>>> 2012-02-08 23:33:53.800+0000: 4663: error :
>>> virSecurityDACRestoreSecurityFileLabel:143 : cannot resolve symlink
>>> rbd/testvolume: No such file or directory
>>> 2012-02-08 23:33:54.212+0000: 4663: warning :
>>> qemuDomainAttachPciDiskDevice:287 : Unable to restore security label
>>> on rbd/testvolume
>>
>>
>> libvirt 0.9.9 fixes this (the applied patch is
>> http://www.redhat.com/archives/libvir-list/2011-December/msg00506.html if
>> you're curious).
>>
>>
>>>
>>> 2012/2/6 Christian Brunner<christian@brunner-muc.de>:
>>>>
>>>> Libvirt is trying to set security lables even for network shares. This
>>>> will not work. I think this is fixed in newer libvirt versions. For
>>>> older versions you can try this patch:
>>>>
>>>> http://www.redhat.com/archives/libvir-list/2011-May/msg01446.html
>>>>
>>>> Regards,
>>>> Christian
>>>>
>>>> 2012/2/4 Masuko Tomoya<tomoya.masuko@gmail.com>:
>>>>>
>>>>> Hi, all.
>>>>>
>>>>> I'm trying to attach rbd volume from instance on KVM.
>>>>> But I have problem.
>>>>> Could you help me ?
>>>>>
>>>>> ---
>>>>> I tried to attach rbd volume on ceph01 to instance on compute1 with
>>>>> virsh command.
>>>>>
>>>>> root@compute1:~# virsh attach-device test-ub16 /root/testvolume.xml
>>>>> error: Failed to attach device from /root/testvolume.xml
>>>>> error: cannot resolve symlink rbd/testvolume: No such file or directory
>>>>>
>>>>> /var/log/messages
>>>>> Feb  3 20:14:48 compute1 libvirtd: 20:14:48.717: 3234: error :
>>>>> qemuMonitorTextAddDevice:2417 : operation failed: adding
>>>>>
>>>>> virtio-blk-pci,bus=pci.0,addr=0x9,drive=drive-virtio-disk4,id=virtio-disk4
>>>>> device failed: Device needs media, but drive is empty#015#012Device
>>>>> 'virtio-blk-pci' could not be initialized#015#012
>>>>> Feb  3 20:14:48 compute1 libvirtd: 20:14:48.717: 3234: warning :
>>>>> qemuDomainAttachPciDiskDevice:188 : qemuMonitorAddDevice failed on
>>>>> file=rbd:rbd/testvolume,if=none,id=drive-virtio-disk4,format=raw
>>>>>
>>>>> (virtio-blk-pci,bus=pci.0,addr=0x9,drive=drive-virtio-disk4,id=virtio-disk4)
>>>>> Feb  3 20:14:48 compute1 libvirtd: 20:14:48.717: 3234: error :
>>>>> virSecurityDACRestoreSecurityFileLabel:143 : cannot resolve symlink
>>>>> rbd/testvolume: No such file or directory
>>>>> Feb  3 20:14:48 compute1 libvirtd: 20:14:48.717: 3234: warning :
>>>>> qemuDomainAttachPciDiskDevice:229 : Unable to restore security label
>>>>> on rbd/testvolume
>>>>>
>>>>> there is no log in /var/log/ceph/mon.0.log of host ceph01.
>>>>> ---
>>>>>
>>>>>
>>>>> My environment is below.
>>>>> *There are two servers. All server are ubuntu 10.10 x86_64.
>>>>> *ceph01: single server configured ceph.(version: 0.41-1maverick)
>>>>> *compute1: kvm hypervisor
>>>>>   -librados2 and librbd1 packages are installed.
>>>>>   (version: 0.41-1maverick)
>>>>>   -qemu-kvm is 0.14.0-rc1. I built qemu with rbd enable.
>>>>>   the output of run 'qemu-img' show 'rbd' at supported formats field.
>>>>>   (I built qemu reffering this page.
>>>>>   http://ceph.newdream.net/wiki/QEMU-RBD)
>>>>>   -apparmor is disable.
>>>>>   -libvirt is 0.8.8
>>>>>
>>>>> ====
>>>>>   -there is ceph.conf on compute1.
>>>>> root@compute1:~# ls -l /etc/ceph/
>>>>> total 20
>>>>> -rw-r--r-- 1 root root 508 2012-02-03 14:38 ceph.conf
>>>>> -rw------- 1 root root  63 2012-02-03 17:04 keyring.admin
>>>>> -rw------- 1 root root  63 2012-02-03 14:38 keyring.bin
>>>>> -rw------- 1 root root  56 2012-02-03 14:38 keyring.mds.0
>>>>> -rw------- 1 root root  56 2012-02-03 14:38 keyring.osd.0
>>>>>
>>>>> =====
>>>>>   -contents of ceph.conf is below.
>>>>> root@compute1:~# cat /etc/ceph/ceph.conf
>>>>> [global]
>>>>>        auth supported = cephx
>>>>>        keyring = /etc/ceph/keyring.bin
>>>>> [mon]
>>>>>        mon data = /data/data/mon$id
>>>>>        debug ms = 1
>>>>> [mon.0]
>>>>>        host = ceph01
>>>>>        mon addr = 10.68.119.191:6789
>>>>> [mds]
>>>>>        keyring = /etc/ceph/keyring.$name
>>>>> [mds.0]
>>>>>        host = ceph01
>>>>> [osd]
>>>>>        keyring = /etc/ceph/keyring.$name
>>>>>        osd data = /data/osd$id
>>>>>        osd journal = /data/osd$id/journal
>>>>>        osd journal size = 512
>>>>>        osd class tmp = /var/lib/ceph/tmp
>>>>>        debug osd = 20
>>>>>        debug ms = 1
>>>>>        debug filestore = 20
>>>>> [osd.0]
>>>>>        host = ceph01
>>>>>        btrfs devs = /dev/sdb1
>>>>>
>>>>> ===
>>>>> *conten of keyring.admin is below
>>>>> root@compute1:~# cat /etc/ceph/keyring.admin
>>>>> [client.admin]
>>>>>        key = AQDFeCxPyBlNIRAAxS1DcRHpMXRpcjY/GNMwYg==
>>>>>
>>>>>
>>>>> ===
>>>>> *output of run 'ceph auth list'
>>>>> root@ceph01:/etc/ceph# ceph auth list
>>>>> 2012-02-03 20:34:59.507451 mon<- [auth,list]
>>>>> 2012-02-03 20:34:59.508785 mon.0 ->    'installed auth entries:
>>>>> mon.
>>>>>        key: AQDFeCxPiK04IxAAslDBNkrOGKWxcbCh2iysqg==
>>>>> mds.0
>>>>>        key: AQDFeCxPsJ+LGhAAJ3/rmkAtGXSv/eHh0yXgww==
>>>>>        caps: [mds] allow
>>>>>        caps: [mon] allow rwx
>>>>>        caps: [osd] allow *
>>>>> osd.0
>>>>>        key: AQDFeCxPoEK+ExAAecD7+tWgpIRoZx2AT7Jwbg==
>>>>>        caps: [mon] allow rwx
>>>>>        caps: [osd] allow *
>>>>> client.admin
>>>>>        key: AQDFeCxPyBlNIRAAxS1DcRHpMXRpcjY/GNMwYg==
>>>>>        caps: [mds] allow
>>>>>        caps: [mon] allow *
>>>>>        caps: [osd] allow *
>>>>> ' (0)
>>>>>
>>>>> ====
>>>>> *xml file is below.
>>>>> root@compute1:~# cat /root/testvolume.xml
>>>>> <disk type='network' device='disk'>
>>>>>   <driver name='qemu' type='raw'/>
>>>>>   <source protocol='rbd' name='rbd/testvolume'>
>>>>>    <host name='10.68.119.191' port='6789'/>
>>>>>   </source>
>>>>>   <target dev='vde' bus='virtio'/>
>>>>> </disk>
>>>>>
>>>>> ====
>>>>> *testvolume is on rados pools.
>>>>> root@compute1:~# qemu-img info rbd:rbd/testvolume
>>>>> image: rbd:rbd/testvolume
>>>>> file format: raw
>>>>> virtual size: 1.0G (1073741824 bytes)
>>>>> disk size: unavailable
>>>>>
>>>>>
>>>>> Waiting for reply,
>>>>>
>>>>> Tomoya.
