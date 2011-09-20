From: Wido den Hollander <wido@widodh.nl>
Subject: Re: ceph cluster with rbd
Date: Tue, 20 Sep 2011 12:56:22 +0200
Message-ID: <1316516182.2671.26.camel@wido-desktop>
References: <CAHbZLqRnsZTovW_LfVEEnNP2XwpcZXeDsPvgOim1PTem6vS_QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:52177 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730Ab1ITK40 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Sep 2011 06:56:26 -0400
In-Reply-To: <CAHbZLqRnsZTovW_LfVEEnNP2XwpcZXeDsPvgOim1PTem6vS_QQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Upendra Moturi <upendra.m@hexagrid.com>
Cc: ceph-devel@vger.kernel.org, sage@newdream.net, Saurav Lahiri <saurav.lahiri@hexagrid.com>

Hi,

On Tue, 2011-09-20 at 14:23 +0530, Upendra Moturi wrote:
> Hi
> 
> I trying to create rbd image with ceph cluster.
> I am able to start ceph cluster and mount to a client .
> But not able to create rbd image.
> 
> I am using Linux ubuntu 3.0.0-11-server  kernel
> qemu version : qemu-kvm-0.14.0
> ceph version 0.34 (commit:2f039eeeb745622b866d80feda7afa055e15f6d6)
> 
> As this a test environment i am trying it on a single machine.
> 
> Here is my ceph.conf
> 
> [global]
>         pid file = /var/run/ceph/$name.pid
>         debug ms = 1
> [mon]
>         mon data = /data/mon$id
> [mon.0]
>         host = ceph1
>         mon addr = 192.168.123.148:6789

I'd not use a all-numeric name for your monitor.

You better use something like [mon.alpha]

> [mds]
> 
> [mds.0]
>         host = ceph1

Same goes for the MDS, use something like mds.ceph1.

> [osd]
>         sudo = true
>         osd data = /data/osd$id
>         osd journal = /data/osd$id/journal
>         osd journal size = 512
>         osd use stale snap = true
> [osd.0]
>         host = ceph1
>         btrfs devs = /dev/sdb
> [osd.1]
>         host = ceph1
>         btrfs devs = /dev/sdc
> 
> Using
> mkcephfs -c /etc/ceph/ceph.conf -a --mkbtrfs -k /etc/ceph/keyring.bin
> able to create ceph file system and mount to client
> but not able to create a rbd image on it.
> 
> Followed the url
> http://ceph.newdream.net/wiki/Rbd
> and was not able to check out.
> but when i did
> 
> depmod -a
> modprobe rbd
> i am able to see /sys/bus/rbd directory.
> 
> ceph class list
> did not show me rbd
> Instead it said me
> mon0 -> 'class distribution is no longer handled by the monitor' (-22)

I don't think that loading the classes is needed anymore. I just tried:

root@monitor:~# rbd create alpha --size=1024
root@monitor:~# rbd ls
alpha
root@monitor:~#

This is a fresh cluster, no RBD work has been done yet. Did you try to
create a RBD image?

> 
> Not able to check out qemu-rbd
> $ git clone git://git.qemu.org/qemu.git
> $ cd qemu
> $ ./configure --enable-rbd
> $ make; make install
> 
> From linux-kvm url
> (http://www.linux-kvm.com/content/cephrbd-block-driver-patches-qemu-kvm)
> $ git clone git://ceph.newdream.net/git/qemu-kvm.git
> $ cd qemu-kvm
> $ git checkout -b rbd origin/rbd
> $ ./configure --enable-rbd
> $ make; make install
> 
> I was able to check out using above url but configure gave me following error
> 
>      ./configure --enable-rbd
>      ERROR
>      ERROR: User requested feature rados block device
>      ERROR: configure was not able to find it
>      ERROR

Are the RBD development headers installed? Something like librbd-dev

Wido

> 
> Please guide me in the right direction.
> 
> 
> 
> 
> 
> 
> 
> 
> 
> --
> Thanks and Regards,
> Upendra.M
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


