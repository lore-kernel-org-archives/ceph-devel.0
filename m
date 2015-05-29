From: Li Wang <liwang@ubuntukylin.com>
Subject: [RFC] Implement a new journal mode
Date: Fri, 29 May 2015 17:23:29 +0800
Message-ID: <55683011.7000307@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:59264 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755793AbbE2JYB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 May 2015 05:24:01 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Samuel Just <sjust@redhat.com>, Josh Durgin <jdurgin@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

An important usage of Ceph is to integrate with cloud computing platform
to provide the storage for VM images and instances. In such scenario,
qemu maps RBD as virtual block devices, i.e., disks to a VM, and
the guest operating system will format the disks and create file
systems on them. In this case, RBD mostly resembles a 'dumb' disk.  In
other words, it is enough for RBD to implement exactly the semantics of
a disk controller driver. Typically, the disk controller itself does
not provide a transactional mechanism to ensure a write operation done
atomically. Instead, it is up to the file system, who manages the disk,
to adopt some techniques such as journaling to prevent inconsistency,
if necessary. Consequently, RBD does not need to provide the
atomic mechanism to ensure a data write operation done atomically,
since the guest file system will guarantee that its write operations to
RBD will remain consistent by using journaling if needed. Another
scenario is for the cache tiering, while cache pool has already
provided the durability, when dirty objects are written back, they
theoretically need not go through the journaling process of base pool,
since the flusher could replay the write operation. These motivate us
to implement a new journal mode, metadata-only journal mode, which
resembles the data=ordered journal mode in ext4. With such journal mode
is on, object data are written directly to their ultimate location,
when data written finished, metadata are written into the journal, then
the write returns to caller. This will avoid the double-write penalty
of object data due to the WRITE-AHEAD-LOGGING, potentially greatly
improve the RBD and cache tiering performance.

The algorithm is straightforward, as before, the master send
transaction to slave, then they extract the object data write
operations and apply them to objects directly, next they write the
remaining part of the transaction into journal, then slave ack master,
master ack client. For some special operations such as 'clone', they
can be processed as before by throwing the entire transaction into
journal, which makes this approach an absolutely-better optimization
in terms of performance.

In terms of consistency, metadata consistency is ensured, and
the data consistency of CREATE and APPEND are also ensured, just for
OVERWRITE, it relies on the caller, i.e., guest file system for RBD,
cache flusher for cache tiering to ensure the consistency. In addition,
there remains a problem to be discussed that how to interact with the
scrub process while the object data consistency may not ensured now.

We are actively working on it and have done part of the implementation,
want to hear the feedback of the community, and we may submit it as a
blueprint to under discussion in coming CDS.

Cheers,
Li Wang
