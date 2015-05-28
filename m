From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH] Osd: write back throttling for cache tiering
Date: Thu, 28 May 2015 21:38:01 +0800
Message-ID: <cover.1432819956.git.liwang@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:49175 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbbE1Nji (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 09:39:38 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org, Nick Fisk <nick@fisk.me.uk>, MingXin Liu <mingxinliu@ubuntukylin.com>, Li Wang <liwang@ubuntukylin.com>

This patch is to do write back throttling for cache tiering,
which is similar to what the Linux kernel does for=20
page cache write back. The motivation and original idea are=20
proposed by Nick Fisk, detailed in his email as below. In our
implementation, we introduce a paramter 'cache_target_dirty_high_ratio'=
=20
(default 0.6) as the high speed threshold, while leave the
'cache_target_dirty_ratio' (default 0.4) to represent the low speed=20
threshold, we control the flush speed by limiting the parallelism of=20
flushing. The maximum parallelism under low speed is half of the=20
parallelism under high speed. If there is at least one PG such that=20
the dirty ratio beyond the high threshold, full speed mode is entered;=20
If there is no PG such that dirty ratio beyond the low threshold,=20
idle mode is entered; In other cases, slow speed mode is entered.

-------- Original Message --------
Subject: 	Ceph Tiering Idea
Date: 	Fri, 22 May 2015 16:07:46 +0100
=46rom: 	Nick Fisk <nick@fisk.me.uk>
To: 	liwang@ubuntukylin.com

Hi,

I=A1=AFve just seen your post to the Ceph Dev Mailing list regarding=20
adding temperature based eviction to the cache eviction logic.=20
I think this is a much needed enhancement and can=A1=AFt wait to test=20
it out once it hits the next release.

I have been testing Ceph Cache Tiering for a number of months now=20
and another enhancement which I think would greatly enhance the=20
performance would be high and low thresholds for flushing and=20
eviction. I have tried looking through the Ceph source, but with=20
my limited programming skills I was unable to make any progress=20
and so thought I would share my idea with you and get your thoughts.

Currently as soon as you exceed the flush/eviction threshold, Ceph=20
starts aggressively flushing to the base tier which impacts performance=
=2E=20
=46or long running write operations this is probably unavoidable, howev=
er=20
most workloads are normally quite bursty and my idea of having high and=
=20
low thresholds would hopefully improve performance where the writes=20
come in bursts.

When the cache tier approaches the low threshold, Ceph would start=20
flushing/evicting with a low priority, so performance is not affected.=20
If the high threshold is reached, Ceph will flush more aggressively,=20
similar to the current behaviour. Hopefully during the quiet periods=20
in-between bursts of writes, the cache would slowly be reduced down to=20
the low threshold meaning it is ready for the next burst.

=46or example:-

1TB Cache Tier

Low Dirty=3D0.4

High Dirty=3D0.6

Cache tier would contain 400GB of dirty data at idle, as dirty data=20
rises above 400GB, Ceph would flush with a low priority or throttled=20
MB/s rate.

If Cache tier raises above 600GB, Ceph will aggressively flush to keep=20
dirty data below 60%

The above should give you 200GB capacity of bursty writes before=20
performance becomes impacted

Does this make sense?

Many Thanks,

Nick

The patches:
https://github.com/ceph/ceph/pull/4792

Mingxin Liu (6):
  Osd: classify flush mode into low speed and high speed modes
  osd: add new field in pg_pool_t
  Mon: add cache_target_dirty_high_ratio related configuration and
    commands
  Osd: revise agent_choose_mode() to track the flush mode
  Osd: implement low speed flush
  Doc: add write back throttling stuff in document and test scripts

 ceph-erasure-code-corpus               |  2 +-
 doc/dev/cache-pool.rst                 |  1 +
 doc/man/8/ceph.rst                     |  3 ++-
 doc/rados/operations/cache-tiering.rst | 11 +++++++++++
 doc/rados/operations/pools.rst         | 19 +++++++++++++++++++
 qa/workunits/cephtool/test.sh          |  9 +++++++++
 src/common/config_opts.h               |  2 ++
 src/mon/MonCommands.h                  |  4 ++--
 src/mon/OSDMonitor.cc                  | 31 ++++++++++++++++++++++++++=
++---
 src/osd/OSD.cc                         |  7 ++++++-
 src/osd/OSD.h                          | 11 +++++++++++
 src/osd/PG.h                           |  1 +
 src/osd/ReplicatedPG.cc                | 22 +++++++++++++++++-----
 src/osd/ReplicatedPG.h                 |  6 +++++-
 src/osd/TierAgentState.h               |  6 ++++--
 src/osd/osd_types.cc                   | 13 +++++++++++--
 src/osd/osd_types.h                    |  3 +++
 17 files changed, 133 insertions(+), 18 deletions(-)

--=20
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
