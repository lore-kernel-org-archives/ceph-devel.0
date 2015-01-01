From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] block: rbd.c:  Remove unused function
Date: Thu,  1 Jan 2015 17:58:32 +0100
Message-ID: <1420131512-30585-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:45161 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbbAAQzc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jan 2015 11:55:32 -0500
Received: by mail-wg0-f43.google.com with SMTP id k14so5471472wgh.16
        for <ceph-devel@vger.kernel.org>; Thu, 01 Jan 2015 08:55:31 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>, Sage Weil <sage@inktank.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Alex Elder <elder@kernel.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Remove the function copy_token() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/block/rbd.c |   30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 27b71a0..922f1ab 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4776,36 +4776,6 @@ static inline size_t next_token(const char **buf)
 }
 
 /*
- * Finds the next token in *buf, and if the provided token buffer is
- * big enough, copies the found token into it.  The result, if
- * copied, is guaranteed to be terminated with '\0'.  Note that *buf
- * must be terminated with '\0' on entry.
- *
- * Returns the length of the token found (not including the '\0').
- * Return value will be 0 if no token is found, and it will be >=
- * token_size if the token would not fit.
- *
- * The *buf pointer will be updated to point beyond the end of the
- * found token.  Note that this occurs even if the token buffer is
- * too small to hold it.
- */
-static inline size_t copy_token(const char **buf,
-				char *token,
-				size_t token_size)
-{
-        size_t len;
-
-	len = next_token(buf);
-	if (len < token_size) {
-		memcpy(token, *buf, len);
-		*(token + len) = '\0';
-	}
-	*buf += len;
-
-        return len;
-}
-
-/*
  * Finds the next token in *buf, dynamically allocates a buffer big
  * enough to hold a copy of it, and copies the token into the new
  * buffer.  The copy is guaranteed to be terminated with '\0'.  Note
-- 
1.7.10.4

