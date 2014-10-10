From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 0/3] libceph, rbd: don't lockup under memory pressure
Date: Fri, 10 Oct 2014 22:27:03 +0400
Message-ID: <1412965626-11165-1-git-send-email-idryomov@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:37783 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbaJJS1P (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Oct 2014 14:27:15 -0400
Received: by mail-la0-f46.google.com with SMTP id gi9so3747286lab.5
        for <ceph-devel@vger.kernel.org>; Fri, 10 Oct 2014 11:27:13 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Micha Krause <micha@krausam.de>

Hello,

These are fixes for the problem that Micha was running into and helped
debug.  It appeared to be a stupid bug in messenger and to a lesser
extent in rbd - workqueues in memory reclaim paths really do need to
have WQ_MEM_RECLAIM set.

Thanks,

                Ilya


Ilya Dryomov (3):
  libceph: ceph-msgr workqueue needs a resque worker
  rbd: rbd workqueues need a resque worker
  rbd: use a single workqueue for all devices

 drivers/block/rbd.c  |   32 ++++++++++++++++++--------------
 net/ceph/messenger.c |    6 +++++-
 2 files changed, 23 insertions(+), 15 deletions(-)

-- 
1.7.10.4

