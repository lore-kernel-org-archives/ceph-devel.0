From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH] Rbd: copy-on-read support for kernel rbd client
Date: Thu, 21 May 2015 11:11:53 +0800
Message-ID: <cover.1432177493.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m53-178.qiye.163.com ([123.58.178.53]:42576 "EHLO
	m53-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbbEUDXQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 May 2015 23:23:16 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Alex Elder <elder@kernel.org>, Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org, Min Chen <minchen@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>, Li Wang <liwang@ubuntukylin.com>

This is a new feature of rbd layering, when reading an object 
from child, if not exist, the kernel rbd client will not only 
request parent for the object, but also write it to child, 
and the jobs are done in an asynchronous way. Therefore, the 
subsequent accesses on this object will hit child without 
bothering parent. This feature could avoid longer latency incurred 
during accessing parent, especially when child and parent are 
geographically isolated, and it also could potentially avoid 
overloading parent.

The patches: 
https://github.com/ceph/ceph-client/pull/11

Min Chen (4):
  Rbd: add an option for copy-on-read
  Rbd: add a new request: rbd_copyup_request
  Rbd: helper functions to manipulate rbd_copyup_request
  Rbd: implement the copy-on-read logic

 drivers/block/rbd.c | 385 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 382 insertions(+), 3 deletions(-)

-- 
1.9.1

