From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH v2 0/2] block I/O when cluster is full
Date: Wed, 11 Dec 2013 15:02:44 -0800
Message-ID: <1386802966-15531-1-git-send-email-josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38812 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab3LKXtj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Dec 2013 18:49:39 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 72956266AB
	for <ceph-devel@vger.kernel.org>; Wed, 11 Dec 2013 15:49:39 -0800 (PST)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 5D616266A3
	for <ceph-devel@vger.kernel.org>; Wed, 11 Dec 2013 15:49:39 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The first patch is the same as in v1. The second is the client side of
a fix for a race condition in handling osdmaps marked full. The fix
for this race condition requires the osd to drop requests rather than
returning ENOSPC when full, so we can't offer the old behavior of
returning an error easily as an rbd option.

Cephfs looks directly at the osdmap to return ENOSPC in aio_write, but
if it hits the race with the osd and loses, it may block instead.
ceph-fuse already blocks, but in the future it may be desirable to
return ENOSPC earlier rather than blocking. This patchset does not
address this at all, it is left for future work.

These patches can also be found in the wip-full-6938 branch of
ceph-client.git.

Josh Durgin (2):
  libceph: block I/O when PAUSE or FULL osd map flags are set
  libceph: resend all writes after the osdmap loses the full flag

 include/linux/ceph/osd_client.h |    1 +
 net/ceph/osd_client.c           |   57 +++++++++++++++++++++++++++++++++------
 2 files changed, 50 insertions(+), 8 deletions(-)

-- 
1.7.10.4

