From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Tier and MetroCluster
Date: Fri, 17 Feb 2012 10:05:44 -0800
Message-ID: <CAORUGqByVskXRNDA+8USz1_0jTHy6BPyHV9rjayr4fmpfrCLyA@mail.gmail.com>
References: <-4946957540367980946@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40728 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139Ab2BQSGG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Feb 2012 13:06:06 -0500
Received: by wgbdt10 with SMTP id dt10so2953607wgb.1
        for <ceph-devel@vger.kernel.org>; Fri, 17 Feb 2012 10:06:04 -0800 (PST)
In-Reply-To: <-4946957540367980946@unknownmsgid>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?S=C5=82awomir_Skowron?= <szibis@gmail.com>
Cc: ceph-devel@vger.kernel.org

2012/2/17 S=C5=82awomir Skowron <szibis@gmail.com>:
> 1. Is there any plan about tier support. Example:
> I have ceph cluster with fast SAS drives, and a losts of RAM, and SSD
> acceleration, and 10GE network. I use only RBD, and RadosGW. Cluster
> have relative small capacity, but its fast.
> I have a second cluster with diffrent configuration, with a large
> number of big SATA drives, and smaller number of RAM, 1Gb ethernet.
> Same usage as above.
> All i need is to have phisical 2 clusters, but with some tier
> function, to move old objects from fast to slow cluster (for archive)=
,
> and opposite.

You can do this right now, by having just one cluster, specifying
different crush rulesets for different pools, and then moving your
objects from one pool to another as they get "old". You'll need to
manage the migration yourself -- with RADOS, explicitly creating
objects in the "old" pool, with Ceph DFS, "cephfs PATH set_layout
--pool MYPOOL" only affects new files. For radosgw, this doesn't
currently exist, and I'm not sure how it would behave, but it is
conceivable.

> If ceph will be very stable this can be done inside one cluster it
> will be much simpler, but crush need to know what is faster, and what
> is slower.

There are no extra smarts about it. For RADOS, there most likely will
be no automatic thing here -- after all, we are intentionally avoiding
any lookup tables -- for the Ceph DFS, I can see that the set_layout
logic could be extended to migrate existing files too. And radosgw
might get this as an automatic feature, one day.

> 2. Like above two clusters this time same configurations and size, bu=
t
> with async replication between.
> Replication can be done by the external replication darmon on top of
> rados, or other solution.
>
> Is there any plans with any of this ?? Or something like this ??

I think this is something a lot of people will want, so it probably
will get done at some point. It is not being developed, currently.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
