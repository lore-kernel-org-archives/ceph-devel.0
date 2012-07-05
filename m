From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH] Allow URL-safe base64 cephx keys to be decoded.
Date: Thu,  5 Jul 2012 15:29:54 +0200
Message-ID: <1341494994-32002-1-git-send-email-wido@widodh.nl>
References: <67103350.513LE7Wbhg@linuix>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:35473 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552Ab2GEN37 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 09:29:59 -0400
In-Reply-To: <67103350.513LE7Wbhg@linuix>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>

In these cases + and / are replaced by - and _ to prevent problems when using
the base64 strings in URLs.

Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 src/common/armor.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/common/armor.c b/src/common/armor.c
index d1d5664..e4b8b86 100644
--- a/src/common/armor.c
+++ b/src/common/armor.c
@@ -24,9 +24,9 @@ static int decode_bits(char c)
 		return c - 'a' + 26;
 	if (c >= '0' && c <= '9')
 		return c - '0' + 52;
-	if (c == '+')
+	if (c == '+' || c == '-')
 		return 62;
-	if (c == '/')
+	if (c == '/' || c == '_')
 		return 63;
 	if (c == '=')
 		return 0; /* just non-negative, please */
-- 
1.7.9.5

