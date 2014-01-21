From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH v2 0/3] libceph: #7139 fix
Date: Tue, 21 Jan 2014 13:11:04 +0200
Message-ID: <1390302667-8729-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:53731 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093AbaAULMH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jan 2014 06:12:07 -0500
Received: by mail-ee0-f48.google.com with SMTP id t10so3947440eei.35
        for <ceph-devel@vger.kernel.org>; Tue, 21 Jan 2014 03:12:05 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

Hello,

This series fixes #7139 (Linux kernel client, "dead tcp connections
during connection negotiation may lead to hangs").  1/3 and 2/3 are
preparatory patches, 3/3 is the actual fix.

v2:
- don't set sock_state to CLOSING in connect_timeout handler (2/3)
- disarm connect_timeout timer in con_close_socket() (3/3)

Thanks,

                Ilya


Ilya Dryomov (3):
  libceph: add function names to timeout dout()s
  libceph: introduce con_fault_raise() and switch to it
  libceph: handle dead tcp connections during connection negotiation

 include/linux/ceph/messenger.h |    5 ++++
 net/ceph/ceph_common.c         |    1 +
 net/ceph/messenger.c           |   53 +++++++++++++++++++++++++++++++++++++---
 net/ceph/osd_client.c          |    5 ++--
 4 files changed, 58 insertions(+), 6 deletions(-)

-- 
1.7.10.4

