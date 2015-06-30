From: Douglas Fuller <dfuller@redhat.com>
Subject: [PATCH RFC 0/6] Support rados locking
Date: Tue, 30 Jun 2015 13:27:55 -0700
Message-ID: <cover.1435695881.git.dfuller@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36700 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341AbbF3U3x (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 30 Jun 2015 16:29:53 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id D562719F3A5
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2015 20:29:53 +0000 (UTC)
Received: from rex001.front.sepia.ceph.com ([10.17.112.1])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t5UKTrth018417
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2015 16:29:53 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Add decoding support for some commonly exchanged data structures.
Adapt Mike's code to serve as a generic client for cls::lock in userspace.

Discussion points:
Is this how we want to represent object classes in the kernel client?

This defines ceph_locker to contain ceph_locker_id and ceph_locker_info
from userspace. Is that what we want for adaptation of userspace data
structures (in this case std::map<locker_id_t, locker_info_t>)?

There are quite a few strings in these data structures. Do we want
to add utility functions to properly free them at some level?

Douglas Fuller (4):
  auth.c: added ceph_entity_name_encode
  osd_client: added single object method call
  cls_lock: add rados locking
  cls_lock: add support for lock_info

Mike Christie (2):
  Add support for userspace ceph DECODE_START.
  ceph: add start/finish encoding helpers

 include/linux/ceph/auth.h       |   2 +
 include/linux/ceph/cls_lock.h   |  39 +++++
 include/linux/ceph/decode.h     |  78 ++++++++++
 include/linux/ceph/osd_client.h |   6 +
 net/ceph/Makefile               |   1 +
 net/ceph/auth.c                 |  11 ++
 net/ceph/cls_lock.c             | 329 ++++++++++++++++++++++++++++++++++++++++
 net/ceph/osd_client.c           |  44 ++++++
 8 files changed, 510 insertions(+)
 create mode 100644 include/linux/ceph/cls_lock.h
 create mode 100644 net/ceph/cls_lock.c

-- 
1.9.3

