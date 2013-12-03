From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH 0/3] block I/O when cluster is full
Date: Tue,  3 Dec 2013 15:12:50 -0800
Message-ID: <1386112373-25610-1-git-send-email-josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:53152 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914Ab3LDAFa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Dec 2013 19:05:30 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 3FBD22667D
	for <ceph-devel@vger.kernel.org>; Tue,  3 Dec 2013 15:59:38 -0800 (PST)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 2B97626679
	for <ceph-devel@vger.kernel.org>; Tue,  3 Dec 2013 15:59:38 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

These patches allow rbd to block writes instead of returning errors
when OSDs are full enough that the FULL flag is set in the osd map.
This avoids filesystems on top of rbd getting confused by transient
EIOs if the cluster oscillates between full and non-full.

These are also available in the wip-full branch of ceph-client.git.

Josh Durgin (3):
  libceph: block I/O when PAUSE or FULL osd map flags are set
  libceph: add an option to configure client behavior when osds are
    full
  rbd: document rbd-specific options

 Documentation/ABI/testing/sysfs-bus-rbd |   19 ++++++++++++++++++
 include/linux/ceph/libceph.h            |    7 +++++++
 include/linux/ceph/osd_client.h         |    1 +
 net/ceph/ceph_common.c                  |   13 +++++++++++++
 net/ceph/osd_client.c                   |   32 +++++++++++++++++++++++++++++--
 5 files changed, 70 insertions(+), 2 deletions(-)

-- 
1.7.10.4

