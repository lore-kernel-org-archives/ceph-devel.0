From: caifeng.zhu@uniswdc.com
Subject: incorrect object stat sum in PG info after pg split
Date: Tue, 10 Jan 2017 18:03:19 +0800
Message-ID: <20170110100319.GA20556@T530I>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpbgsg2.qq.com ([54.254.200.128]:38507 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934378AbdAJKHK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 10 Jan 2017 05:07:10 -0500
Received: from T530I (unknown [58.213.102.114])
        by esmtp4.qq.com (ESMTP) with SMTP id 0
        for <ceph-devel@vger.kernel.org>; Tue, 10 Jan 2017 18:06:14 +0800 (CST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi, all

We find that after the number of pgs increased, the object stat sum
in pg info is incorrect. 

The following steps can reproduce the problem.
0 assume the object store is a filestore.
1 create a pool 'foo' with the number of pgs such as 64.
2 write data through clients(rbd, cephfs or rgw) into the pool 'foo'.
3 increase the number of pgs in the pool 'foo' to such as 128.
4 after pgs are settled, use 'ceph pg x.y query' to look at the field
  'num_objects'
5 find the osd shard where pg x.y resides by 'ceph pg map x.y' and
  count the number of objects in the osd shard by command like 
  'find /var/lib/ceph/osd/ceph-0/current/x.y_head/ -type f | wc -l'

The code flow to increase the pg number is as follows:
OSD::advance_pg
	-> OSD::split_pgs
		-> object_stat_sum::split
	-> ReplicatedPG::split_colls
		-> PG::_create
		-> ObjectStore::Transaction::split_collection
			/* indirectly call FileStore::_split_collection 
			 * when applying transaction into file system.
			 */
	-> PG::split_into

Compare object_stat_sum::split with FileStore::_split_collection, the splitting
logic is different and makes stat.sum different from the actual number of objects
in the collection. 

The question is that should we fix this difference? If so, how to fix? 
In current design, it seems very difficult to fix the problem.

A similar bug is reported as tracker.ceph.com/issues/16671, which will occur
if all the exitent data in pool 'foo' is deleted. 

Best Regards



