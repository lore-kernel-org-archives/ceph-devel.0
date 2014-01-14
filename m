From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH v6] ceph: Inline data support
Date: Tue, 14 Jan 2014 16:14:03 +0800
Message-ID: <cover.1389686940.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:42687 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbaANIOY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jan 2014 03:14:24 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Li Wang <liwang@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

This patch implements inline data support for Ceph.
Review at:
https://github.com/ceph/ceph/pull/1081
Pull at:
https://github.com/kylinstorage/ceph.git wip-inline

Li Wang (23):
  ceph: Add inline data feature
  ceph: Add inline state definition

Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
Against v5:
Remove two unnecessary lines of codes according to Zheng's comments

Against v4:
Forbid old mds without inline support to join inline ever enabled mds cluster
Kick out old mds without inline support when inline enabled
Return EPERM to old client without inline support when it is trying to open inlined file

Use version_t instead of __u64 for inline version

Against v3:
Add the inline switch and make inline size tunable
Improve the back compatibility of mds from (9, 9) to (9, 6), provided the inlinefeature is disabled until all mds upgraded to support inline

Against v2:
Streamline the inline data migration with the subsequent read/write

Against v1:
With simplified process under multiple-writer case,
referred to
http://pad.ceph.com/p/mds-inline-data,
http://www.spinics.net/lists/ceph-devel/msg16018.html
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
  client: Make inline size tunable
  mds: Add inline switch
  mds: Shutdown old mds when inline enable
  mds: Handle client compatibility
  client: Avoid uninline empty inline data

 src/ceph_mds.cc             |    1 +
 src/client/Client.cc        |  284 +++++++++++++++++++++++++++++++++++++++----
 src/client/Client.h         |    4 +
 src/client/Inode.h          |    5 +
 src/common/config_opts.h    |    1 +
 src/include/ceph_features.h |    2 +
 src/include/ceph_fs.h       |    3 +
 src/mds/CInode.cc           |   25 ++++
 src/mds/Capability.h        |    2 +
 src/mds/Locker.cc           |   11 ++
 src/mds/MDS.cc              |    5 +-
 src/mds/MDS.h               |    3 +
 src/mds/MDSMap.cc           |   25 +++-
 src/mds/MDSMap.h            |   12 +-
 src/mds/Server.cc           |   11 ++
 src/mds/mdstypes.cc         |   12 +-
 src/mds/mdstypes.h          |    3 +
 src/messages/MClientCaps.h  |   19 ++-
 src/messages/MClientReply.h |    9 ++
 src/mon/MDSMonitor.cc       |    9 +-
 src/mon/MonCommands.h       |    6 +
 src/osdc/Objecter.h         |   10 +-
 22 files changed, 424 insertions(+), 38 deletions(-)

-- 
1.7.9.5

