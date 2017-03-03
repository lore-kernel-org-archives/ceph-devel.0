From: Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 0/2] fs, ceph filesystem refcount conversions
Date: Fri,  3 Mar 2017 11:15:05 +0200
Message-ID: <1488532507-27863-1-git-send-email-elena.reshetova@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:31621 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751369AbdCCJR3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 3 Mar 2017 04:17:29 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: ceph-devel@vger.kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org, zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, Elena Reshetova <elena.reshetova@intel.com>

Now when new refcount_t type and API are finally merged
(see include/linux/refcount.h), the following
patches convert various refcounters in the ceph filesystem from atomic_t
to refcount_t. By doing this we prevent intentional or accidental
underflows or overflows that can led to use-after-free vulnerabilities.

The below patches are fully independent and can be cherry-picked separately.
Since we convert all kernel subsystems in the same fashion, resulting
in about 300 patches, we have to group them for sending at least in some
fashion to be manageable. Please excuse the long cc list.

Not runtime tested, since I am not sure how to do it for ceph.
However changes are pretty trivial in this case.

Elena Reshetova (2):
  fs, ceph: convert ceph_mds_session.s_ref from atomic_t to refcount_t
  fs, ceph: convert ceph_cap_snap.nref from atomic_t to refcount_t

 fs/ceph/caps.c       |  4 ++--
 fs/ceph/mds_client.c | 18 +++++++++---------
 fs/ceph/mds_client.h |  5 +++--
 fs/ceph/snap.c       |  2 +-
 fs/ceph/super.h      |  5 +++--
 5 files changed, 18 insertions(+), 16 deletions(-)

-- 
2.7.4

