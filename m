From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH] osd: user specified flushing for cache tiering
Date: Tue, 28 Jul 2015 12:48:29 +0800
Message-ID: <cover.1438058480.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:38738 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbbG1E6N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jul 2015 00:58:13 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org, Nick Fisk <nick@fisk.me.uk>, Xinze Chi <xmdxcxz@gmail.com>, MingXin Liu <mingxinliu@ubuntukylin.com>, Li Wang <liwang@ubuntukylin.com>

This patch implements user specified cache flushing for cache tiering. In
many use cases, the user traffic is high in only some fixed time, fox example,
work hour. In those cases, it is desirable that the flushing job could be scheduled
in the idle time, and do as much as possible, to reduce the bandwidth contention
with user traffic.

Signed-off-by: Mingxin Liu <mingxinliu@ubuntukylin.com>
Reviewed-by: Li Wang <liwang@ubuntukylin.com>
Suggested-by: Xinze Chi <xmdxcxz@gmail.com>

The codes:
https://github.com/ceph/ceph/pull/5362

Mingxin Liu (5):
  osd: parse and queue user specified flushing
  osd: traverse PGs and reset agent state
  osd: set the default value of agent_timer's "safe_callbacks" be false
  osd: add scheduled flushing work in agent logic
  osd: handle configuration changes for user specified flushing

 src/common/config_opts.h |   2 +
 src/osd/OSD.cc           | 128 ++++++++++++++++++++++++++++++++++++++++++++++-
 src/osd/OSD.h            |  12 +++--
 src/osd/PG.h             |   1 +
 src/osd/ReplicatedPG.cc  |   3 +-
 5 files changed, 141 insertions(+), 5 deletions(-)

-- 
1.9.1

