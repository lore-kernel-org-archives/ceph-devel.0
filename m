From: Sage Weil <sweil@redhat.com>
Subject: [GIT PULL] Ceph fixes for -rc7
Date: Sat, 5 Mar 2016 20:48:28 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1603052045320.25897@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50048 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbcCFBsw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 5 Mar 2016 20:48:52 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org

Hi Linus,

Please pull the following Ceph patch from

  git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus

This is a final commit we missed to align the protocol compatibility with 
the feature bits.  It decodes a few extra fields in two different messages 
and reports EIO when they are used (not yet supported).

Thanks!
sage


----------------------------------------------------------------
Yan, Zheng (1):
      ceph: initial CEPH_FEATURE_FS_FILE_LAYOUT_V2 support

 fs/ceph/addr.c                     |  4 ++++
 fs/ceph/caps.c                     | 27 ++++++++++++++++++++++++---
 fs/ceph/inode.c                    |  2 ++
 fs/ceph/mds_client.c               | 16 ++++++++++++++++
 fs/ceph/mds_client.h               |  1 +
 fs/ceph/super.h                    |  1 +
 include/linux/ceph/ceph_features.h |  1 +
 7 files changed, 49 insertions(+), 3 deletions(-)
