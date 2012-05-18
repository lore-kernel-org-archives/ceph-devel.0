From: Christian Brunner <christian@brunner-muc.de>
Subject: Re: is rados block cluster production ready ?
Date: Fri, 18 May 2012 10:45:48 +0200
Message-ID: <CAJafhzR2PLsH1B3Wwz5c=WAmVNsA1+GeTVKR4o7uLJVoeC_Ubw@mail.gmail.com>
References: <531ff5f3-11d5-488e-adfb-68000f3c36c0@mailpro>
	<c1099add-5872-4b8b-9250-9dd33791a776@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:54234 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932852Ab2ERIpt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 May 2012 04:45:49 -0400
Received: by gglu4 with SMTP id u4so2604220ggl.19
        for <ceph-devel@vger.kernel.org>; Fri, 18 May 2012 01:45:48 -0700 (PDT)
In-Reply-To: <c1099add-5872-4b8b-9250-9dd33791a776@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org

2012/5/18 Alexandre DERUMIER <aderumier@odiso.com>:
> Hi,
> I'm going to build a rados block cluster for my kvm hypervisors.
>
> Is it already production ready ? (stable,no crash)

We are using 0.45 in production. Recent ceph versions are quite stable
(although we hat some troubles with excessive logging and a full log
partition lately which caused our cluster to halt).

> I have read some btrfs bugs on this mailing list, so I'm a bit scary...

For the moment I would definitely recommend using XFS as the
underlying filesystem. At least until there is a fix for the
orphan_commit_root problem. XFS comes with a slight performance
impact, but it seems to be the only filesystem that is able to handle
heavy ceph workload for the moment.

> Also, what performance could I expect ?

We are running a small ceph cluster (4 Servers with 4 OSDs each) on a
10GE network. Servers are spread across two datacenters with a 5km (3
mile) long 10GE fibre-link for data replication. Our servers are
equipped with 80GB Fusion-IO drives (for the journal) and traditional
3,5'' SAS drives in a RAID5 configuration (but I would not reccommend
this setup).

From a guest we can get a throughput ~ 500MB/s.

> I try to build a fast cluster, with fast ssd disk.
> each node : 8 osds with "ocz talos" sas drive + stec zeusram drive (8GB nvram) for the journal + 10GB ethernet.
> Do you think I can saturate the 10GB ?

This is probably the best hardware for a ceph cluster money can buy.
Are you planning a single SAS drive per OSD?

I still don't know the cause exactly, but we are not able to saturate
10GE (maybe it's the latency on the WAN link or some network
configuration problem).

> I also have some questions about performance in time.
> I have had somes problems with my zfs san and zfs fragmentation and metastab problem.
> How does btrfs perform in time ?

I did some artificial tests with btrfs with large metadata enabled
(e.g. mkfs.btrfs -l 64k -n 64k) the performance degradation seems to
be gone.

> About network, does the rados protocol support some kind of multipathing ? Or does I need to use bonding/lacp ?

We are using bonding. The rados-client is doing a failover to another
osd node after a few seconds, when there is no response from the OSD.
(You should read about CRUSH in the ceph docs).

Regards,
Christian
