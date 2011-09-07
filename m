From: Yehuda Sadeh <yehuda@hq.newdream.net>
Subject: [PATCH 0/2] improve qemu-img conversion performance
Date: Wed,  7 Sep 2011 16:06:51 -0700
Message-ID: <cover.1315436097.git.yehuda@hq.newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:51823 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab1IGW6i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Sep 2011 18:58:38 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org
Cc: sage@newdream.net, yehudasa@gmail.com, Yehuda Sadeh <yehuda@hq.newdream.net>

The following set of patches improve the qemu-img conversion process
performance. When using a higher latency backend, small writes have a
severe impact on the time it takes to do image conversion. 
We switch to using async writes, and we avoid splitting writes due to
holes when the holes are small enough.

Yehuda Sadeh (2):
  qemu-img: async write to block device when converting image
  qemu-img: don't skip writing small holes

 qemu-img.c |   34 +++++++++++++++++++++++++++-------
 1 files changed, 27 insertions(+), 7 deletions(-)

-- 
1.7.5.1

