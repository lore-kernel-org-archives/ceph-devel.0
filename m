From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 0/4] libceph: auth retry/invalidate fixes
Date: Fri, 15 Jan 2016 15:50:41 +0100
Message-ID: <1452869445-10228-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34836 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbcAOOvK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jan 2016 09:51:10 -0500
Received: by mail-wm0-f68.google.com with SMTP id f206so3235448wmf.2
        for <ceph-devel@vger.kernel.org>; Fri, 15 Jan 2016 06:51:09 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sweil@redhat.com>

Hello,

These are fixes for http://tracker.ceph.com/issues/4282, which was
never properly fixed, it looks like.  All long-standing bugs.

Thanks,

                Ilya


Ilya Dryomov (4):
  libceph: clear messenger auth_retry flag if we fault
  libceph: fix authorizer invalidation, take 2
  libceph: invalidate AUTH in addition to a service ticket
  libceph: kill off ceph_x_ticket_handler::validity

 net/ceph/auth_x.c    | 49 ++++++++++++++++++++++++++++++++++++++-----------
 net/ceph/auth_x.h    |  2 +-
 net/ceph/messenger.c | 10 +++++++---
 3 files changed, 46 insertions(+), 15 deletions(-)

-- 
2.4.3

