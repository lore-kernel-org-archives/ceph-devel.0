From: Christian Brunner <christian@brunner-muc.de>
Subject: Re: about attaching rbd volume from instance on KVM
Date: Mon, 6 Feb 2012 09:06:12 +0100
Message-ID: <CAJafhzSa=tUJpOyLaQvde__hM+5wwN4wDjRei+HGrm5nf7VX0w@mail.gmail.com>
References: <CAM2zNoMCEb+8m1SJrS_oXHhQw18L5axNRQY-RB53GfgACNN9Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53691 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087Ab2BFIGO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Feb 2012 03:06:14 -0500
Received: by wgbdt10 with SMTP id dt10so5934745wgb.1
        for <ceph-devel@vger.kernel.org>; Mon, 06 Feb 2012 00:06:12 -0800 (PST)
In-Reply-To: <CAM2zNoMCEb+8m1SJrS_oXHhQw18L5axNRQY-RB53GfgACNN9Hg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Masuko Tomoya <tomoya.masuko@gmail.com>
Cc: ceph-devel@vger.kernel.org

Libvirt is trying to set security lables even for network shares. This
will not work. I think this is fixed in newer libvirt versions. For
older versions you can try this patch:

http://www.redhat.com/archives/libvir-list/2011-May/msg01446.html

Regards,
Christian

