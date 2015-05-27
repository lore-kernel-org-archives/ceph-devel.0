From: Li Wang <liwang@ubuntukylin.com>
Subject: Some thoughts regarding the new store
Date: Wed, 27 May 2015 16:41:04 +0800
Message-ID: <55658320.3060907@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:47497 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbbE0IlW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 May 2015 04:41:22 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Samuel Just <sjust@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

I have just noticed the new store development, and had a
look at the idea behind it (http://www.spinics.net/lists/ceph-
devel/msg22712.html), so my understanding, we wanna avoid the
double-write penalty of WRITE_AHEAD_LOGGING journal mechanism,
the straightforward thought is to optimize CREATE, APPEND and
FULL-OBJECT-OVERWRITE by writing into new files directly,
then update the metadata in a transaction. Other changes include:
move the object metadata from filesystem extend attrbutes into
key value database; map an object into possibly multiple files.

If my understanding is correct, then it seems there follows some issues,

1 Garbage collection is needed to reclaim orphan files generated
from crashing;

2 On spinning disks, it loses the advantages that journal makes random
  writes into sequential writes, then commits them in groups and
leverages another disk to hide the committing delay.

3 OVERWRITE theoretically does not benefit from this design, and the
introducing of fragment, increases the object metadata overhead. The 
possibly mapping of multiple files may also slow down the object
read/write performance. OVERWRITE is the major scenario for RBD,
consequently, for cloud environment.

4 By mapping an object into multiple files, potentially we can optimize
OVERWRITE by turning it also into APPEND by using small fragments,
that, actually mimic Btrfs. However, for many small writes, it may
leave many small files in the backend local file system, that may slow
down the object read/write performance, especially on spinning
disk. More importantly, I think it, to some extent, against the
philosophy of object storage, which uses a big object to store data to
reduce the metadata cost, and leaves the block management for local
file system. For a local file system, big file performance is generally
better than small file. If we introduce fragment, it looks like the
object storage self cares about the object data allocation now.

What is the community's option?

Cheers,
Li Wang
