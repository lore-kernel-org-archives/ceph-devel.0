From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/8] ceph: cap handling code fixes, cleanups and comments
Date: Mon, 23 Mar 2020 12:07:00 -0400
Message-ID: <20200323160708.104152-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbgCWQHL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:07:11 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ukernel@gmail.com, idryomov@gmail.com, sage@redhat.com

I've been going over the cap handling code with an aim toward
simplifying the locking. There's one fix for a potential use-after-free
race in here. This also eliminates a number of __acquires and __releases
annotations by reorganizing the code, and adds some (hopefully helpful)
comments.

There should be no behavioral changes with this set.

Jeff Layton (8):
  ceph: reorganize __send_cap for less spinlock abuse
  ceph: split up __finish_cap_flush
  ceph: add comments for handle_cap_flush_ack logic
  ceph: don't release i_ceph_lock in handle_cap_trunc
  ceph: don't take i_ceph_lock in handle_cap_import
  ceph: document what protects i_dirty_item and i_flushing_item
  ceph: fix potential race in ceph_check_caps
  ceph: throw a warning if we destroy session with mutex still locked

 fs/ceph/caps.c       | 292 ++++++++++++++++++++++++-------------------
 fs/ceph/mds_client.c |   1 +
 fs/ceph/super.h      |   4 +-
 3 files changed, 170 insertions(+), 127 deletions(-)

-- 
2.25.1
