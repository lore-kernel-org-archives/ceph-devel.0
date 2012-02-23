From: "=?UTF-8?B?0JTQtdC90LjRgdC60LAt0YDQtdC00LjRgdC60LA=?="
	<slim@inbox.lv>
Subject: ceph does not work
Date: Thu, 23 Feb 2012 11:15:16 +0200
Message-ID: <1329988516.4f4603a4d1995@mail.inbox.lv>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from shark4.inbox.lv ([89.111.3.84]:55883 "EHLO shark4.inbox.lv"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752003Ab2BWJZQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Feb 2012 04:25:16 -0500
Received: from localhost (w3 [10.0.1.13])
	by shark4-plain-b64d2.inbox.lv (Postfix) with ESMTP id C7071238AA
	for <ceph-devel@vger.kernel.org>; Thu, 23 Feb 2012 11:15:16 +0200 (EET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

ehllo here,

i have tried to setup ceph .41 in simple configuration:
3 nodes, each running mon, mds & osd with replication level 3 for data & metadata pools.
Each node mounts ceph locally via ceph-fuse
cluster seems running well until one of the nodes goes down for simple reboot.
Then all mount points become inaccessible, data transfer hangs and cluster stop working

What is the purpose of ceph software while such simple case does not go through ?

