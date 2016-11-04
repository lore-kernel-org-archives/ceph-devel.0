From: Jeff Layton <jlayton@redhat.com>
Subject: [RFC PATCH 00/10] ceph: fix long stalls during fsync and write_inode
Date: Fri,  4 Nov 2016 07:34:23 -0400
Message-ID: <1478259273-3471-1-git-send-email-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754948AbcKDLef (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 4 Nov 2016 07:34:35 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com

This is the companion kernel patchset to this ceph userland pull req:

    https://github.com/ceph/ceph/pull/11710

The problem is that fsync can be very slow on ceph, as it waits for a
cap flush ack. Cap flushes however are generally considered by the MDS
to be background activity, so they don't entail a journal flush on their
own.

The idea here is to add a new flag to cap requests to inform the MDS
that the client is waiting on the reply and that it shouldn't delay it.

In addition, this adds support for the birthtime and change attribute in
cephfs. This is necessary since the new sync flag comes after those
fields.

In current mainline ceph, the btime and change_attribute share a feature
flag with addr2 support. In order to test this, I had to move addr2 to a
new feature flag since the kernel doesn't have that support yet.xi

For now, this is just an RFC set until the userland parts are in place.

Jeff Layton (10):
  ceph: fix minor typo in unsafe_request_wait
  ceph: move xattr initialzation before the encoding past the
    ceph_mds_caps
  ceph: initialize i_version to 0 in new ceph inodes
  ceph: save off btime and change_attr when we get an InodeStat
  ceph: handle btime and change_attr updates in cap messages
  ceph: define new argument structure for send_cap_msg
  ceph: update cap message struct version to 9
  ceph: add sync parameter to send_cap_msg
  ceph: plumb "sync" parameter into __send_cap
  ceph: turn on btime and change_attr support

 fs/ceph/caps.c                     | 307 ++++++++++++++++++++++---------------
 fs/ceph/inode.c                    |  11 +-
 fs/ceph/mds_client.c               |  10 ++
 fs/ceph/mds_client.h               |   2 +
 fs/ceph/snap.c                     |   3 +
 fs/ceph/super.c                    |   3 +-
 fs/ceph/super.h                    |   5 +
 include/linux/ceph/ceph_features.h |   2 +
 8 files changed, 219 insertions(+), 124 deletions(-)

-- 
2.7.4

