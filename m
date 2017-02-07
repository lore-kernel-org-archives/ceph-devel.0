From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v3 0/5] ceph: implement new-style ENOSPC handling in kcephfs
Date: Tue,  7 Feb 2017 07:28:23 -0500
Message-ID: <20170207122828.5550-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753591AbdBGM2a (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 7 Feb 2017 07:28:30 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, jspray@redhat.com

v3: track "abort_on_full" behavior with a new bool in osd request
instead of a protocol flag. Remove some extraneous arguments from
various functions. Don't export have_pool_full, call it from the
abort_on_full callback instead.

v2: teach libcephfs how to hold on to requests until the right map
epoch appears, instead of delaying cap handling in the cephfs layer.

This patchset is an updated version of the patch series originally
done by John Spray and posted here:

    http://www.spinics.net/lists/ceph-devel/msg21257.html

This version incorporates changes based on Ilya's cursory review
yesterday. It also cleans up the handling of requests that should
be aborted on a full condition. The patch that exports have_pool_full
has also been dropped since it's no longer needed.

Jeff Layton (4):
  libceph: allow requests to return immediately on full conditions if
    caller wishes
  libceph: add an epoch_barrier field to struct ceph_osd_client
  ceph: register map callback to handle ENOSPC conditions
  ceph: handle epoch barriers in cap messages

John Spray (1):
  libceph: add ceph_osdc_abort_on_full

 fs/ceph/addr.c                  |   4 ++
 fs/ceph/caps.c                  |  17 +++++--
 fs/ceph/file.c                  |   4 ++
 fs/ceph/mds_client.c            |  33 +++++++++++++
 fs/ceph/mds_client.h            |   7 ++-
 include/linux/ceph/osd_client.h |   7 +++
 net/ceph/osd_client.c           | 100 ++++++++++++++++++++++++++++++++++++----
 7 files changed, 158 insertions(+), 14 deletions(-)

-- 
2.9.3

