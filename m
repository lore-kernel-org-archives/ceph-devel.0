From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH 0/3] shutdown race and debug fix
Date: Wed, 28 Aug 2013 23:24:04 -0700
Message-ID: <1377757447-23515-1-git-send-email-josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:35212 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755339Ab3H2Ggh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Aug 2013 02:36:37 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Josh Durgin <josh.durgin@inktank.com>

These patches fix a race in rbd shutdown and a null deref when
debugging is enabled. They're also available in the wip-rbd-bugs branch
of ceph-client.git.

Josh Durgin (3):
  rbd: fix null dereference in dout
  libceph: add function to ensure notifies are complete
  rbd: close remove vs. notify race leading to use-after-free

 drivers/block/rbd.c             |   33 +++++++++++++++++++++++++++------
 include/linux/ceph/osd_client.h |    2 ++
 net/ceph/osd_client.c           |   11 +++++++++++
 3 files changed, 40 insertions(+), 6 deletions(-)

-- 
1.7.2.5

