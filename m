From: =?UTF-8?B?0JrQvtC90YHRgtCw0L3RgtC40L0g0KHQsNGF0LjQvdC+0LI=?=
	<sakhinov@gmail.com>
Subject: Re: inconsistent pgs
Date: Sun, 9 Aug 2015 15:21:39 +0300
Message-ID: <CAJnOFApKhHff7ropWyvAnFZo9ETrvwQuEWmUBOFSa4XB=aL-=g@mail.gmail.com>
References: <CAJnOFAqRjXcuO0bJN8PSLsnnMhBjYMOTJTFY8T+4Z36LaBiMfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35468 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932973AbbHIMWA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 9 Aug 2015 08:22:00 -0400
Received: by wibxm9 with SMTP id xm9so109036983wib.0
        for <ceph-devel@vger.kernel.org>; Sun, 09 Aug 2015 05:21:59 -0700 (PDT)
In-Reply-To: <CAJnOFAqRjXcuO0bJN8PSLsnnMhBjYMOTJTFY8T+4Z36LaBiMfg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Just more info about my config. Maybe I have to change default ruleset
from "step chooseleaf firstn 0 type host" to "step chooseleaf firstn 0
type chasis"?

# ceph osd tree
ID  WEIGHT   TYPE NAME            UP/DOWN REWEIGHT PRIMARY-AFFINITY
 -3  0.91998 root ssd
 -6  0.45999     host block1
  2  0.23000         osd.2             up  1.00000          1.00000
  3  0.23000         osd.3             up  1.00000          1.00000
 -8  0.45999     host block4
  4  0.23000         osd.4             up  1.00000          1.00000
 11  0.23000         osd.11            up  1.00000          1.00000
 -1 29.12000 root default
 -9  7.28000     chassis chassis3
 -4  7.28000         host block3
  8  3.64000             osd.8         up  1.00000          1.00000
  6  3.64000             osd.6         up  1.00000          1.00000
-10  7.28000     chassis chassis5
 -7  7.28000         host block5
  0  3.64000             osd.0         up  1.00000          1.00000
  5  3.64000             osd.5         up  1.00000          1.00000
-11  7.28000     chassis chassis0
 -2  7.28000         host block0
  1  3.64000             osd.1         up  1.00000          1.00000
  9  3.64000             osd.9         up  1.00000          1.00000
-12  7.28000     chassis chassis2
 -5  7.28000         host block2
 10  3.64000             osd.10        up  1.00000          1.00000
  7  3.64000             osd.7         up  1.00000          1.00000

# begin crush map
tunable choose_local_tries 0
tunable choose_local_fallback_tries 0
tunable choose_total_tries 50
tunable chooseleaf_descend_once 1

# devices
device 0 osd.0
device 1 osd.1
device 2 osd.2
device 3 osd.3
device 4 osd.4
device 5 osd.5
device 6 osd.6
device 7 osd.7
device 8 osd.8
device 9 osd.9
device 10 osd.10
device 11 osd.11

# types
type 0 osd
type 1 host
type 2 chassis
type 3 rack
type 4 row
type 5 pdu
type 6 pod
type 7 room
type 8 datacenter
type 9 region
type 10 root

# buckets
host block3 {
        id -4           # do not change unnecessarily
        # weight 7.280
        alg straw
        hash 0  # rjenkins1
        item osd.8 weight 3.640
        item osd.6 weight 3.640
}
chassis chassis3 {
        id -9           # do not change unnecessarily
        # weight 7.280
        alg straw
        hash 0  # rjenkins1
        item block3 weight 7.280
}
host block5 {
        id -7           # do not change unnecessarily
        # weight 7.280
        alg straw
        hash 0  # rjenkins1
        item osd.0 weight 3.640
        item osd.5 weight 3.640
}
chassis chassis5 {
        id -10          # do not change unnecessarily
        # weight 7.280
        alg straw
        hash 0  # rjenkins1
        item block5 weight 7.280
}
host block0 {
        id -2           # do not change unnecessarily
        # weight 7.280
        alg straw
        hash 0  # rjenkins1
        item osd.1 weight 3.640
        item osd.9 weight 3.640
}
chassis chassis0 {
        id -11          # do not change unnecessarily
        # weight 7.280
        alg straw
        hash 0  # rjenkins1
        item block0 weight 7.280
}
host block2 {
        id -5           # do not change unnecessarily
        # weight 7.280
        alg straw
        hash 0  # rjenkins1
        item osd.10 weight 3.640
        item osd.7 weight 3.640
}
chassis chassis2 {
        id -12          # do not change unnecessarily
        # weight 7.280
        alg straw
        hash 0  # rjenkins1
        item block2 weight 7.280
}
root default {
        id -1           # do not change unnecessarily
        # weight 29.120
        alg straw
        hash 0  # rjenkins1
        item chassis3 weight 7.280
        item chassis5 weight 7.280
        item chassis0 weight 7.280
        item chassis2 weight 7.280
}
host block1 {
        id -6           # do not change unnecessarily
        # weight 0.460
        alg straw
        hash 0  # rjenkins1
        item osd.2 weight 0.230
        item osd.3 weight 0.230
}
host block4 {
        id -8           # do not change unnecessarily
        # weight 0.460
        alg straw
        hash 0  # rjenkins1
        item osd.4 weight 0.230
        item osd.11 weight 0.230
}
root ssd {
        id -3           # do not change unnecessarily
        # weight 0.920
        alg straw
        hash 0  # rjenkins1
        item block1 weight 0.460
        item block4 weight 0.460
}

