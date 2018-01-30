From: Luis Henriques <lhenriques@suse.com>
Subject: [RFC PATCH 0/1] quota: report root dir quota usage in statfs
Date: Tue, 30 Jan 2018 11:45:29 +0000
Message-ID: <20180130114530.26266-1-lhenriques@suse.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51631 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751451AbeA3Lpd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 30 Jan 2018 06:45:33 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>, Luis Henriques <lhenriques@suse.com>

Following this email I'm sending a patch that modifies the statfs
behaviour in cephfs kernel client so that, by default, it shows the
quota statistics for the root directory instead of the overall
filesystem usage.

I'm sending this patch as an RFC because:

 * I'm not sure people really want to have this behaviour -- this is the
   default for the ceph-fuse client, so I just wanted to have a similar
   behaviour in the kernel client.
 * Showing quota usage by default may not be the correct option,
   although (again!) this is what the ceph-fuse client does.

Anyway, there's also a new mount option ('noquotadf') to revert to the
old statfs even if the root dir has max_bytes set.

Just for reference, this statfs behaviour was added to the ceph-fuse
client by commit b6d2b6d1a519 ("client: report root's quota in
statfs").

Luis Henriques (1):
  quota: report root dir quota usage for statfs by default

 Documentation/filesystems/ceph.txt |  4 +++
 fs/ceph/quota.c                    | 56 ++++++++++++++++++++++++++++++++++++++
 fs/ceph/super.c                    | 22 +++++++++++++--
 fs/ceph/super.h                    |  3 ++
 4 files changed, 82 insertions(+), 3 deletions(-)

