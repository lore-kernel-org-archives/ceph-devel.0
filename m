From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH v3 00/18] ceph: Inline data support
Date: Wed, 27 Nov 2013 21:40:39 +0800
Message-ID: <cover.1385558324.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:48399 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab3K0NlV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Nov 2013 08:41:21 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Li Wang <liwang@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

This patch implements inline data support for Ceph.
It is also available to be pulled from:
https://github.com/kylinstorage/ceph.git inline

Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
Against v2:
Streamline the inline data migration with the subsequent read/write

Against v1:
With simplified process under multiple-writer case,
referred to
http://pad.ceph.com/p/mds-inline-data,
http://www.spinics.net/lists/ceph-devel/msg16018.html

Li Wang (18):
  ceph: Add inline data feature
  ceph: Add inline state definition
  mds: Add inline fields to inode_t
  mds: Add inline encode/decode to inode_t
  ceph: Add inline fields to MClientCaps
  osdc: Add write method with truncate parameters
  mds: Add inline fields to Capability
  mds: Push inline data to client in cap message
  ceph: Add inline fields to InodeStat
  mds: Push inline data to client in inodestat
  mds: Receive updated inline data from client
  client: Add inline fields to Inode
  client: Receive inline data pushed from mds
  client: Push inline data to mds by send cap
  client: Add inline data migration helper
  client: Read inline data path
  client: Write inline data path
  client: Fallocate inline data path

 src/ceph_mds.cc             |    1 +
 src/client/Client.cc        |  277 +++++++++++++++++++++++++++++++++++++++----
 src/client/Client.h         |    4 +
 src/client/Inode.h          |    5 +
 src/include/ceph_features.h |    2 +
 src/include/ceph_fs.h       |    3 +
 src/mds/CInode.cc           |   22 ++++
 src/mds/Capability.h        |    2 +
 src/mds/Locker.cc           |    7 ++
 src/mds/mdstypes.cc         |   12 +-
 src/mds/mdstypes.h          |    3 +
 src/messages/MClientCaps.h  |   19 ++-
 src/messages/MClientReply.h |    9 ++
 src/osdc/Objecter.h         |   10 +-
 14 files changed, 346 insertions(+), 30 deletions(-)

-- 
1.7.9.5

