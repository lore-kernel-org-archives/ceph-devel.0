From: Upendra Moturi <upendra.m@hexagrid.com>
Subject: ceph cluster with rbd
Date: Tue, 20 Sep 2011 14:23:23 +0530
Message-ID: <CAHbZLqRnsZTovW_LfVEEnNP2XwpcZXeDsPvgOim1PTem6vS_QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64593 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820Ab1ITIxY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Sep 2011 04:53:24 -0400
Received: by wyg34 with SMTP id 34so270855wyg.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Sep 2011 01:53:23 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@newdream.net, Saurav Lahiri <saurav.lahiri@hexagrid.com>

Hi

I trying to create rbd image with ceph cluster.
I am able to start ceph cluster and mount to a client .
But not able to create rbd image.

I am using Linux ubuntu 3.0.0-11-server=A0 kernel
qemu version : qemu-kvm-0.14.0
ceph version 0.34 (commit:2f039eeeb745622b866d80feda7afa055e15f6d6)

As this a test environment i am trying it on a single machine.

Here is my ceph.conf

[global]
=A0=A0=A0=A0=A0=A0=A0 pid file =3D /var/run/ceph/$name.pid
=A0=A0=A0=A0=A0=A0=A0 debug ms =3D 1
[mon]
=A0=A0=A0=A0=A0=A0=A0 mon data =3D /data/mon$id
[mon.0]
=A0=A0=A0=A0=A0=A0=A0 host =3D ceph1
=A0=A0=A0=A0=A0=A0=A0 mon addr =3D 192.168.123.148:6789
[mds]

[mds.0]
=A0=A0=A0=A0=A0=A0=A0 host =3D ceph1
[osd]
=A0=A0=A0=A0=A0=A0=A0 sudo =3D true
=A0=A0=A0=A0=A0=A0=A0 osd data =3D /data/osd$id
=A0=A0=A0=A0=A0=A0=A0 osd journal =3D /data/osd$id/journal
=A0=A0=A0=A0=A0=A0=A0 osd journal size =3D 512
=A0=A0=A0=A0=A0=A0=A0 osd use stale snap =3D true
[osd.0]
=A0=A0=A0=A0=A0=A0=A0 host =3D ceph1
=A0=A0=A0=A0=A0=A0=A0 btrfs devs =3D /dev/sdb
[osd.1]
=A0=A0=A0=A0=A0=A0=A0 host =3D ceph1
=A0=A0=A0=A0=A0=A0=A0 btrfs devs =3D /dev/sdc

Using
mkcephfs -c /etc/ceph/ceph.conf -a --mkbtrfs -k /etc/ceph/keyring.bin
able to create ceph file system and mount to client
but not able to create a rbd image on it.

=46ollowed the url
http://ceph.newdream.net/wiki/Rbd
and was not able to check out.
but when i did

depmod -a
modprobe rbd
i am able to see /sys/bus/rbd directory.

ceph class list
did not show me rbd
Instead it said me
mon0 -> 'class distribution is no longer handled by the monitor' (-22)

Not able to check out qemu-rbd
$ git clone git://git.qemu.org/qemu.git
$ cd qemu
$ ./configure --enable-rbd
$ make; make install

=46rom linux-kvm url
(http://www.linux-kvm.com/content/cephrbd-block-driver-patches-qemu-kvm=
)
$ git clone git://ceph.newdream.net/git/qemu-kvm.git
$ cd qemu-kvm
$ git checkout -b rbd origin/rbd
$ ./configure --enable-rbd
$ make; make install

I was able to check out using above url but configure gave me following=
 error

     ./configure --enable-rbd
     ERROR
     ERROR: User requested feature rados block device
     ERROR: configure was not able to find it
     ERROR

Please guide me in the right direction.









--
Thanks and Regards,
Upendra.M
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
