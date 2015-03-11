From: Xinze Chi <xmdxcxz@gmail.com>
Subject: Re: [ceph-users] ceph cache tier pool objects not evicted
 automatically even when reaching full ratio
Date: Wed, 11 Mar 2015 19:40:27 +0800
Message-ID: <CANE=7sVRvL7=_KOnDfyDTT7-vgCPWYC++_BRC_R8ELRNCSKeug@mail.gmail.com>
References: <54FED85D.8030307@tatar.ru>
	<54FEE5EA.5090006@tatar.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35668 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbbCKLk2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Mar 2015 07:40:28 -0400
Received: by oifz81 with SMTP id z81so7221336oif.2
        for <ceph-devel@vger.kernel.org>; Wed, 11 Mar 2015 04:40:27 -0700 (PDT)
In-Reply-To: <54FEE5EA.5090006@tatar.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It may be a bug.

We should set target_max_bytes or target_max_objects before tier pool
process request.

2015-03-10 20:39 GMT+08:00 Kamil Kuramshin <kamil.kuramshin@tatar.ru>:
> Thanks a lot to Be-El from #ceph (irc://irc.oftc.net/ceph)
> The problem is resolved after setting 'target_max_bytes' for cache po=
ol:
>
> $ ceph osd pool set cache target_max_bytes 184000000000
>
> Because setting only 'cache_target_full_ratio' to 0.7 - is not suffic=
ient
> for  cache tiering agent, it must know the number of bytes for specif=
ied
> pool that allowed to write, before starting evicting process. And the=
n with
> both options are in place, cache tiering agent will start eviting obj=
ects
> from cache pool when there is 70% of target_max_bytes are written to =
that
> pool (when reacing 129Gb in my case)
>
> here how it was:
>
> [14:45] <Be-El> stannum: there's no limit configured for the cache po=
ol. the
> system cannot know when to evict data
> [14:46] <stannum> Be-El: what kind of limit?
> [14:46] <Be-El> stannum: a limit for the size or the number of object=
s in
> the cache pool
> [14:48] <stannum> Be-El: setting cache_target_full_ratio: 0.7 is not
> sufficient?
> [14:48] <Be-El> stannum: that's a ratio. you need a reference for it
> [14:51] <Be-El> stannum: try setting 'target_max_bytes' to the maximu=
m size
> of the underlying storage minus some percent overhead and keep the
> replication factor in mind
> [14:51] <stannum> Be-El: oh, there is not clear from documentaion. it=
 say
> that: The cache tiering agent can flush or evict objects relative to =
the
> size of the cache pool. And later it says: The cache tiering agent ca=
n flush
> or evict objects based upon the total number of bytes or the total nu=
mber of
> objects.
> [14:52] <stannum> Be-El: and nothing said about to setting both optio=
ns
> [14:52] <Be-El> stannum: yes, the documentation is somewhat lacking. =
ceph
> cannot determine the amount of available space (and thus the maximum
> possible size of a pool)
>
>
> 10.03.2015 14:41, Kamil Kuramshin =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>
> hi, folks! I'm testing cache tier for erasure coded pool and with RBD=
 image
> on it. And now I'm facing a problem with full cache pool and object a=
re not
> evicted automatically, Only if I run manually rados -p cache
> cache-flush-evict-all
>
> client side is:
> superuser@share:~$ uname -a
> Linux share 3.16-2-amd64 #1 SMP Debian 3.16.3-2 (2014-09-20) x86_64
> GNU/Linux
>
>
> ceph node all are debian wheezy
> superuser~$ dpkg -l | grep ceph
> ii  ceph                           0.87-1~bpo70+1                   a=
md64
> distributed storage and file system
> ii  ceph-common                    0.87-1~bpo70+1                   a=
md64
> common utilities to mount and interact with a ceph storage cluster
> ii  ceph-fs-common                 0.87-1~bpo70+1                   a=
md64
> common utilities to mount and interact with a ceph file system
> ii  ceph-mds                       0.87-1~bpo70+1                   a=
md64
> metadata server for the ceph distributed file system
> ii  libcephfs1                     0.87-1~bpo70+1                   a=
md64
> Ceph distributed file system client library
> ii  libcurl3-gnutls:amd64          7.29.0-1~bpo70+1.ceph            a=
md64
> easy-to-use client-side URL transfer library (GnuTLS flavour)
> ii  python-ceph                    0.87-1~bpo70+1                   a=
md64
> Python libraries for the Ceph distributed filesystem
>
>
>
> There are all steps to reproduce (excepting creation of pools):
>
>
>
> superuser@admin:~$ ceph osd pool get ec_backup-storage erasure_code_p=
rofile
> erasure_code_profile: default
> superuser@admin:~$ ceph osd erasure-code-profile get default
> directory=3D/usr/lib/ceph/erasure-code
> k=3D2
> m=3D1
> plugin=3Djerasure
> technique=3Dreed_sol_van
>
>
> *********** ADMIN NODE OPERATIONS ************
>
> superuser@admin:~$ ceph df
> GLOBAL:
>     SIZE     AVAIL     RAW USED     %RAW USED
>     242T      224T        6092G          2.46
> POOLS:
>     NAME                  ID     USED      %USED     MAX AVAIL     OB=
JECTS
>     ec_backup-storage     4          0         0          147T       =
    0
