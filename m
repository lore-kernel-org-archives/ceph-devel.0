From: Sage Weil <sage@newdream.net>
Subject: Re: osd crash during resync
Date: Wed, 25 Jan 2012 14:08:57 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201251408060.30331@cobra.newdream.net>
References: <4F1EFCFA.3060607@tuxadero.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43123 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab2AYWI5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jan 2012 17:08:57 -0500
In-Reply-To: <4F1EFCFA.3060607@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-devel@vger.kernel.org

Hi Martin,

On Tue, 24 Jan 2012, Martin Mailand wrote:
> Hi,
> today I tried the btrfs patch mentioned on the btrfs ml. Therefore I rebooted
> osd.0 with a new kernel and created a new btrfs on the osd.0, than I took the
> osd.0 into the cluster. During the the resync of osd.0 osd.2 and osd.3
> crashed.
> I am not sure, if the crashes happened because I played with osd.0, or if they
> are bugs.
> 
> 
> osd.2
> -rw-------  1 root root 1.1G 2012-01-24 12:19
> core-ceph-osd-1000-1327403927-s-brick-002
> 
> log:
> 2012-01-24 12:15:45.563135 7f1fdd42c700 log [INF] : 2.a restarting backfill on
> osd.0 from (185'113859,185'113859] 0//0 to 196'114038
> osd/PG.cc: In function 'void PG::finish_recovery_op(const hobject_t&, bool)',
> in thread '7f1fdab26700'
> osd/PG.cc: 1553: FAILED assert(recovery_ops_active > 0)
> 
> -rw-------  1 root root 758M 2012-01-24 15:58
> core-ceph-osd-20755-1327417128-s-brick-002

Can you post the log for osd.0 too?

Thanks!
sage



> 
> log:
> 2012-01-24 15:58:48.356892 7fe26acbf700 osd.2 379 pg[2.ff( v 379'286211 lc
> 202'286160 (185'285159,379'286211] n=112 ec=1 les/c 379/310 373/376/376) [2,1]
> r=0 lpr=376 rops=1 mlcod 202'286160 active m=6]  * oi->watcher: client.4478
> cookie=1
> osd/ReplicatedPG.cc: In function 'void
> ReplicatedPG::populate_obc_watchers(ReplicatedPG::ObjectContext*)', in thread
> '7fe26fdca700'
> osd/ReplicatedPG.cc: 3199: FAILED assert(obc->watchers.size() == 0)
> osd/ReplicatedPG.cc: In function 'void
> ReplicatedPG::populate_obc_watchers(ReplicatedPG::ObjectContext*)', in thread
> '7fe26fdca700'
> 
> http://85.214.49.87/ceph/20120124/osd.2.log.bz2
> 
> 
> 
> osd.3
> -rw-------  1 root root 986M 2012-01-24 12:24
> core-ceph-osd-962-1327404263-s-brick-003
> 
> log:
> 2012-01-24 12:15:50.241321 7f30c8fde700 log [INF] : 2.2e restarting backfill
> on osd.0 from (185'338312,185'338312] 0//0 to 196'339910
> 2012-01-24 12:21:48.420242 7f30c5ed7700 log [INF] : 2.9d scrub ok
> osd/PG.cc: In function 'void PG::activate(ObjectStore::Transaction&,
> std::list<Context*>&, std::map<int, std::map<pg_t, PG::Query> >&,
> std::map<int, MOSDPGInfo*>*)', in thread '7f30c8fde700'
> 
> http://85.214.49.87/ceph/20120124/osd.3.log.bz2
> 
> 
> 
> -martin
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