# rules
rule replicated_ruleset {
        ruleset 0
        type replicated
        min_size 1
        max_size 10
        step take default
        step chooseleaf firstn 0 type host
        step emit
}
rule ssd_ruleset {
        ruleset 1
        type replicated
        min_size 1
        max_size 10
        step take ssd
        step chooseleaf firstn 0 type host
        step emit
}

# end crush map

2015-08-08 17:13 GMT+03:00 =D0=9A=D0=BE=D0=BD=D1=81=D1=82=D0=B0=D0=BD=D1=
=82=D0=B8=D0=BD =D0=A1=D0=B0=D1=85=D0=B8=D0=BD=D0=BE=D0=B2 <sakhinov@gm=
ail.com>:
> Hi!
>
> I have a large number of inconsistent pgs 229 of 656, and it's
> increasing every hour.
> I'm using ceph version 0.94.2 (5fb85614ca8f354284c713a2f9c610860720bb=
f3).
>
> For example, pg 3.d8:
> # ceph health detail | grep 3.d8
> pg 3.d8 is active+clean+scrubbing+deep+inconsistent, acting [1,7]
>
> # grep 3.d8 /var/log/ceph/ceph-osd.1.log | less -S
> 2015-08-07 13:10:48.311810 7f5903f7a700 0 log_channel(cluster) log
> [INF] : 3.d8 repair starts 2015-08-07 13:12:05.703084 7f5903f7a700 -1
> log_channel(cluster) log [ERR] : repair 3.d8
> cbd2d0d8/rbd_data.6a5cf474b0dc51.0000000000000b1f/head//3 on disk dat=
a
> digest 0x6e4d80bf !=3D 0x6fb5b103 2015-08-07 13:13:26.837524
> 7f5903f7a700 -1 log_channel(cluster) log [ERR] : repair 3.d8
> b5892d8/rbd_data.dbe674b0dc51.00000000000001b9/head//3 on disk data
> digest 0x79082779 !=3D 0x9f102f3d 2015-08-07 13:13:44.874725
> 7f5903f7a700 -1 log_channel(cluster) log [ERR] : repair 3.d8
> ee6dc2d8/rbd_data.e7592ae8944a.0000000000000833/head//3 on disk data
> digest 0x63ab49d0 !=3D 0x68778496 2015-08-07 13:14:19.378582
> 7f5903f7a700 -1 log_channel(cluster) log [ERR] : repair 3.d8
> d93e14d8/rbd_data.3ef8442ae8944a.0000000000000729/head//3 on disk dat=
a
> digest 0x3cdb1f5c !=3D 0x4e0400c2 2015-08-07 13:23:38.668080
> 7f5903f7a700 -1 log_channel(cluster) log [ERR] : 3.d8 repair 4 errors=
,
> 0 fixed 2015-08-07 13:23:38.714668 7f5903f7a700 0 log_channel(cluster=
)
> log [INF] : 3.d8 deep-scrub starts 2015-08-07 13:25:00.656306
> 7f5903f7a700 -1 log_channel(cluster) log [ERR] : deep-scrub 3.d8
> cbd2d0d8/rbd_data.6a5cf474b0dc51.0000000000000b1f/head//3 on disk dat=
a
> digest 0x6e4d80bf !=3D 0x6fb5b103 2015-08-07 13:26:18.775362
> 7f5903f7a700 -1 log_channel(cluster) log [ERR] : deep-scrub 3.d8
> b5892d8/rbd_data.dbe674b0dc51.00000000000001b9/head//3 on disk data
> digest 0x79082779 !=3D 0x9f102f3d 2015-08-07 13:26:42.084218
> 7f5903f7a700 -1 log_channel(cluster) log [ERR] : deep-scrub 3.d8
> ee6dc2d8/rbd_data.e7592ae8944a.0000000000000833/head//3 on disk data
> digest 0x59a6e7e0 !=3D 0x68778496 2015-08-07 13:26:56.495207
> 7f5903f7a700 -1 log_channel(cluster) log [ERR] : be_compare_scrubmaps=
:
> 3.d8 shard 1: soid
> cc49f2d8/rbd_data.3ef8442ae8944a.0000000000000aff/head//3 data_digest
> 0x4e20a792 !=3D known data_digest 0xc0e9b2d2 from auth shard 7
> 2015-08-07 13:27:12.134765 7f5903f7a700 -1 log_channel(cluster) log
> [ERR] : deep-scrub 3.d8
> d93e14d8/rbd_data.3ef8442ae8944a.0000000000000729/head//3 on disk dat=
a
> digest 0x3cdb1f5c !=3D 0x4e0400c2
>
> osd.7.log is clean for that period of time.
> /var/log/dmesg is also clean.
>
> Please help to heal my cluster.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
