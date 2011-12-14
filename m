From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH 0/3] ceph: fix multiple out-of-bounds checks
Date: Wed, 14 Dec 2011 15:24:30 -0500
Message-ID: <1323894273-13904-1-git-send-email-xi.wang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:53937 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832Ab1LNU0A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Dec 2011 15:26:00 -0500
Received: by qcqz2 with SMTP id z2so763871qcq.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Dec 2011 12:26:00 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, Xi Wang <xi.wang@gmail.com>

Fix several possible out-of-bounds pointers if the incoming message is
corrupted or malicious.

Xi Wang (3):
  ceph: fix out-of-bounds pointers in parse_reply_info()
  ceph: fix bounds check macros ceph_decode_need and ceph_encode_need
  ceph: avoid panic with mismatched symbolic link sizes in fill_inode()

 fs/ceph/inode.c             |   10 +++++-----
 fs/ceph/mds_client.c        |    2 ++
 include/linux/ceph/decode.h |    9 +++++++--
 3 files changed, 14 insertions(+), 7 deletions(-)

-- 
1.7.5.4

