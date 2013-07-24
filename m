From: Andreas Bluemle <andreas.bluemle@itxperts.de>
Subject: Re: ceph file system: extended attributes differ between ceph.ko
 and ceph-fuse
Date: Wed, 24 Jul 2013 08:11:21 +0200
Message-ID: <20130724081121.481ebeab@doppio>
References: <20130718124949.00cfec42@doppio>
	<CAPYLRzj0Ts9HDURGCa=C-yctqMo-N-DrrGQP6nd+ACTkWNnqBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from port-212-202-108-184.static.qsc.de ([212.202.108.184]:42799
	"EHLO mail.itxperts.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751615Ab3GXGL2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Jul 2013 02:11:28 -0400
In-Reply-To: <CAPYLRzj0Ts9HDURGCa=C-yctqMo-N-DrrGQP6nd+ACTkWNnqBA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 23 Jul 2013 15:55:25 -0700
Gregory Farnum <greg@inktank.com> wrote:

> On Thu, Jul 18, 2013 at 3:49 AM, Andreas Bluemle
> <andreas.bluemle@itxperts.de> wrote:
> > Hi,
> >
> > I am looking at ceph filesystem both via the kernel module
> > and ceph-fuse.
> >
> > I am running on CentOS6.4 with
> >  - kernel 3.8.13 (for ceph.ko) and
> >  - ceph v0.61.4 userland components
> >
> > I encounter an inconsistency between ceph.ko and ceph-fuse
> > regarding extended attributes:
> >
> > - I have the ceph fs mounted at mount points
> >   /mnt/cephfs (using ceph.ko) and /mnt/cephfs-fuse
> >
> > [root@rx37-2 fs_2]# mount | grep ceph
> > 10.10.38.13:/ on /mnt/cephfs type ceph (name=3Dadmin,key=3Dclient.a=
dmin)
> > ceph-fuse on /mnt/cephfs-fuse type fuse.ceph-fuse
> >        (rw,nosuid,nodev,allow_other,default_permissions)
> >
> > - I inspect the same file from the two mointpoints
> >
> > [root@rx37-2 mnt]# getfattr -d -m - cephfs-fuse/ssd-pool-3/file1
> > # file: cephfs-fuse/ssd-pool-3/file1
> > ceph.file.layout=3D"stripe_unit=3D4194304 stripe_count=3D1
> > object_size=3D4194304 pool=3DSSD-group-2"
> >
> > [root@rx37-2 mnt]# getfattr -d -m - cephfs/ssd-pool-3/file1
> > # file: cephfs/ssd-pool-3/file1
> > ceph.file.layout=3D"chunk_bytes=3D4194304\012stripe_count=3D1\012ob=
ject_size=3D4194304\012"
> > ceph.layout=3D"chunk_bytes=3D4194304\012stripe_count=3D1\012object_=
size=3D4194304\012"
> >
> > Where getfattr returns info about the pool via ceph-fuse,
> > it doesn't show that info via ceph.ko.
> >
> > - use ceph utilities to look at the file shows the missing pieces;
> >   at least, the results are consistent.
> >
> > [root@rx37-2 mnt]# cephfs cephfs/ssd-pool-3/file1 show_layout
> > layout.data_pool:     3
> > layout.object_size:   4194304
> > layout.stripe_unit:   4194304
> > layout.stripe_count:  1
> > [root@rx37-2 mnt]# ceph osd dump | grep pool | \
> >               awk '{ print $1 " " $2 ": " $3 }'
> > pool 0: 'data'
> > pool 1: 'metadata'
> > pool 2: 'rbd'
> > pool 3: 'SSD-group-2'
> > pool 4: 'SSD-group-3'
> > pool 5: 'SAS-group-2'
> > pool 6: 'SAS-group-3'
> >
> >
> > Is that a real problem?
>=20
> It's not great, but it's not impossible =E2=80=94 right now these are
> "virtual" xattrs and the clients are intercepting calls to them and
> generating the data locally. However, when I look at the kclient
> source code I'm seeing it print out the pool; which version are you
> on?
> -Greg

Hi Greg,

I am running on kernel 3.8.13, with ceph kernel source as available
in that version.

modinfo of ceph.ko and libceph.ko:

[root ~]# modinfo ceph
filename:       /lib/modules/3.8.13/kernel/fs/ceph/ceph.ko
license:        GPL
description:    Ceph filesystem for Linux
author:         Patience Warnick <patience@newdream.net>
author:         Yehuda Sadeh <yehuda@hq.newdream.net>
author:         Sage Weil <sage@newdream.net>
srcversion:     684D8D2460CC33F44986B16
depends:        libceph
intree:         Y
vermagic:       3.8.13 SMP mod_unload modversions=20

[root ~]# modinfo libceph
filename:       /lib/modules/3.8.13/kernel/net/ceph/libceph.ko
license:        GPL
description:    Ceph filesystem for Linux
author:         Patience Warnick <patience@newdream.net>
author:         Yehuda Sadeh <yehuda@hq.newdream.net>
author:         Sage Weil <sage@newdream.net>
srcversion:     62B9BD1907F7AB1CB6FC021
depends:        libcrc32c,dns_resolver
intree:         Y
vermagic:       3.8.13 SMP mod_unload modversions=20

Regards

Andreas Bluemle


> Software Engineer #42 @ http://inktank.com | http://ceph.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20



--=20
Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
ITXperts GmbH                       http://www.itxperts.de
Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910

Company details: http://www.itxperts.de/imprint.htm
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
