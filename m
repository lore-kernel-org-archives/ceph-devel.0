From: mchristi@redhat.com
Subject: [PATCH 0/5] target/rbd: distributed lun reset support
Date: Tue,  5 May 2015 04:56:13 -0500
Message-ID: <1430819778-24483-1-git-send-email-mchristi@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52786 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757336AbbEEJ4V (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 5 May 2015 05:56:21 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org

The following patches allow drivers like libceph/rbd to distribute
execution of scsi task management functions across multiple nodes
(still working on issues with distributed PRs).

In this patchset, I added a new type of callout/module for these
cluster aware modules. The idea is that something like drbd could maybe do
something optimized for them, or nbd could, or you could use dlm
plus some file system, or do something cluster FS specific. For rbd
we are making rados/libceph calls.

I am mostly looking for feedback on the hooks/callouts approach. I was
not sure if we wanted to maybe instead do somethign like add new callouts
to the request_queue (request_queue->reset_q) or block_device or
add some new block layer REQ_TYPEs (REQ_TYPE_DEVICE_RESET or
REQ_TYPE_PGR_REGISTER, etc). In this patchset I just added new
callouts that modules can implement, because I thought this was most
similar to how we do fabric modules and so it was a ok fit.


