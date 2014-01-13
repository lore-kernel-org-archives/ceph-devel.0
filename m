From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 0/3] libceph: #5425 fix
Date: Mon, 13 Jan 2014 12:58:38 +0200
Message-ID: <1389610721-5280-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:64501 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbaAMK7i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jan 2014 05:59:38 -0500
Received: by mail-ee0-f45.google.com with SMTP id d49so3014260eek.18
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jan 2014 02:59:36 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

Hello,

This series fixes a bug that was part of the reason we were hitting
#5425.  In a nutshell, a broken check (fixed in 3/3) was forcing us
into a broken code path (not yet fixed).  1/2 and 2/2 are trivial
renames that however make things much more obvious.

The fix has survived ~60 hours of xfstests in a configuration that
previously took ~5 hours to make it pop up and should probably be
committed w/o waiting for part 2.

Thanks,

                Ilya


Ilya Dryomov (3):
  libceph: rename ceph_msg::front_max to front_alloc_len
  libceph: rename front to front_len in get_reply()
  libceph: fix preallocation check in get_reply()

 include/linux/ceph/messenger.h |    2 +-
 net/ceph/messenger.c           |    7 +++----
 net/ceph/mon_client.c          |    8 ++++----
 net/ceph/osd_client.c          |    9 +++++----
 4 files changed, 13 insertions(+), 13 deletions(-)

-- 
1.7.10.4

