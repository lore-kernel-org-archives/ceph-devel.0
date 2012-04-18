From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 6/6] rbd: correct sysfs snap attribute documentation
Date: Wed, 18 Apr 2012 09:41:15 -0500
Message-ID: <4F8ED28B.9010705@dreamhost.com>
References: <4F8ED154.6050500@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:39347 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab2DROlQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 10:41:16 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id DD9CE244A7
	for <ceph-devel@vger.kernel.org>; Wed, 18 Apr 2012 07:44:18 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net [71.195.31.37])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id B1FAE2444A
	for <ceph-devel@vger.kernel.org>; Wed, 18 Apr 2012 07:44:18 -0700 (PDT)
In-Reply-To: <4F8ED154.6050500@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Each attribute is prefixed with "snap_".

Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
Reviewed-by: Alex Elder <elder@dreamhost.com>
---
  Documentation/ABI/testing/sysfs-bus-rbd |    4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/Documentation/ABI/testing/sysfs-bus-rbd
===================================================================
--- a/Documentation/ABI/testing/sysfs-bus-rbd
+++ b/Documentation/ABI/testing/sysfs-bus-rbd
@@ -65,11 +65,11 @@
  Entries under /sys/bus/rbd/devices/<dev-id>/snap_<snap-name>
  -------------------------------------------------------------

-id
+snap_id

  	The rados internal snapshot id assigned for this snapshot

-size
+snap_size

  	The size of the image when this snapshot was taken.

