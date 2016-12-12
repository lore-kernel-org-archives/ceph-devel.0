From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 03/15] libceph: introduce ceph_x_encrypt_offset()
Date: Mon, 12 Dec 2016 21:48:48 +0100
Message-ID: <1481575740-1834-4-git-send-email-idryomov@gmail.com>
References: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:35000 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752704AbcLLUuG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Dec 2016 15:50:06 -0500
Received: by mail-wj0-f196.google.com with SMTP id he10so13559794wjc.2
        for <ceph-devel@vger.kernel.org>; Mon, 12 Dec 2016 12:50:06 -0800 (PST)
Received: from dhcp-1-105.brq.redhat.com ([213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 135sm37201887wmh.14.2016.12.12.12.50.04
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2016 12:50:04 -0800 (PST)
In-Reply-To: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/auth_x.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index 28bde937d58a..de30c585c2a2 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -39,10 +39,14 @@ static int ceph_x_should_authenticate(struct ceph_auth_client *ac)
 	return need != 0;
 }
 
+static int ceph_x_encrypt_offset(void)
+{
+	return sizeof(u32) + sizeof(struct ceph_x_encrypt_header);
+}
+
 static int ceph_x_encrypt_buflen(int ilen)
 {
-	return sizeof(struct ceph_x_encrypt_header) + ilen + 16 +
-		sizeof(u32);
+	return ceph_x_encrypt_offset() + ilen + 16;
 }
 
 static int ceph_x_encrypt(struct ceph_crypto_key *secret,
-- 
2.4.3

