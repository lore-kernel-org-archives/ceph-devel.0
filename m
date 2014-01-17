From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 0/3] libceph: #7139 fix
Date: Fri, 17 Jan 2014 15:28:21 +0200
Message-ID: <1389965304-5667-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:42478 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbaAQN3U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jan 2014 08:29:20 -0500
Received: by mail-ea0-f174.google.com with SMTP id b10so1738092eae.5
        for <ceph-devel@vger.kernel.org>; Fri, 17 Jan 2014 05:29:19 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

Hello,

This series fixes #7139 (Linux kernel client, "dead tcp connections
during connection negotiation may lead to hangs").  1/2 and 2/2 are
preparatory patches, 3/3 is the actual fix.

Thanks,

                Ilya


Ilya Dryomov (3):
  libceph: add function names to timeout dout()s
  libceph: introduce con_fault_raise() and switch to it
  libceph: handle dead tcp connections during connection negotiation

 include/linux/ceph/messenger.h |    5 +++++
 net/ceph/ceph_common.c         |    1 +
 net/ceph/messenger.c           |   44 +++++++++++++++++++++++++++++++++++++---
 net/ceph/osd_client.c          |    5 +++--
 4 files changed, 50 insertions(+), 5 deletions(-)

-- 
1.7.10.4

