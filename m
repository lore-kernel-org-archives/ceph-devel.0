From: Sage Weil <sweil@redhat.com>
Subject: Re: [PATCH] Osd: write back throttling for cache tiering
Date: Thu, 28 May 2015 09:43:37 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505280936550.6462@cobra.newdream.net>
References: <cover.1432819956.git.liwang@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42945 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754029AbbE1Qnm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 28 May 2015 12:43:42 -0400
In-Reply-To: <cover.1432819956.git.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: ceph-devel@vger.kernel.org, Nick Fisk <nick@fisk.me.uk>, MingXin Liu <mingxinliu@ubuntukylin.com>

Hi Li,

Reviewing this now!  See comments on the PR.

Just FYI, the current convention is to send kernel patches to the list, 
and to use github for the userland stuff.  Emails like this are helpful to 
get people's attention but not strictly needed--we'll notice the PR either 
way!

Thanks-
sage

On Thu, 28 May 2015, Li Wang wrote:

> This patch is to do write back throttling for cache tiering,
> which is similar to what the Linux kernel does for 
> page cache write back. The motivation and original idea are 
> proposed by Nick Fisk, detailed in his email as below. In our
> implementation, we introduce a paramter 'cache_target_dirty_high_ratio' 
> (default 0.6) as the high speed threshold, while leave the
> 'cache_target_dirty_ratio' (default 0.4) to represent the low speed 
> threshold, we control the flush speed by limiting the parallelism of 
> flushing. The maximum parallelism under low speed is half of the 
> parallelism under high speed. If there is at least one PG such that 
> the dirty ratio beyond the high threshold, full speed mode is entered; 
> If there is no PG such that dirty ratio beyond the low threshold, 
> idle mode is entered; In other cases, slow speed mode is entered.
> 
> -------- Original Message --------
> Subject: 	Ceph Tiering Idea
> Date: 	Fri, 22 May 2015 16:07:46 +0100
> From: 	Nick Fisk <nick@fisk.me.uk>
> To: 	liwang@ubuntukylin.com
> 
> Hi,
> 
> I??ve just seen your post to the Ceph Dev Mailing list regarding 
> adding temperature based eviction to the cache eviction logic. 
> I think this is a much needed enhancement and can??t wait to test 
> it out once it hits the next release.
> 
> I have been testing Ceph Cache Tiering for a number of months now 
> and another enhancement which I think would greatly enhance the 
> performance would be high and low thresholds for flushing and 
> eviction. I have tried looking through the Ceph source, but with 
> my limited programming skills I was unable to make any progress 
> and so thought I would share my idea with you and get your thoughts.
> 
> Currently as soon as you exceed the flush/eviction threshold, Ceph 
> starts aggressively flushing to the base tier which impacts performance. 
> For long running write operations this is probably unavoidable, however 
> most workloads are normally quite bursty and my idea of having high and 
> low thresholds would hopefully improve performance where the writes 
> come in bursts.
> 
> When the cache tier approaches the low threshold, Ceph would start 
> flushing/evicting with a low priority, so performance is not affected. 
> If the high threshold is reached, Ceph will flush more aggressively, 
> similar to the current behaviour. Hopefully during the quiet periods 
> in-between bursts of writes, the cache would slowly be reduced down to 
> the low threshold meaning it is ready for the next burst.
> 
> For example:-
> 
> 1TB Cache Tier
> 
> Low Dirty=0.4
> 
> High Dirty=0.6
> 
> Cache tier would contain 400GB of dirty data at idle, as dirty data 
> rises above 400GB, Ceph would flush with a low priority or throttled 
> MB/s rate.
> 
> If Cache tier raises above 600GB, Ceph will aggressively flush to keep 
> dirty data below 60%
> 
> The above should give you 200GB capacity of bursty writes before 
> performance becomes impacted
> 
> Does this make sense?
> 
> Many Thanks,
> 
> Nick
> 
> The patches:
> https://github.com/ceph/ceph/pull/4792
> 
> Mingxin Liu (6):
>   Osd: classify flush mode into low speed and high speed modes
>   osd: add new field in pg_pool_t
>   Mon: add cache_target_dirty_high_ratio related configuration and
>     commands
>   Osd: revise agent_choose_mode() to track the flush mode
>   Osd: implement low speed flush
>   Doc: add write back throttling stuff in document and test scripts
> 
>  ceph-erasure-code-corpus               |  2 +-
>  doc/dev/cache-pool.rst                 |  1 +
>  doc/man/8/ceph.rst                     |  3 ++-
>  doc/rados/operations/cache-tiering.rst | 11 +++++++++++
>  doc/rados/operations/pools.rst         | 19 +++++++++++++++++++
>  qa/workunits/cephtool/test.sh          |  9 +++++++++
>  src/common/config_opts.h               |  2 ++
>  src/mon/MonCommands.h                  |  4 ++--
>  src/mon/OSDMonitor.cc                  | 31 ++++++++++++++++++++++++++++---
>  src/osd/OSD.cc                         |  7 ++++++-
>  src/osd/OSD.h                          | 11 +++++++++++
>  src/osd/PG.h                           |  1 +
>  src/osd/ReplicatedPG.cc                | 22 +++++++++++++++++-----
>  src/osd/ReplicatedPG.h                 |  6 +++++-
>  src/osd/TierAgentState.h               |  6 ++++--
>  src/osd/osd_types.cc                   | 13 +++++++++++--
>  src/osd/osd_types.h                    |  3 +++
>  17 files changed, 133 insertions(+), 18 deletions(-)
> 
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
