From: John Spray <john.spray@redhat.com>
Subject: [PATCH 1/7] ceph: update ceph_msg_header structure
Date: Tue,  4 Nov 2014 14:34:23 +0000
Message-ID: <1415111669-26246-2-git-send-email-john.spray@redhat.com>
References: <1415111669-26246-1-git-send-email-john.spray@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:63082 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbaKDOfM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Nov 2014 09:35:12 -0500
Received: by mail-wi0-f174.google.com with SMTP id d1so9602379wiv.1
        for <ceph-devel@vger.kernel.org>; Tue, 04 Nov 2014 06:35:10 -0800 (PST)
In-Reply-To: <1415111669-26246-1-git-send-email-john.spray@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: John Spray <john.spray@redhat.com>

2 bytes of what was reserved space is now used by
userspace for the compat_version field.

Signed-off-by: John Spray <john.spray@redhat.com>
---
 include/linux/ceph/msgr.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/msgr.h b/include/linux/ceph/msgr.h
index cac4b28..1c18872 100644
--- a/include/linux/ceph/msgr.h
+++ b/include/linux/ceph/msgr.h
@@ -152,7 +152,8 @@ struct ceph_msg_header {
 			     receiver: mask against ~PAGE_MASK */
 
 	struct ceph_entity_name src;
-	__le32 reserved;
+	__le16 compat_version;
+	__le16 reserved;
 	__le32 crc;       /* header crc32c */
 } __attribute__ ((packed));
 
-- 
1.9.3

