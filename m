From: Mark Nelson <mnelson@redhat.com>
Subject: Re: 05/06/2015 Weekly Ceph Performance Meeting IS ON!
Date: Thu, 07 May 2015 09:39:41 -0500
Message-ID: <554B792D.1010509@redhat.com>
References: <554A0CE8.1030804@redhat.com> <06E7D85B3BA36C4DB207FEDE871C53489DB42F@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55274 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750793AbbEGOjn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 7 May 2015 10:39:43 -0400
In-Reply-To: <06E7D85B3BA36C4DB207FEDE871C53489DB42F@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Zhiqiang,

Yes, you can do zipf distributions (and also pareto):

https://plus.google.com/+JensAxboe/posts/RN4ZSQZs3vS
http://www.hpl.hp.com/research/idl/papers/ranking/ranking.html

There is also work going on (may have been merged, I haven't checked) to 
support non-uniform random distributions with drift:

http://www.spinics.net/lists/fio/msg03776.html

If you use cbt at all for this, I've tooled support for non-uniform 
distributions into the librbd fio module.  Here's an example using an 
erasure coded base pool with a 3x replication cache pool and running 
zipf distribution tests against it:

cluster:
   user: nhm
   head: "burnupiX"
   clients: ["burnupiY"]
   osds: ["burnupiX"]
   mons:
     burnupiY:
       a: "192.168.10.2:6789"
   osds_per_node: 30
   fs: 'xfs'
   mkfs_opts: '-f -i size=2048 -n size=64k -K'
   mount_opts: '-o inode64,noatime,logbsize=256k'
   conf_file: '/home/nhm/src/ceph-tools/cbt/rbdtiering2/ceph.conf'
   iterations: 1
   clusterid: "ceph"
   tmp_dir: "/tmp/cbt"
   use_existing: False

   crush_profiles:
     cache:
       osds: [24,25,26,27,28,29]
   erasure_profiles:
     ec62:
       erasure_k: 6
       erasure_m: 2
   pool_profiles:
     basepool:
       pg_size: 2048
       pgp_size: 2048
       cache:
         pool_profile: 'cache_pool'
         mode: 'writeback'
       replication: 'erasure'
       erasure_profile: 'ec62'
     cache_pool:
       crush_profile: 'cache'
       pg_size: 1024
       pgp_size: 1024
       replication: 3
       hit_set_type: 'bloom'
       hit_set_count: 8
       hit_set_period: 60
       target_max_objects: 32768
       target_max_bytes: 137438953472

benchmarks:
   librbdfio:
     time: 600
     vol_size: 262144
     mode: [read, write, randread, randwrite, rw, randrw]
     rwmixread: 50
     op_size: [4194304, 131072, 4096]
     concurrent_procs: [1]
     iodepth: [128]
     osd_ra: [4096]
     cmd_path: '/home/nhm/src/fio/fio'
     pool_profile: 'basepool'
     random_distribution: 'zipf:1.2'
     log_avg_msec: 100


On 05/07/2015 01:39 AM, Wang, Zhiqiang wrote:
> Hi Mark,
>
> In the meeting you mentioned fio has some new features which can generate workload other than pure random. Can you share the config for that? I may want to use this to test the performance of proxy write. Thanks!
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
> Sent: Wednesday, May 6, 2015 8:45 PM
> To: ceph-devel@vger.kernel.org
> Subject: 05/06/2015 Weekly Ceph Performance Meeting IS ON!
>
> 8AM PST as usual! Discussion topics include:  Newstore updates.  Please feel free to add your own!
>
> Here's the links:
>
> Etherpad URL:
> http://pad.ceph.com/p/performance_weekly
>
> To join the Meeting:
> https://bluejeans.com/268261044
>
> To join via Browser:
> https://bluejeans.com/268261044/browser
>
> To join with Lync:
> https://bluejeans.com/268261044/lync
>
>
> To join via Room System:
> Video Conferencing System: bjn.vc -or- 199.48.152.152 Meeting ID: 268261044
>
> To join via Phone:
> 1) Dial:
>             +1 408 740 7256
>             +1 888 240 2560(US Toll Free)
>             +1 408 317 9253(Alternate Number)
>             (see all numbers - http://bluejeans.com/numbers)
> 2) Enter Conference ID: 268261044
>
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
