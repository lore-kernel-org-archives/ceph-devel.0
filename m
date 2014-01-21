From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH] Cephfs Quota Support
Date: Tue, 21 Jan 2014 20:55:29 +0800
Message-ID: <cover.1390274299.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:52993 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbaAUMzr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jan 2014 07:55:47 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Li Wang <liwang@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

This patch implements cephfs quota support.
Currently, the quota is implemented at directory level.

Some key designs behind,
1 Quota is get/set by extend attribute interfrace;
2 QuotaTree is used to buffer quota at client side, 
and it is lazily reconstructed if directory hierarchy 
changed;
3 Quota update is synchronized within mds cluster 
by PolicyLock;
4 New rstat as well as quota are pushed to all related 
clients by auth mds, prior to that, MGatherCaps message 
is used to collect information of clients from other mds;
5 Quota is pushed to client within the reply to readdir 
request;
6 Old mds without quota support is shut down;
7 Moving files across quota trees are forbidden if 
quota enabled.

Review at:
https://github.com/ceph/ceph/pull/1122
Pull at:
https://github.com/kylinstorage/ceph.git wip-cephfs-quota

Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
Yunchuan Wen (25):
  ceph: Add quota feature flags
  ceph: Add quota_info_t to store quota info
  mds: Add quota field to inode_t
  mds: Shutdown old mds without quota support
  mds: Handle quota update
  ceph: Add MClientQuota message type
  ceph: Add MGatherCaps message type
  mds: Push quota info to client by MClientReply
  mds: Export cap to auth mds when mds handle MGatherCaps
  mds: Add broadcast_quota_to_client routine
  mds: Push new rstat and quota info to client
  client: Add class QuotaTree type
  client: Add quota field to Inode
  client: Get root's parents inode when mount -r used
  client: Add quota config to config_opts.h
  client: Add QuotaTree functions
  client: Handle getxattr to show quota information
  client: Handle listxattr to show quota and qstat attributes
  client: Update qtree when fs tree changed
  client: Handle MClientQuota to update quota information
  client: Add helper for quota check
  client: Enforce quota check when creating new file
  client: Forbid moving files across quota trees
  client: Enforce quota check when changing file size
  client: Inform mds file size when approaching quota limit

 src/ceph_mds.cc             |    3 +-
 src/client/Client.cc        |  325 ++++++++++++++++++++++++++++++++++++++++---
 src/client/Client.h         |    9 ++
 src/client/Inode.cc         |    3 +
 src/client/Inode.h          |   79 +++++++++++
 src/common/config_opts.h    |    2 +
 src/include/ceph_features.h |    2 +
 src/include/ceph_fs.h       |    1 +
 src/mds/CInode.cc           |   10 ++
 src/mds/Capability.h        |    1 +
 src/mds/MDCache.cc          |   40 ++++++
 src/mds/MDCache.h           |    1 +
 src/mds/MDS.h               |    3 +
 src/mds/MDSMap.cc           |    1 +
 src/mds/MDSMap.h            |    1 +
 src/mds/Migrator.cc         |   24 ++++
 src/mds/Migrator.h          |    3 +
 src/mds/Server.cc           |   71 +++++++++-
 src/mds/Server.h            |    1 +
 src/mds/mdstypes.cc         |   16 ++-
 src/mds/mdstypes.h          |   31 +++++
 src/messages/MClientQuota.h |   50 +++++++
 src/messages/MClientReply.h |    6 +
 src/messages/MGatherCaps.h  |   32 +++++
 src/messages/Makefile.am    |    2 +
 src/msg/Message.cc          |    8 ++
 src/msg/Message.h           |    1 +
 27 files changed, 700 insertions(+), 26 deletions(-)
 create mode 100644 src/messages/MClientQuota.h
 create mode 100644 src/messages/MGatherCaps.h

-- 
1.7.9.5

