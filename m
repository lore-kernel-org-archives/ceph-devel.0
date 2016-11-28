From: Sage Weil <sweil@redhat.com>
Subject: Re: how to narrow down the osd map space
Date: Mon, 28 Nov 2016 14:46:06 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611281443150.28496@piezo.us.to>
References: <alpine.DEB.2.11.1611220318580.5480@piezo.us.to> <2016112819084823601154@139.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1815675866-1480344368=:28496"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932467AbcK1OqJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 28 Nov 2016 09:46:09 -0500
In-Reply-To: <2016112819084823601154@139.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "idealguo@139.com" <idealguo@139.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1815675866-1480344368=:28496
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

[adding ceph-devel]

On Mon, 28 Nov 2016, idealguo@139.com wrote:
> Hi sage,
>     We are using ceph as cloud object storage service now. In our
> enviroment, the osd map looks a little big. is it ok? could you please take
> a look? thanks
> 
>         ceph version: 10.2.3 (5 monitors and 2376 osds)
>         OS: centos 7.2
> 
>         $ ceph df
>         GLOBAL:
>             SIZE      AVAIL     RAW USED     %RAW USED 
>             7176T     7173T        2851G          0.04 
>         POOLS:
>             NAME                                      
> ID     USED       %USED     MAX AVAIL     OBJECTS 
>             default.rgw.buckets.data      
>  36     25403M         0         5126T      400475 
>             ... omit 12 empty pools of rgw
>            .rgw.root                                
>  50       9937         0        62757G          22 
> 
> You can see, wo only have 2.5GB data, but RAW USED 2.8TB. Each raw osd
> occupied more than 1GB space for omap and meta
> for each osd, we find some details about space:
>     $ pwd
>     /var/lib/ceph/osd/ceph-462
>     $ du -h --max-depth=1
>     1.3G ./current
>     1.3G .
>     $ cd current
>     $ du -h --max-depth=1
>     303M ./omap
>     915M ./meta
>     0     ./36.2446s0_TEMP
>     64K ./36.5276s0_head
>     0     ./36.4627s0_TEMP
>     0     ./36.26fes0_TEMP
>     88K ./36.53b0s0_head
>     132K ./36.37ds0_head
>     ... omit some output
>     
>     $ cd meta
>     $ du -h --max-depth=2
>     0 ./DIR_2
>     0 ./DIR_5
>     59M ./DIR_8/DIR_0
>     58M ./DIR_8/DIR_1
>     56M ./DIR_8/DIR_2
>     55M ./DIR_8/DIR_3
>     58M ./DIR_8/DIR_4
>     59M ./DIR_8/DIR_5
>     57M ./DIR_8/DIR_6
>     58M ./DIR_8/DIR_7
>     57M ./DIR_8/DIR_8
>     56M ./DIR_8/DIR_9
>     55M ./DIR_8/DIR_A
>     57M ./DIR_8/DIR_B
>     58M ./DIR_8/DIR_C
>     57M ./DIR_8/DIR_D
>     58M ./DIR_8/DIR_E
>     58M ./DIR_8/DIR_F
>     915M ./DIR_8
>     915M .
> 
>     $ pwd
>     /var/lib/ceph/osd/ceph-462/current/meta/DIR_8/DIR_0
>     $ ll
>     total 59800
>    -rw-r--r-- 1 ceph ceph 1557305 Nov 17 18:15 osdmap.4504__0_0A0D9C08__none
> 
>    -rw-r--r-- 1 ceph ceph 1558800 Nov 17 19:07 osdmap.4519__0_0A0DAB08__none
> 
>    -rw-r--r-- 1 ceph ceph 1609517 Nov 17 20:02 osdmap.4533__0_0A0DA608__none
> 
>     ... omit some output
> 
> here are some ceph configurations in ceph.conf
>     [osd]
>     osd_heartbeat_grace = 20
>     osd_heartbeat_interval = 6
>     osd_heartbeat_min_peers = 10
>     osd_mon_heartbeat_interval = 30
>     leveldb_write_buffer_size = 33554432
>     leveldb_compression = False
>     leveldb_cache_size = 536870912
>     leveldb_block_size = 65536

Two things:

1) The OSDMap sizes go down with Kraken due to a more efficient addr 
encoding.  So this will get better over time.

2) You can reduce the nubmer of historical maps that the mon keeps around, 
which will in turn reduce the number of maps that OSDs are storing:

  mon_min_osdmap_epochs = 500

is the default, but setting it to something like 200 or even 100 should be 
safe.

sage

--8323329-1815675866-1480344368=:28496--
