From: Kuan Kai Chiu <big.chiu@bigtera.com>
Subject: [PATCH] mds: fix setting/removing xattrs on root
Date: Mon, 15 Apr 2013 18:22:27 +0800
Message-ID: <1366021349-5772-1-git-send-email-big.chiu@bigtera.com>
References: <y>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:56497 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab3DOKWe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Apr 2013 06:22:34 -0400
Received: by mail-pb0-f42.google.com with SMTP id up7so2438970pbc.1
        for <ceph-devel@vger.kernel.org>; Mon, 15 Apr 2013 03:22:34 -0700 (PDT)
In-Reply-To: <y>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: henry@ezcloudtech.com, Kuan Kai Chiu <big.chiu@bigtera.com>

MDS crashes while journaling dirty root inode in handle_client_setxattr
and handle_client_removexattr. We should use journal_dirty_inode to
safely log root inode here.

Kuan Kai Chiu (1):
  mds: fix setting/removing xattrs on root

 src/mds/Server.cc |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
1.7.9.5

