From: Gregory Farnum <greg@inktank.com>
Subject: Re: ceph file system: extended attributes differ between ceph.ko and ceph-fuse
Date: Tue, 23 Jul 2013 15:55:25 -0700
Message-ID: <CAPYLRzj0Ts9HDURGCa=C-yctqMo-N-DrrGQP6nd+ACTkWNnqBA@mail.gmail.com>
References: <20130718124949.00cfec42@doppio>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:47541 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934428Ab3GWWz1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Jul 2013 18:55:27 -0400
Received: by mail-wg0-f52.google.com with SMTP id b13so2146516wgh.31
        for <ceph-devel@vger.kernel.org>; Tue, 23 Jul 2013 15:55:25 -0700 (PDT)
In-Reply-To: <20130718124949.00cfec42@doppio>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Bluemle <andreas.bluemle@itxperts.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Jul 18, 2013 at 3:49 AM, Andreas Bluemle
<andreas.bluemle@itxperts.de> wrote:
> Hi,
>
> I am looking at ceph filesystem both via the kernel module
> and ceph-fuse.
>
> I am running on CentOS6.4 with
>  - kernel 3.8.13 (for ceph.ko) and
>  - ceph v0.61.4 userland components
>
> I encounter an inconsistency between ceph.ko and ceph-fuse
> regarding extended attributes:
>
> - I have the ceph fs mounted at mount points
>   /mnt/cephfs (using ceph.ko) and /mnt/cephfs-fuse
>
> [root@rx37-2 fs_2]# mount | grep ceph
> 10.10.38.13:/ on /mnt/cephfs type ceph (name=3Dadmin,key=3Dclient.adm=
in)
> ceph-fuse on /mnt/cephfs-fuse type fuse.ceph-fuse
>        (rw,nosuid,nodev,allow_other,default_permissions)
>
> - I inspect the same file from the two mointpoints
>
> [root@rx37-2 mnt]# getfattr -d -m - cephfs-fuse/ssd-pool-3/file1
> # file: cephfs-fuse/ssd-pool-3/file1
> ceph.file.layout=3D"stripe_unit=3D4194304 stripe_count=3D1
> object_size=3D4194304 pool=3DSSD-group-2"
>
> [root@rx37-2 mnt]# getfattr -d -m - cephfs/ssd-pool-3/file1
> # file: cephfs/ssd-pool-3/file1
> ceph.file.layout=3D"chunk_bytes=3D4194304\012stripe_count=3D1\012obje=
ct_size=3D4194304\012"
> ceph.layout=3D"chunk_bytes=3D4194304\012stripe_count=3D1\012object_si=
ze=3D4194304\012"
>
> Where getfattr returns info about the pool via ceph-fuse,
> it doesn't show that info via ceph.ko.
>
> - use ceph utilities to look at the file shows the missing pieces;
>   at least, the results are consistent.
>
> [root@rx37-2 mnt]# cephfs cephfs/ssd-pool-3/file1 show_layout
> layout.data_pool:     3
> layout.object_size:   4194304
> layout.stripe_unit:   4194304
> layout.stripe_count:  1
> [root@rx37-2 mnt]# ceph osd dump | grep pool | \
>               awk '{ print $1 " " $2 ": " $3 }'
> pool 0: 'data'
> pool 1: 'metadata'
> pool 2: 'rbd'
> pool 3: 'SSD-group-2'
> pool 4: 'SSD-group-3'
> pool 5: 'SAS-group-2'
> pool 6: 'SAS-group-3'
>
>
> Is that a real problem?

It's not great, but it's not impossible =97 right now these are
"virtual" xattrs and the clients are intercepting calls to them and
generating the data locally. However, when I look at the kclient
source code I'm seeing it print out the pool; which version are you
on?
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
