From: Sage Weil <sage@newdream.net>
Subject: RE: [ceph-users] Write performance issue under rocksdb kvstore
Date: Tue, 20 Oct 2015 06:25:43 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510200623350.16833@cobra.newdream.net>
References: <SNT146-W53DA6FBD57581F19D681688C390@phx.gbl>, <alpine.DEB.2.00.1510200544430.16833@cobra.newdream.net> <SNT146-W662172E7246E7DABE7F6BA8C390@phx.gbl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54243 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbbJTNZo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Oct 2015 09:25:44 -0400
In-Reply-To: <SNT146-W662172E7246E7DABE7F6BA8C390@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Z Zhang <zhangz.david@outlook.com>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 20 Oct 2015, Z Zhang wrote:
> Thanks, Sage, for pointing out the PR and ceph branch. I will take a 
> closer look.
> 
> Yes, I am trying KVStore backend. The reason we are trying it is that 
> few user doesn't have such high requirement on data loss occasionally. 
> It seems KVStore backend without synchronized WAL could achieve better 
> performance than filestore. And only data still in page cache would get 
> lost on machine crashing, not process crashing, if we use WAL but no 
> synchronization. What do you think?

That sounds dangerous.  The OSDs are recording internal metadata about the 
cluster (peering, replication, etc.)... even if you don't care so much 
about recent user data writes you probably don't want to risk breaking 
RADOS itself.  If the kv backend is giving you a stale point-in-time 
consistent copy it's not so bad, but in a power-loss event it could give 
you problems...

sage

> 
>     Thanks. Zhi Zhang (David)
> 
> Date: Tue, 20 Oct 2015 05:47:44 -0700
> From: sage@newdream.net
> To: zhangz.david@outlook.com
> CC: ceph-users@lists.ceph.com; ceph-devel@vger.kernel.org
> Subject: Re: [ceph-users] Write performance issue under rocksdb kvstore
> 
> On Tue, 20 Oct 2015, Z Zhang wrote:
> > Hi Guys,
> > 
> > I am trying latest ceph-9.1.0 with rocksdb 4.1 and ceph-9.0.3 with 
> > rocksdb 3.11 as OSD backend. I use rbd to test performance and following 
> > is my cluster info.
> > 
> > [ceph@xxx ~]$ ceph -s
> >     cluster b74f3944-d77f-4401-a531-fa5282995808
> >      health HEALTH_OK
> >      monmap e1: 1 mons at {xxx=xxx.xxx.xxx.xxx:6789/0}
> >             election epoch 1, quorum 0 xxx
> >      osdmap e338: 44 osds: 44 up, 44 in
> >             flags sortbitwise
> >       pgmap v1476: 2048 pgs, 1 pools, 158 MB data, 59 objects
> >             1940 MB used, 81930 GB / 81932 GB avail
> >                 2048 active+clean
> > 
> > All the disks are spinning ones with write cache turning on. Rocksdb's 
> > WAL and sst files are on the same disk as every OSD.
>  
> Are you using the KeyValueStore backend?
>  
> > Using fio to generate following write load: 
> > fio -direct=1 -rw=randwrite -ioengine=sync -size=10M -bs=4K -group_reporting -directory /mnt/rbd_test/ -name xxx.1 -numjobs=1  
> > 
> > Test result:
> > WAL enabled + sync: false + disk write cache: on  will get ~700 IOPS.
> > WAL enabled + sync: true (default) + disk write cache: on|off  will get only ~25 IOPS.
> > 
> > I tuned some other rocksdb options, but with no lock.
>  
> The wip-newstore-frags branch sets some defaults for rocksdb that I think 
> look pretty reasonable (at least given how newstore is using rocksdb).
>  
> > I tracked down the rocksdb code and found each writer's Sync operation 
> > would take ~30ms to finish. And as shown above, it is strange that 
> > performance has no much difference no matters disk write cache is on or 
> > off.
> > 
> > Do your guys encounter the similar issue? Or do I miss something to 
> > cause rocksdb's poor write performance?
>  
> Yes, I saw the same thing.  This PR addresses the problem and is nearing 
> merge upstream:
>  
> 	https://github.com/facebook/rocksdb/pull/746
>  
> There is also an XFS performance bug that is contributing to the problem, 
> but it looks like Dave Chinner just put together a fix for that.
>  
> But... we likely won't be using KeyValueStore in its current form over 
> rocksdb (or any other kv backend).  It stripes object data over key/value 
> pairs, which IMO is not the best approach.
>  
> sage
> 
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com 		 	   		  
