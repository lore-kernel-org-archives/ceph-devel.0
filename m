From: Sage Weil <sage@inktank.com>
Subject: Re: Ceph remap/recovery stuck
Date: Fri, 24 Aug 2012 09:35:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208240931200.29719@cobra.newdream.net>
References: <CAMwB3TidwXsCFUFGE79S+axZRm6trFz_sX_woTeoPcxanMMkTA@mail.gmail.com> <CAMwB3TiX2xYAA9mUp5g4G=f2+odvRwk3RNpeTNVQ_GwMLLJaig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60861 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964839Ab2HXQf3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Aug 2012 12:35:29 -0400
In-Reply-To: <CAMwB3TiX2xYAA9mUp5g4G=f2+odvRwk3RNpeTNVQ_GwMLLJaig@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 24 Aug 2012, S?awomir Skowron wrote:
> I have found workaround.
> 
> Change CRUSH to replication to osd in rule for this pool, and after
> recovery, remapped data, i just change same rule into rack awarenes,
> and whole cluster, recover again, and back to normal.
> 
> Is there any way, to start refill, recovery in this situation for this
> specyfic OSD ??

This sounds like it might be a problem with the crush retry behavior.  
In some cases it would fail to generate teh right number of replicas for a 
given input.  We fixed this by adding tunables that disable the old/bad 
behavior, but haven't enabled it by default because support is only now 
showing up in new kernels.  If you aren't using older kernel clients, you 
can enable the new values on your cluster by following the instructions 
at:

	http://ceph.com/docs/master/ops/manage/crush/#tunables

FWIW you can test whether this helps by extracting your crushmap from 
the cluster, making whatever changes you are planning to the map, and then 
running

 crushtool -i newmap --test

and verify that you get the right number of results for numrep=3 and 
below.  There are a bunch of options you can pass to adjust the range of 
inputs that are tested (e.g.,  --min-x 1 --max-x 100000, --num-rep 3, 
etc.).  crushtool is also used to adjust the tunables to 0, so you can 
then verify that it fixes the problem... all before injecting the new map 
into the cluster and actually triggering any data migration.

sage


> 
> On Thu, Aug 23, 2012 at 3:52 PM, S?awomir Skowron <szibis@gmail.com> wrote:
> > 3 osd after crash rebuilds ok, but rebuild of two more osd (12 and
> > 30), i can't make cluster to be active+clean
> >
> > I do rebuild like in doc:
> >
> > stop osd,
> > remove from crush,
> > rm from map,
> > recreate a osd, after cluster get stable
> >
> > But now, all osd are in, and up, and data won't remap, and some of PG,
> > have only two osd in chain with replication level 3 for this pool.
> >
> > 2012-08-23 15:26:46.073685 mon.0 [INF] pgmap v117192: 6472 pgs: 63
> > active, 4457 active+clean, 1942 active+remapped, 10 active+degraded;
> > 596 GB data, 1650 GB used, 20059 GB / 21710 GB avail; 57815/4705888
> > degraded (1.229%)
> >
> > In attachment output from:
> >
> > ceph osd dump -o -
> >
> > I can't find any info in doc for this situation.
> >
> > HEALTH_WARN 10 pgs degraded; 2015 pgs stuck unclean; recovery
> > 57871/4706179 degraded (1.230%)
> > root@s3-10-177-64-6:~# ceph -s
> >    health HEALTH_WARN 10 pgs degraded; 2015 pgs stuck unclean;
> > recovery 57871/4706179 degraded (1.230%)
> >    monmap e4: 3 mons at
> > {0=10.177.64.4:6789/0,1=10.177.64.6:6789/0,2=10.177.64.8:6789/0},
> > election epoch 16, quorum 0,1,2 0,1,2
> >    osdmap e1300: 78 osds: 78 up, 78 in
> >     pgmap v117464: 6472 pgs: 63 active, 4457 active+clean, 1942
> > active+remapped, 10 active+degraded; 596 GB data, 1651 GB used, 20059
> > GB / 21710 GB avail; 57871/4706179 degraded (1.230%)
> >    mdsmap e1: 0/0/1 up
> >
> > Please help, i will try to give you any output you need.
> >
> >
> > And one more thing, little bug in 0.48.1:
> >
> > ceph health blabla command, does same thing, as ceph health details.
> > Whatever is after health, means details.
> >
> > --
> > -----
> > Regards
> >
> > S?awek "sZiBis" Skowron
> 
> 
> 
> -- 
> -----
> Pozdrawiam
> 
> S?awek "sZiBis" Skowron
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
