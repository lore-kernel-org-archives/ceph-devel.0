From: Mark Nelson <mnelson@redhat.com>
Subject: bluestore read regression testing
Date: Wed, 13 Jul 2016 23:12:46 -0500
Message-ID: <255e42d7-5892-30ac-29aa-60a31d8f254e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39759 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751094AbcGNEMt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 14 Jul 2016 00:12:49 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E9F3874A24
	for <ceph-devel@vger.kernel.org>; Thu, 14 Jul 2016 04:12:48 +0000 (UTC)
Received: from [10.3.112.18] (ovpn-112-18.phx2.redhat.com [10.3.112.18])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u6E4ClSK005997
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Thu, 14 Jul 2016 00:12:48 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

This is mostly for Igor though I thought I'd post to ceph-devel if 
anyone else trying to track down the bluestore read regression.

Here's what I'm seeing so far after doing some bisecting tonight.  Sadly 
it's slow going since we've got a lot of skip steps due to broken 
builds/etc.  I'm testing my own wip branch with master from last week 
plus Igor's write path segfault fix here:

https://github.com/markhpc/ceph/tree/wip-bluestore-blobmap-lock

With the latest commit in that branch I'm seeing about 10MB/s for 4K 
random reads vs 141MB/s for the same test on commit 55cb608.  This test 
is setup with lots of concurrency:  8 fio processes each targeting a 
64GB RBD image with an iodepth of 32.  The test cluster has 4 nodes with 
4 P3700 cards split up into 16 OSDs.

The bisect hasn't made much progress.  This is all I've gotten so far:

[nhm@espresso ceph]$ git bisect log
git bisect start
# bad: [c7da2f7c869694246650a9276a2b67aed9bf818f] [DNM] Igor's blob_map 
lock test.
git bisect bad c7da2f7c869694246650a9276a2b67aed9bf818f
# good: [55cb608f63787f7969514ad0d7222da68ab84d88] Merge pull request 
#9563 from markhpc/wip-rocksdb-jemalloc
git bisect good 55cb608f63787f7969514ad0d7222da68ab84d88
# good: [55cb608f63787f7969514ad0d7222da68ab84d88] Merge pull request 
#9563 from markhpc/wip-rocksdb-jemalloc
git bisect good 55cb608f63787f7969514ad0d7222da68ab84d88
# skip: [4e911c8c8b3791582c16b4fdfeda7269f751428a] Merge pull request 
#9821 from dx9/wip-ac-alpine
git bisect skip 4e911c8c8b3791582c16b4fdfeda7269f751428a
# skip: [ef272731215ccf0a4178ae01f2903077488ef895] mds: improve comments 
for ENOTEMPTY checks
git bisect skip ef272731215ccf0a4178ae01f2903077488ef895
# good: [abd84f4f1b804aa6a90ed5f8b94c1cfddc4e8956] os/filestore: fix statfs
git bisect good abd84f4f1b804aa6a90ed5f8b94c1cfddc4e8956
# skip: [c83374ff717a106cd5638b3df38536b8cd579d87] Merge pull request 
#9626 from liewegas/wip-bluestore-2q
git bisect skip c83374ff717a106cd5638b3df38536b8cd579d87
# skip: [9dc3eb61175e07f2aca858b431e60bb38719104d] Merge pull request 
#9890 from xiexingguo/xxg-wip-fix-bfs-alloc
git bisect skip 9dc3eb61175e07f2aca858b431e60bb38719104d
# skip: [de6b2584b0478ec7b11f0e9bb31d29a0a6a71cad] os/bluestore: switch 
to intrusive_set for blobs
git bisect skip de6b2584b0478ec7b11f0e9bb31d29a0a6a71cad

that yields a whole lot of commits that still need to be looked through 
given the number of skips I'm hitting.

[nhm@espresso ceph]$ git log --pretty=oneline abd84f4f1..c7da2f7c8 | wc
    1165    8728  110448

Anyway, I'll have more tomorrow, but that's all I've got tonight.  Happy 
hunting!

Mark