2012/2/4 Masuko Tomoya <tomoya.masuko@gmail.com>:
> Hi, all.
>
> I'm trying to attach rbd volume from instance on KVM.
> But I have problem.
> Could you help me ?
>
> ---
> I tried to attach rbd volume on ceph01 to instance on compute1 with
> virsh command.
>
> root@compute1:~# virsh attach-device test-ub16 /root/testvolume.xml
> error: Failed to attach device from /root/testvolume.xml
> error: cannot resolve symlink rbd/testvolume: No such file or directo=
ry
>
> /var/log/messages
> Feb =A03 20:14:48 compute1 libvirtd: 20:14:48.717: 3234: error :
> qemuMonitorTextAddDevice:2417 : operation failed: adding
> virtio-blk-pci,bus=3Dpci.0,addr=3D0x9,drive=3Ddrive-virtio-disk4,id=3D=
virtio-disk4
> device failed: Device needs media, but drive is empty#015#012Device
> 'virtio-blk-pci' could not be initialized#015#012
> Feb =A03 20:14:48 compute1 libvirtd: 20:14:48.717: 3234: warning :
> qemuDomainAttachPciDiskDevice:188 : qemuMonitorAddDevice failed on
> file=3Drbd:rbd/testvolume,if=3Dnone,id=3Ddrive-virtio-disk4,format=3D=
raw
> (virtio-blk-pci,bus=3Dpci.0,addr=3D0x9,drive=3Ddrive-virtio-disk4,id=3D=
virtio-disk4)
> Feb =A03 20:14:48 compute1 libvirtd: 20:14:48.717: 3234: error :
> virSecurityDACRestoreSecurityFileLabel:143 : cannot resolve symlink
> rbd/testvolume: No such file or directory
> Feb =A03 20:14:48 compute1 libvirtd: 20:14:48.717: 3234: warning :
> qemuDomainAttachPciDiskDevice:229 : Unable to restore security label
> on rbd/testvolume
>
> there is no log in /var/log/ceph/mon.0.log of host ceph01.
> ---
>
>
> My environment is below.
> *There are two servers. All server are ubuntu 10.10 x86_64.
> *ceph01: single server configured ceph.(version: 0.41-1maverick)
> *compute1: kvm hypervisor
> =A0-librados2 and librbd1 packages are installed.
> =A0(version: 0.41-1maverick)
> =A0-qemu-kvm is 0.14.0-rc1. I built qemu with rbd enable.
> =A0the output of run 'qemu-img' show 'rbd' at supported formats field=
=2E
> =A0(I built qemu reffering this page.
> =A0http://ceph.newdream.net/wiki/QEMU-RBD)
> =A0-apparmor is disable.
> =A0-libvirt is 0.8.8
>
> =3D=3D=3D=3D
> =A0-there is ceph.conf on compute1.
> root@compute1:~# ls -l /etc/ceph/
> total 20
> -rw-r--r-- 1 root root 508 2012-02-03 14:38 ceph.conf
> -rw------- 1 root root =A063 2012-02-03 17:04 keyring.admin
> -rw------- 1 root root =A063 2012-02-03 14:38 keyring.bin
> -rw------- 1 root root =A056 2012-02-03 14:38 keyring.mds.0
> -rw------- 1 root root =A056 2012-02-03 14:38 keyring.osd.0
>
> =3D=3D=3D=3D=3D
> =A0-contents of ceph.conf is below.
> root@compute1:~# cat /etc/ceph/ceph.conf
> [global]
> =A0 =A0 =A0 auth supported =3D cephx
> =A0 =A0 =A0 keyring =3D /etc/ceph/keyring.bin
> [mon]
> =A0 =A0 =A0 mon data =3D /data/data/mon$id
> =A0 =A0 =A0 debug ms =3D 1
> [mon.0]
> =A0 =A0 =A0 host =3D ceph01
> =A0 =A0 =A0 mon addr =3D 10.68.119.191:6789
> [mds]
> =A0 =A0 =A0 keyring =3D /etc/ceph/keyring.$name
> [mds.0]
> =A0 =A0 =A0 host =3D ceph01
> [osd]
> =A0 =A0 =A0 keyring =3D /etc/ceph/keyring.$name
> =A0 =A0 =A0 osd data =3D /data/osd$id
> =A0 =A0 =A0 osd journal =3D /data/osd$id/journal
> =A0 =A0 =A0 osd journal size =3D 512
> =A0 =A0 =A0 osd class tmp =3D /var/lib/ceph/tmp
> =A0 =A0 =A0 debug osd =3D 20
> =A0 =A0 =A0 debug ms =3D 1
> =A0 =A0 =A0 debug filestore =3D 20
> [osd.0]
> =A0 =A0 =A0 host =3D ceph01
> =A0 =A0 =A0 btrfs devs =3D /dev/sdb1
>
> =3D=3D=3D
> *conten of keyring.admin is below
> root@compute1:~# cat /etc/ceph/keyring.admin
> [client.admin]
> =A0 =A0 =A0 key =3D AQDFeCxPyBlNIRAAxS1DcRHpMXRpcjY/GNMwYg=3D=3D
>
>
> =3D=3D=3D
> *output of run 'ceph auth list'
> root@ceph01:/etc/ceph# ceph auth list
> 2012-02-03 20:34:59.507451 mon <- [auth,list]
> 2012-02-03 20:34:59.508785 mon.0 -> 'installed auth entries:
> mon.
> =A0 =A0 =A0 key: AQDFeCxPiK04IxAAslDBNkrOGKWxcbCh2iysqg=3D=3D
> mds.0
> =A0 =A0 =A0 key: AQDFeCxPsJ+LGhAAJ3/rmkAtGXSv/eHh0yXgww=3D=3D
> =A0 =A0 =A0 caps: [mds] allow
> =A0 =A0 =A0 caps: [mon] allow rwx
> =A0 =A0 =A0 caps: [osd] allow *
> osd.0
> =A0 =A0 =A0 key: AQDFeCxPoEK+ExAAecD7+tWgpIRoZx2AT7Jwbg=3D=3D
> =A0 =A0 =A0 caps: [mon] allow rwx
> =A0 =A0 =A0 caps: [osd] allow *
> client.admin
> =A0 =A0 =A0 key: AQDFeCxPyBlNIRAAxS1DcRHpMXRpcjY/GNMwYg=3D=3D
> =A0 =A0 =A0 caps: [mds] allow
> =A0 =A0 =A0 caps: [mon] allow *
> =A0 =A0 =A0 caps: [osd] allow *
> ' (0)
>
> =3D=3D=3D=3D
> *xml file is below.
> root@compute1:~# cat /root/testvolume.xml
> <disk type=3D'network' device=3D'disk'>
> =A0<driver name=3D'qemu' type=3D'raw'/>
> =A0<source protocol=3D'rbd' name=3D'rbd/testvolume'>
> =A0 <host name=3D'10.68.119.191' port=3D'6789'/>
> =A0</source>
> =A0<target dev=3D'vde' bus=3D'virtio'/>
> </disk>
>
> =3D=3D=3D=3D
> *testvolume is on rados pools.
> root@compute1:~# qemu-img info rbd:rbd/testvolume
> image: rbd:rbd/testvolume
> file format: raw
> virtual size: 1.0G (1073741824 bytes)
> disk size: unavailable
>
>
> Waiting for reply,
>
> Tomoya.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
