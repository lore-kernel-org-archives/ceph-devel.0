From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Crush not deliverying data uniformly -> HEALTH_ERR full osd
Date: Sun, 5 Aug 2012 18:15:54 -0700
Message-ID: <CAC-hyiG54FgJmhHibkY6a-qqePALEjGrWrxNwHo2KhehswLfpw@mail.gmail.com>
References: <81C477727102DA4E9B2605AC748C495419104F5549@exch10>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60303 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755051Ab2HFBP4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 5 Aug 2012 21:15:56 -0400
Received: by bkwj10 with SMTP id j10so836201bkw.19
        for <ceph-devel@vger.kernel.org>; Sun, 05 Aug 2012 18:15:54 -0700 (PDT)
In-Reply-To: <81C477727102DA4E9B2605AC748C495419104F5549@exch10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul Pettigrew <Paul.Pettigrew@mach.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, Aug 5, 2012 at 5:16 PM, Paul Pettigrew
<Paul.Pettigrew@mach.com.au> wrote:
>
> Hi Ceph community
>
> We are at the stage of performance capacity testing, where significant
> amounts of backup data is being written to Ceph.
>
> The issue we have, is that the underlying HDD's are not being populated
> (roughly) uniformly, and our Ceph system hits a brick wall after a couple of
> days our 30TB storage system is no longer able to operate after having only
> stored ~7TB.
>
> Basically, despite HDD's (1:1 ratio between OSD and HDD) all being the
> same storage size and weighting in the Crushmap, we have disks either:
> a) using 1% space;
> b) using 48%; or
> c) using 96%
> Too precise a split to be an accident.  See below for more detail
> (osd11-22 not expected to get data, per our crushmap):
>
>
> ceph pg dump
> <snip>
> pool 0  2442    0       0       0       10240000000     7302520 7302520
> pool 1  57      0       0       0       127824767       5603518 5603518
> pool 2  0       0       0       0       0       0       0
> pool 3  1808757 0       0       0       7584377697985   1104048 1104048
>  sum    1811256 0       0       0       7594745522752   14010086
> 14010086
> osdstat kbused  kbavail kb      hb in   hb out
> 0       930606904       1021178408      1953514584
> [11,12,13,14,15,16,17,18,19,20,21,22]   []
> 1       1874428 1949525164      1953514584
> [11,12,13,14,15,16,17,18,19,20,21,22]   []
> 2       928811428       1022963676      1953514584
> [11,12,13,14,15,16,17,18,19,20,21,22]   []
> 3       929733676       1022051996      1953514584
> [11,12,13,14,15,16,17,18,19,20,21,22]   []
> 4       1719124 1949678844      1953514584
> [11,12,13,14,15,16,17,18,19,20,21,22]   []
> 5       1853452 1949545892      1953514584
> [11,12,13,14,15,16,17,18,19,20,21,22]   []
> 6       930979476       1020807132      1953514584
> [11,12,13,14,15,16,17,18,19,20,21,22]   []
> 7       1808968 1949590496      1953514584
> [11,12,13,14,15,16,17,18,19,20,21,22]   []
> 8       934035924       1017759100      1953514584
> [11,12,13,14,15,16,17,18,19,20,21,22]   []
> 9       1855955384      94927432        1953514584
> [11,12,13,14,15,16,17,18,19,20,21,22]   []
> 10      933572004       1018232340      1953514584
> [11,12,13,14,15,16,17,18,19,20,21,22]   []
> 11      2057096 953060760       957230808
> [0,1,2,3,4,5,6,7,8,9,10,17,18,19,20,21,22]      []
> 12      2053512 953064656       957230808
> [0,1,2,3,4,5,6,7,8,9,10,17,18,19,20,21,22]      []
> 13      2148732 972501316       976762584
> [0,1,2,3,4,5,6,7,8,9,10,17,18,19,20,21,22]      []
> 14      2064640 972585104       976762584
> [0,1,2,3,4,5,6,7,8,9,10,17,18,19,20,21,22]      []
> 15      1945388 972703468       976762584
> [0,1,2,3,4,5,6,7,8,9,10,17,18,19,20,21] []
> 16      2051708 972599412       976762584
> [0,1,2,3,4,6,7,8,9,10,17,18,19,20,21]   []
> 17      2137632 952980216       957230808
> [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]      []
> 18      2000124 953117508       957230808
> [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]      []
> 19      2095124 972554492       976762584
> [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]      []
> 20      1986800 972662640       976762584
> [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]      []
> 21      2035204 972615332       976762584
> [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]      []
> 22      1961412 972687788       976762584
> [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]      []
>  sum    7475488140      25609393172     33131684328
>
> 2012-08-06 10:03:58.964716 7f06783bb700  0 -- 10.32.0.10:0/15147
> send_keepalive con 0x223f690, no pipe.
>
>
> root@dsanb1-coy:~# df -h
> Filesystem                               Size  Used Avail Use% Mounted on
> /dev/md0                                 462G   12G  446G   3% /
> udev                                      12G  4.0K   12G   1% /dev
> tmpfs                                    4.8G  448K  4.8G   1% /run
> none                                     5.0M     0  5.0M   0% /run/lock
> none                                      12G     0   12G   0% /run/shm
> /dev/sdc                                 1.9T  888G  974G  48%
> /ceph-data/osd.0
> /dev/sdd                                 1.9T  1.8G  1.9T   1%
> /ceph-data/osd.1
> /dev/sdp                                 1.9T  891G  972G  48%
> /ceph-data/osd.10
> /dev/sde                                 1.9T  886G  976G  48%
> /ceph-data/osd.2
> /dev/sdf                                 1.9T  887G  975G  48%
> /ceph-data/osd.3
> /dev/sdg                                 1.9T  1.7G  1.9T   1%
> /ceph-data/osd.4
> /dev/sdh                                 1.9T  1.8G  1.9T   1%
> /ceph-data/osd.5
> /dev/sdi                                 1.9T  888G  974G  48%
> /ceph-data/osd.6
> /dev/sdm                                 1.9T  1.8G  1.9T   1%
> /ceph-data/osd.7
> /dev/sdn                                 1.9T  891G  971G  48%
> /ceph-data/osd.8
> /dev/sdo                                 1.9T  1.8T   91G  96%
> /ceph-data/osd.9
> 10.32.0.10,10.32.0.25,10.32.0.11:6789:/   31T  7.1T   24T  23% /mnt/ceph
>
>
> We are writing via fstab based cephfs mounts, and the above is going to
> pool3, which is a "backup" pool where we are testing replication level of 1x
> only. This should not have any effect though? Below will illustrate the
> layout we are using (above data writing issue is only going to the first
> node per our testing design):
>
> root@dsanb1-coy:~# ceph osd tree
> dumped osdmap tree epoch 136
> # id    weight  type name       up/down reweight
> -7      23      zone bak
> -6      23              rack 1nrack
> -2      11                      host dsanb1-coy
> 0       2                               osd.0   up      1
> 1       2                               osd.1   up      1
> 10      2                               osd.10  up      1
> 2       2                               osd.2   up      1
> 3       2                               osd.3   up      1
> 4       2                               osd.4   up      1
> 5       2                               osd.5   up      1
> 6       2                               osd.6   up      1
> 7       2                               osd.7   up      1
> 8       2                               osd.8   up      1
> 9       2                               osd.9   up      1
> -1      23      zone default
> -3      23              rack 2nrack
> -2      11                      host dsanb1-coy
> 0       2                               osd.0   up      1
> 1       2                               osd.1   up      1
> 10      2                               osd.10  up      1
> 2       2                               osd.2   up      1
> 3       2                               osd.3   up      1
> 4       2                               osd.4   up      1
> 5       2                               osd.5   up      1
> 6       2                               osd.6   up      1
> 7       2                               osd.7   up      1
> 8       2                               osd.8   up      1
> 9       2                               osd.9   up      1
> -4      6                       host dsanb2-coy
> 11      1                               osd.11  up      1
> 12      1                               osd.12  up      1
> 13      1                               osd.13  up      1
> 14      1                               osd.14  up      1
> 15      1                               osd.15  up      1
> 16      1                               osd.16  up      1
> -5      6                       host dsanb3-coy
> 17      1                               osd.17  up      1
> 18      1                               osd.18  up      1
> 19      1                               osd.19  up      1
> 20      1                               osd.20  up      1
> 21      1                               osd.21  up      1
> 22      1                               osd.22  up      1
>
>
> Has anybody got any suggestions?
>

How many pgs per pool do you have? Specifically:
$ ceph osd dump | grep ^pool

Thanks,
Yehuda