>     cache                 5          0         0          185G       =
    0
>     block-devices         6      1948G      0.79        75638G      4=
98771
> superuser@admin:~$ rados df
> pool name       category                 KB      objects       clones
> degraded      unfound           rd        rd KB           wr        w=
r KB
> block-devices   -                 2042805201       498771            =
0
> 0           0        67127    259320535      2070571   2403248346
> cache           -                          0            0            =
0
> 0           0        60496    247235411       966553    499544074
> ec_backup-storage -                          0            0          =
  0
> 0           0       156988    537227276       400355    819838985
>   total used      6388431372       498771
>   total avail   240559782780
>   total space   260163775608
>
> ***** 'cache' pool is replicated pool, 'ec_backup-storage' - Erasure =
Encoded
> pool *****
> ***** running simple script for enabling cache tiering:
>
>
> ***** There is my simple script for enabling cache tier:
>
> superuser@admin:~$ ./enable_cache_tier.sh cache ec_backup-storage
> pool 'cache' is now (or already was) a tier of 'ec_backup-storage'
> set cache-mode for pool 'cache' to writeback
> overlay for 'ec_backup-storage' is now (or already was) 'cache'
> set pool 5 hit_set_type to bloom
> set pool 5 cache_target_dirty_ratio to 0.4
> set pool 5 cache_target_full_ratio to 0.7
> set pool 5 cache_min_flush_age to 10
> set pool 5 cache_min_evict_age to 10
>
> ***** Displaying some cache pool parameters:
>
> superuser@admin:~$ for param in cache_target_dirty_ratio
> cache_target_full_ratio target_max_bytes target_max_objects
> cache_min_flush_age cache_min_evict_age; do  ceph osd pool get cache =
$param;
> done
> cache_target_dirty_ratio: 0.4
> cache_target_full_ratio: 0.7
> target_max_bytes: 0
> target_max_objects: 0
> cache_min_flush_age: 10
> cache_min_evict_age: 10
>
>
> *********** END ADMIN NODE OPERATIONS ************
>
> *********** CEPH CLIENT OPERATIONS ************
>
> superuser@share:~$ rbd create -p  ec_backup-storage ec_image.img --si=
ze
> 500000 --image-format 2
> superuser@share:~$ rbd -p ec_backup-storage ls
> ec_image.img
> superuser@share:~$ sudo rbd map -p ec_backup-storage ec_image.img
> /dev/rbd0
> superuser@share:~$ rbd showmapped
> id pool              image        snap device
> 0  ec_backup-storage ec_image.img -    /dev/rbd0
> superuser@share:~$ sudo parted /dev/rbd0 p
> Error: /dev/rbd0: unrecognised disk label
> Model: Unknown (unknown)
> Disk /dev/rbd0: 524GB
> Sector size (logical/physical): 512B/512B
> Partition Table: unknown
> Disk Flags:
>
>
> **** now start filling the rbd disk with 400Gb of 'zeros' ****
> superuser@share:~$ sudo dd if=3D/dev/zero of=3D/dev/rbd0 bs=3D4M coun=
t=3D100000
> oflag=3Ddirect
> ^C39901+0 =D0=B7=D0=B0=D0=BF=D0=B8=D1=81=D0=B5=D0=B9 =D0=BF=D0=BE=D0=BB=
=D1=83=D1=87=D0=B5=D0=BD=D0=BE ; There I'm pressed CTRL+C because alrea=
dy
> getting warnings in cpeh -s (see below)
> 39901+0 =D0=B7=D0=B0=D0=BF=D0=B8=D1=81=D0=B5=D0=B9 =D0=BE=D1=82=D0=BF=
=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE
>  =D1=81=D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=BE 1=
67356923904 =D0=B1=D0=B0=D0=B9=D1=82=D0=B0 (167 GB), 3387,59 c, 49,4 MB=
/c
>
>
> *********** END CEPH CLIENT OPERATIONS ************
>
>
> *********** ADMIN NODE OPERATIONS ************
>
>
> **** Now check ceph df: 145G of 172G 'cache' pool it is about 90% is
> occupied already!
> superuser@admin:~$ ceph df
> GLOBAL:
>     SIZE     AVAIL     RAW USED     %RAW USED
>     242T      223T        6555G          2.64
> POOLS:
>     NAME                  ID     USED      %USED     MAX AVAIL     OB=
JECTS
>     ec_backup-storage     4          0         0          147T       =
    0
>     cache                 5       155G      0.06        12333M       =
39906
>     block-devices         6      1948G      0.79        75642G      4=
98771
>
>
> ***** ec_backup-storage - tier pool for cold data still empty????
> ***** but in the same time:
> superuser@admin:~$ ceph health detail
> HEALTH_WARN 3 near full osd(s)
> osd.45 is near full at 88%
> osd.95 is near full at 87%
> osd.100 is near full at 86%
>
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
