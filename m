From: Sage Weil <sage@newdream.net>
Subject: Re: incorrect object stat sum in PG info after pg split
Date: Tue, 10 Jan 2017 12:44:50 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1701101240520.5745@piezo.novalocal>
References: <20170110100319.GA20556@T530I>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37305 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967155AbdAJMox (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jan 2017 07:44:53 -0500
In-Reply-To: <20170110100319.GA20556@T530I>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: caifeng.zhu@uniswdc.com
Cc: ceph-devel@vger.kernel.org

On Tue, 10 Jan 2017, caifeng.zhu@uniswdc.com wrote:
> Hi, all
> 
> We find that after the number of pgs increased, the object stat sum
> in pg info is incorrect. 
> 
> The following steps can reproduce the problem.
> 0 assume the object store is a filestore.
> 1 create a pool 'foo' with the number of pgs such as 64.
> 2 write data through clients(rbd, cephfs or rgw) into the pool 'foo'.
> 3 increase the number of pgs in the pool 'foo' to such as 128.
> 4 after pgs are settled, use 'ceph pg x.y query' to look at the field
>   'num_objects'
> 5 find the osd shard where pg x.y resides by 'ceph pg map x.y' and
>   count the number of objects in the osd shard by command like 
>   'find /var/lib/ceph/osd/ceph-0/current/x.y_head/ -type f | wc -l'
> 
> The code flow to increase the pg number is as follows:
> OSD::advance_pg
> 	-> OSD::split_pgs
> 		-> object_stat_sum::split
> 	-> ReplicatedPG::split_colls
> 		-> PG::_create
> 		-> ObjectStore::Transaction::split_collection
> 			/* indirectly call FileStore::_split_collection 
> 			 * when applying transaction into file system.
> 			 */
> 	-> PG::split_into
> 
> Compare object_stat_sum::split with FileStore::_split_collection, the splitting
> logic is different and makes stat.sum different from the actual number of objects
> in the collection. 
> 
> The question is that should we fix this difference? If so, how to fix? 
> In current design, it seems very difficult to fix the problem.

Right, it's expected to be out of sync.  The pg_stats structure has a bool 
flag indicating the stats are not strictly accurate (only an 
approximation), and will be corrected during the next scrub.  You can 
force this to happen explicitly on a test pg with 'ceph pg scrub <pgid>' 
and then verif that afterwards the stats are accurate.  You can also see 
the full stats strcuture (including the flag) with 'ceph pg dump -f 
json-pretty'.

It would be very hard to make the ObjectStore backend (FileStore or 
BlueStore) be able to split a collection in O(1) time *and* provide an 
accurate split of the stats (and its many fields) as well.  And not that 
important; the approximation is sufficient for most purposes.  The only 
one it's not good enough for is the cache tiering agent; that is disabled 
until the next scrub happens on the PG.

sage

> 
> A similar bug is reported as tracker.ceph.com/issues/16671, which will occur
> if all the exitent data in pool 'foo' is deleted. 
> 
> Best Regards
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
