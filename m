From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 0/4] libceph: nocephx_sign_messages option + misc
Date: Mon,  2 Nov 2015 23:44:06 +0100
Message-ID: <1446504250-25647-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36250 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbbKBVEb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Nov 2015 16:04:31 -0500
Received: by wmec75 with SMTP id c75so71129984wme.1
        for <ceph-devel@vger.kernel.org>; Mon, 02 Nov 2015 13:04:30 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Zheng Yan <zyan@redhat.com>

Hello,

This adds nocephx_sign_messages libceph option (a lack of which is
something people are running into, see [1]), plus a couple of related
cleanups.

[1] https://forum.proxmox.com/threads/24116-new-krbd-option-on-pve4-don-t-work

Thanks,

                Ilya


Ilya Dryomov (4):
  libceph: msg signing callouts don't need con argument
  libceph: drop authorizer check from cephx msg signing routines
  libceph: stop duplicating client fields in messenger
  libceph: add nocephx_sign_messages option

 fs/ceph/mds_client.c           | 14 ++++++++------
 include/linux/ceph/libceph.h   |  4 +++-
 include/linux/ceph/messenger.h | 16 +++-------------
 net/ceph/auth_x.c              |  8 ++++++--
 net/ceph/ceph_common.c         | 18 +++++++++++++-----
 net/ceph/messenger.c           | 32 ++++++++++++--------------------
 net/ceph/osd_client.c          | 14 ++++++++------
 7 files changed, 53 insertions(+), 53 deletions(-)

-- 
2.4.3

