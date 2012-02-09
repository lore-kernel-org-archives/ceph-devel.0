From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: about attaching rbd volume from instance on KVM
Date: Wed, 08 Feb 2012 18:10:33 -0800
Message-ID: <4F332B19.5090206@dreamhost.com>
References: <CAM2zNoMCEb+8m1SJrS_oXHhQw18L5axNRQY-RB53GfgACNN9Hg@mail.gmail.com>	<CAJafhzSa=tUJpOyLaQvde__hM+5wwN4wDjRei+HGrm5nf7VX0w@mail.gmail.com> <CAM2zNoPg88JM=VOGUz6vE=n=xWzgOZ+Nkz2hM=ip33ojw94-nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:49334 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338Ab2BICKd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Feb 2012 21:10:33 -0500
In-Reply-To: <CAM2zNoPg88JM=VOGUz6vE=n=xWzgOZ+Nkz2hM=ip33ojw94-nQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Masuko Tomoya <tomoya.masuko@gmail.com>
Cc: christian@brunner-muc.de, ceph-devel@vger.kernel.org

On 02/08/2012 03:42 PM, Masuko Tomoya wrote:
> Hi Christian,
>
> Thank you for reply !
>
> Could I ask a version of libvirt which is your patch applied ?
>
> I'm trying it with libvirt0.9.8-2ubuntu9, but there is same error.
> (I'm using blow package:
> https://launchpad.net/ubuntu/precise/+source/libvirt/0.9.8-2ubuntu9)
>
> root@compute04:~# dpkg -l | grep libvirt-bin
> ii  libvirt-bin                            0.9.8-2ubuntu9
>              programs for the libvirt library
>
> /var/log/libvirtd/libvirt.log
> 2012-02-08 23:33:53.800+0000: 4663: error :
> qemuMonitorTextAddDrive:2828 : operation failed: open disk image file
> failed
> 2012-02-08 23:33:53.800+0000: 4663: error :
> virSecurityDACRestoreSecurityFileLabel:143 : cannot resolve symlink
> rbd/testvolume: No such file or directory
> 2012-02-08 23:33:54.212+0000: 4663: warning :
> qemuDomainAttachPciDiskDevice:287 : Unable to restore security label
> on rbd/testvolume

libvirt 0.9.9 fixes this (the applied patch is 
http://www.redhat.com/archives/libvir-list/2011-December/msg00506.html 
if you're curious).

>
> 2012/2/6 Christian Brunner<christian@brunner-muc.de>:
>> Libvirt is trying to set security lables even for network shares. This
>> will not work. I think this is fixed in newer libvirt versions. For
>> older versions you can try this patch:
>>
>> http://www.redhat.com/archives/libvir-list/2011-May/msg01446.html
>>
>> Regards,
>> Christian
>>
>> 2012/2/4 Masuko Tomoya<tomoya.masuko@gmail.com>:
>>> Hi, all.
>>>
>>> I'm trying to attach rbd volume from instance on KVM.
>>> But I have problem.
>>> Could you help me ?
>>>
>>> ---
>>> I tried to attach rbd volume on ceph01 to instance on compute1 with
>>> virsh command.
>>>
>>> root@compute1:~# virsh attach-device test-ub16 /root/testvolume.xml
>>> error: Failed to attach device from /root/testvolume.xml
>>> error: cannot resolve symlink rbd/testvolume: No such file or directory
>>>
>>> /var/log/messages
>>> Feb  3 20:14:48 compute1 libvirtd: 20:14:48.717: 3234: error :
>>> qemuMonitorTextAddDevice:2417 : operation failed: adding
>>> virtio-blk-pci,bus=pci.0,addr=0x9,drive=drive-virtio-disk4,id=virtio-disk4
>>> device failed: Device needs media, but drive is empty#015#012Device
>>> 'virtio-blk-pci' could not be initialized#015#012
>>> Feb  3 20:14:48 compute1 libvirtd: 20:14:48.717: 3234: warning :
>>> qemuDomainAttachPciDiskDevice:188 : qemuMonitorAddDevice failed on
>>> file=rbd:rbd/testvolume,if=none,id=drive-virtio-disk4,format=raw
>>> (virtio-blk-pci,bus=pci.0,addr=0x9,drive=drive-virtio-disk4,id=virtio-disk4)
>>> Feb  3 20:14:48 compute1 libvirtd: 20:14:48.717: 3234: error :
>>> virSecurityDACRestoreSecurityFileLabel:143 : cannot resolve symlink
>>> rbd/testvolume: No such file or directory
>>> Feb  3 20:14:48 compute1 libvirtd: 20:14:48.717: 3234: warning :
>>> qemuDomainAttachPciDiskDevice:229 : Unable to restore security label
>>> on rbd/testvolume
>>>
>>> there is no log in /var/log/ceph/mon.0.log of host ceph01.
>>> ---
>>>
>>>
>>> My environment is below.
>>> *There are two servers. All server are ubuntu 10.10 x86_64.
>>> *ceph01: single server configured ceph.(version: 0.41-1maverick)
>>> *compute1: kvm hypervisor
>>>   -librados2 and librbd1 packages are installed.
>>>   (version: 0.41-1maverick)
>>>   -qemu-kvm is 0.14.0-rc1. I built qemu with rbd enable.
>>>   the output of run 'qemu-img' show 'rbd' at supported formats field.
>>>   (I built qemu reffering this page.
>>>   http://ceph.newdream.net/wiki/QEMU-RBD)
>>>   -apparmor is disable.
>>>   -libvirt is 0.8.8
>>>
>>> ====
>>>   -there is ceph.conf on compute1.
>>> root@compute1:~# ls -l /etc/ceph/
>>> total 20
>>> -rw-r--r-- 1 root root 508 2012-02-03 14:38 ceph.conf
>>> -rw------- 1 root root  63 2012-02-03 17:04 keyring.admin
>>> -rw------- 1 root root  63 2012-02-03 14:38 keyring.bin
>>> -rw------- 1 root root  56 2012-02-03 14:38 keyring.mds.0
>>> -rw------- 1 root root  56 2012-02-03 14:38 keyring.osd.0
>>>
>>> =====
>>>   -contents of ceph.conf is below.
>>> root@compute1:~# cat /etc/ceph/ceph.conf
>>> [global]
>>>        auth supported = cephx
>>>        keyring = /etc/ceph/keyring.bin
>>> [mon]
>>>        mon data = /data/data/mon$id
>>>        debug ms = 1
>>> [mon.0]
>>>        host = ceph01
>>>        mon addr = 10.68.119.191:6789
>>> [mds]
>>>        keyring = /etc/ceph/keyring.$name
>>> [mds.0]
>>>        host = ceph01
>>> [osd]
>>>        keyring = /etc/ceph/keyring.$name
>>>        osd data = /data/osd$id
>>>        osd journal = /data/osd$id/journal
>>>        osd journal size = 512
>>>        osd class tmp = /var/lib/ceph/tmp
>>>        debug osd = 20
>>>        debug ms = 1
>>>        debug filestore = 20
>>> [osd.0]
>>>        host = ceph01
>>>        btrfs devs = /dev/sdb1
>>>
>>> ===
>>> *conten of keyring.admin is below
>>> root@compute1:~# cat /etc/ceph/keyring.admin
>>> [client.admin]
>>>        key = AQDFeCxPyBlNIRAAxS1DcRHpMXRpcjY/GNMwYg==
>>>
>>>
>>> ===
>>> *output of run 'ceph auth list'
>>> root@ceph01:/etc/ceph# ceph auth list
>>> 2012-02-03 20:34:59.507451 mon<- [auth,list]
>>> 2012-02-03 20:34:59.508785 mon.0 ->  'installed auth entries:
>>> mon.
>>>        key: AQDFeCxPiK04IxAAslDBNkrOGKWxcbCh2iysqg==
>>> mds.0
>>>        key: AQDFeCxPsJ+LGhAAJ3/rmkAtGXSv/eHh0yXgww==
>>>        caps: [mds] allow
>>>        caps: [mon] allow rwx
>>>        caps: [osd] allow *
>>> osd.0
>>>        key: AQDFeCxPoEK+ExAAecD7+tWgpIRoZx2AT7Jwbg==
>>>        caps: [mon] allow rwx
>>>        caps: [osd] allow *
>>> client.admin
>>>        key: AQDFeCxPyBlNIRAAxS1DcRHpMXRpcjY/GNMwYg==
>>>        caps: [mds] allow
>>>        caps: [mon] allow *
>>>        caps: [osd] allow *
>>> ' (0)
>>>
>>> ====
>>> *xml file is below.
>>> root@compute1:~# cat /root/testvolume.xml
>>> <disk type='network' device='disk'>
>>>   <driver name='qemu' type='raw'/>
>>>   <source protocol='rbd' name='rbd/testvolume'>
>>>    <host name='10.68.119.191' port='6789'/>
>>>   </source>
>>>   <target dev='vde' bus='virtio'/>
>>> </disk>
>>>
>>> ====
>>> *testvolume is on rados pools.
>>> root@compute1:~# qemu-img info rbd:rbd/testvolume
>>> image: rbd:rbd/testvolume
>>> file format: raw
>>> virtual size: 1.0G (1073741824 bytes)
>>> disk size: unavailable
>>>
>>>
>>> Waiting for reply,
>>>
>>> Tomoya.
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
