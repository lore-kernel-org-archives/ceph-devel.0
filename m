From: Igor Fedotov <ifedotov@mirantis.com>
Subject: [PATCH 1/1] osd: take removed/empty/small objects into account for
 cache flush triggering
Date: Wed, 18 Nov 2015 20:22:17 +0300
Message-ID: <564CB3C9.3030101@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34719 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756438AbbKRRWW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Nov 2015 12:22:22 -0500
Received: by lbbcs9 with SMTP id cs9so28600229lbb.1
        for <ceph-devel@vger.kernel.org>; Wed, 18 Nov 2015 09:22:20 -0800 (PST)
Received: from [127.0.0.1] ([91.218.144.129])
        by smtp.googlemail.com with ESMTPSA id e9sm567689lbs.13.2015.11.18.09.22.19
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2015 09:22:19 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>ceph-devel <ceph-devel@vger.kernel.org>

Hi Everybody,

It seems that Ceph caching doesn't take removed ( whitened out) objects
into accounts when checks for the need to flush the cache.

Following pools have been created:
./ceph -c ceph.conf osd pool create cachepool 12 12
./ceph -c ceph.conf osd pool create ecpool 12 12 erasure
./ceph -c ceph.conf osd tier add ecpool cachepool
./ceph -c ceph.conf osd tier cache-mode cachepool writeback

./ceph -c ceph.conf osd tier set-overlay ecpool cachepool
./ceph -c ceph.conf osd pool set cachepool hit_set_type bloom
./ceph -c ceph.conf osd pool set cachepool target_max_bytes 1000000

Then doing the following in a loop:
   Write 16K data to a new object with unique name
   Remove object.

causes cache pool object count to grow permanently:
~/ceph/ceph_com/src# ./rados -c ceph.conf df
pool name                 KB      objects       clones degraded
unfound           rd        rd KB           wr wr KB
cachepool                 48          285            0 0
0            0            0          567         4560
...
~/ceph/ceph_com/src# ./rados -c ceph.conf df
pool name                 KB      objects       clones degraded
unfound           rd        rd KB           wr wr KB
cachepool                  0         5947            0 0
0            0            0        11894        95152
...
etc
The same applies to disk usage reported by du command:
~/ceph/ceph_com/src# du -h dev -s
461M    dev
...
~/ceph/ceph_com/src# du -h dev -s
465M    dev


 From code analysis it looks like following two parameters affect cache
flush triggering: target_max_bytes and target_max_objects.
When the latter set to 0 (by default) cache flush wouldn't happen no
matter how many removed objects are in the cache since their size is
supposed to be 0 bytes. But in fact that's not true - empty
files(objects) consume some space too.  Thus potentially one can even
completely overfill the cache with removed objects.
I understand that the above case is rather a corner one. And in real
life additional user traffic may trigger cache flush. But probably it's
worth to handle such case given the fact that it's pretty easy.
In the patch below for the sake of simplicity I assumed that minimum
object size is always 4K. Despite the fact that it probably depends on
the underlying filesystem I think that's good enough to use this
constant.  And of cause that's just a simple correction in used space
calculation to trigger cache flush - it doesn't ensure 100% correct
calculation.

Signed-off-by: Igor Fedotov <ifedotov@mirantis.com>
---

diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
index 67a0657..d019135 100644
--- a/src/osd/ReplicatedPG.cc
+++ b/src/osd/ReplicatedPG.cc
@@ -11886,6 +11886,7 @@ bool ReplicatedPG::agent_choose_mode(bool
restart, OpRequestRef op)
    uint64_t full_micro = 0;
    if (pool.info.target_max_bytes && num_user_objects > 0) {
      uint64_t avg_size = num_user_bytes / num_user_objects;
+    avg_size=MAX(avg_size, 4096); //take into account that tons of
empty objects consume some disk space too.
      dirty_micro =
        num_dirty * avg_size * 1000000 /
        MAX(pool.info.target_max_bytes / divisor, 1);


Thanks,
Igor


