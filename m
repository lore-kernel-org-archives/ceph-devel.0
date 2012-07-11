From: Alex Elder <elder@inktank.com>
Subject: [PATCH 01/16] libceph: fix off-by-one bug in ceph_encode_filepath()
Date: Wed, 11 Jul 2012 09:00:33 -0500
Message-ID: <4FFD8701.6020203@inktank.com>
References: <4FFD847C.7070205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:55042 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757594Ab2GKOAh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 10:00:37 -0400
Received: by ghrr11 with SMTP id r11so1224069ghr.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 07:00:37 -0700 (PDT)
In-Reply-To: <4FFD847C.7070205@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There is a BUG_ON() call that doesn't account for the single byte
structure version at the start of an encoded filepath in
ceph_encode_filepath().  Fix that.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/decode.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
index d8615de..bcbd66c 100644
--- a/include/linux/ceph/decode.h
+++ b/include/linux/ceph/decode.h
@@ -151,7 +151,7 @@ static inline void ceph_encode_filepath(void **p,
void *end,
 					u64 ino, const char *path)
 {
 	u32 len = path ? strlen(path) : 0;
-	BUG_ON(*p + sizeof(ino) + sizeof(len) + len > end);
+	BUG_ON(*p + 1 + sizeof(ino) + sizeof(len) + len > end);
 	ceph_encode_8(p, 1);
 	ceph_encode_64(p, ino);
 	ceph_encode_32(p, len);
-- 
1.7.5.4

