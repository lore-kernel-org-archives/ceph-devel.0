From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH 00/11] rbd bug fix and discard support
Date: Tue,  8 Apr 2014 13:42:44 -0700
Message-ID: <cover.1396987789.git.josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:56372 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756235AbaDHWCY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Apr 2014 18:02:24 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 86004267D5
	for <ceph-devel@vger.kernel.org>; Tue,  8 Apr 2014 14:52:31 -0700 (PDT)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 6C147267B8
	for <ceph-devel@vger.kernel.org>; Tue,  8 Apr 2014 14:52:31 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The first patch in this series fixes a potential race, which may have
been related to http://tracker.ceph.com/issues/7465, though there's
not enough information to tell. I put it before the discard-related
patches so it could be cherry-picked to older kernels as needed.

The next three patches are rebased versions of Guangliang's discard
patches, which have already been reviewd.

The rest are bug fixes which made discard work in my testing for
format 1 and layered format 2 images.

Guangliang Zhao (3):
  rbd: skip the copyup when an entire object writing
  rbd: extend the operation type
  rbd: add discard support for rbd

Josh Durgin (8):
  rbd: access snapshot context and mapping size safely
  rbd: read image size for discard check safely
  rbd: fix snapshot context reference count for discards
  rbd: tolerate -ENOENT for discard operations
  rbd: make discard trigger copy-on-write
  rbd: extract a method for adding object operations
  rbd: use helpers to handle discard for layered images correctly
  rbd: set the remaining discard properties to enable support

 drivers/block/rbd.c |  385 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 269 insertions(+), 116 deletions(-)

-- 
1.7.10.4

