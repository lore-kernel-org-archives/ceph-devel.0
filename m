From: Kuan Kai Chiu <big.chiu@bigtera.com>
Subject: [PATCH] mds: fix setting/removing xattrs on root
Date: Mon, 15 Apr 2013 18:23:22 +0800
Message-ID: <1366021404-5812-1-git-send-email-big.chiu@bigtera.com>
References: <y>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:45778 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762Ab3DOKXe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Apr 2013 06:23:34 -0400
Received: by mail-pa0-f45.google.com with SMTP id kl13so2497897pab.4
        for <ceph-devel@vger.kernel.org>; Mon, 15 Apr 2013 03:23:33 -0700 (PDT)
In-Reply-To: <y>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: henry@bigtera.com, Kuan Kai Chiu <big.chiu@bigtera.com>

MDS crashes while journaling dirty root inode in handle_client_setxattr
and handle_client_removexattr. We should use journal_dirty_inode to
safely log root inode here.

Kuan Kai Chiu (1):
  mds: fix setting/removing xattrs on root

 src/mds/Server.cc |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
1.7.9.5

