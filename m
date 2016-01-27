From: Ioana Ciornei <ciorneiioana@gmail.com>
Subject: [PATCH 0/2] net: ceph: messenger: replace uses of BUG_ON() with WARN_ON()
Date: Wed, 27 Jan 2016 14:52:26 +0200
Message-ID: <cover.1453898892.git.ciorneiioana@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36369 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbcA0Kwk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jan 2016 05:52:40 -0500
Received: by mail-wm0-f68.google.com with SMTP id l65so2563249wmf.3
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jan 2016 02:52:38 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: elder@ieee.org, Ioana Ciornei <ciorneiioana@gmail.com>

This patchset replaces some uses of BUG_ON() with WARN_ON() and an
approapriate exit since it is advisable not to crash the machin
in every case.

Ioana Ciornei (2):
  net: ceph: messenger: change BUG_ON() to WARN_ON() from
    ceph_con_in_msg_alloc()
  net: ceph: messenger: replace BUG_ON() with WARN_ON() in con_flag_*
    functions

 net/ceph/messenger.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

-- 
2.6.4

