From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH 0/5] ceph: fix long stalls during fsync and write_inode
Date: Thu, 10 Nov 2016 07:52:09 -0500
Message-ID: <1478782334-20667-1-git-send-email-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932467AbcKJMwQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 10 Nov 2016 07:52:16 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com
Cc: ceph-devel@vger.kernel.org

This is the companion kernel patchset to this ceph userland pull req:

    https://github.com/ceph/ceph/pull/11710

The problem is that fsync can be very slow on ceph, as it waits for a
cap flush ack. Cap flushes however are generally considered by the MDS
to be background activity, so they don't entail a journal flush on their
own.

The idea here is to add a new flag to cap requests to inform the MDS
that the client is waiting on the reply and that it shouldn't delay it.

I have a small program that opens a file, writes 16k to it, does an
fsync on it and then a close. It does this 256 times, and with the
current code, it takes around 20 minutes to run (~5s for each file).
With this and the companion patch series, it runs in around 12s.

Jeff Layton (5):
  ceph: fix minor typo in unsafe_request_wait
  ceph: move xattr initialzation before the encoding past the
    ceph_mds_caps
  ceph: define new argument structure for send_cap_msg
  ceph: update cap message struct version to 10
  ceph: add flags parameter to send_cap_msg

 fs/ceph/caps.c               | 289 ++++++++++++++++++++++++++-----------------
 include/linux/ceph/ceph_fs.h |   3 +
 2 files changed, 177 insertions(+), 115 deletions(-)

-- 
2.7.4

