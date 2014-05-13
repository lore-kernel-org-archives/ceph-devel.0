From: Min Chen <minchen@ubuntukylin.com>
Subject: [PATCH 0/3] librbd copy-on-read v2
Date: Tue, 13 May 2014 17:12:12 +0800
Message-ID: <cover.1399970127.git.minchen@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:60246 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758818AbaEMJUb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 May 2014 05:20:31 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: josh.durgin@inktank.com
Cc: ceph-devel@vger.kernel.org

summary:
  Rbd clone shares objects with its parent, unless writing data to clone. When read data from clone, it copy data from its parent if
object doesn't exits in clone. Each time read the same object(not in clone), the clone must send request to its parent. Usually the network latency
is bottleneck of read performance. If store the object into clone after copyup it from parent, then the next time read the same object
just in clone, which can improve read performance.
  Copy entire object from parent,no matter read entire or part of object.

Min Chen (3):
  librbd: copy-on-read for clones, add an option for copy-on-read
  librbd: copy-on-read for clones, read entire object from parent
  librbd: copy-on-read for clones, write entire object into child
    asychronously

 src/common/config_opts.h |    1 +
 src/include/xlist.h      |    1 +
 src/librbd/AioRequest.cc |   88 ++++++++++++++++++++++++++++++++++++++++++++--
 src/librbd/AioRequest.h  |    4 +++
 src/librbd/ImageCtx.cc   |   68 +++++++++++++++++++++++++++++++++++
 src/librbd/ImageCtx.h    |    6 ++++
 src/librbd/internal.cc   |    4 +++
 7 files changed, 169 insertions(+), 3 deletions(-)

-- 
1.7.10.4

