From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 0/4] libceph: message skipping fixes
Date: Sat, 20 Feb 2016 17:45:25 +0100
Message-ID: <1455986729-12544-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:32945 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757489AbcBTQpy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 20 Feb 2016 11:45:54 -0500
Received: by mail-wm0-f51.google.com with SMTP id g62so106056715wme.0
        for <ceph-devel@vger.kernel.org>; Sat, 20 Feb 2016 08:45:54 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Varada Kari <Varada.Kari@sandisk.com>

Hello,

Patch 1 hopefully fixes the problem that Varada ran into [1].
Patches 2 and 3 are surrounding fixes, but still important enough to
backport.

[1] http://www.spinics.net/lists/ceph-devel/msg28712.html

Thanks,

                Ilya


Ilya Dryomov (4):
  libceph: don't bail early from try_read() when skipping a message
  libceph: use the right footer size when skipping a message
  libceph: don't spam dmesg with stray reply warnings
  libceph: use sizeof_footer() in ceph_msg_revoke()

 net/ceph/messenger.c  | 26 +++++++++++++-------------
 net/ceph/osd_client.c |  4 ++--
 2 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.4.3

