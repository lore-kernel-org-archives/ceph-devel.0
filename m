From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH] Generate URL-safe base64 strings for keys.
Date: Wed,  4 Jul 2012 14:46:27 +0200
Message-ID: <1341405987-26469-1-git-send-email-wido@widodh.nl>
References: <CADvuQRERYhuFiz07Kp_YxOo_ya6-jACJ3X2gNihp=5F83BJQiQ@mail.gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:52463 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab2GDMqs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 08:46:48 -0400
In-Reply-To: <CADvuQRERYhuFiz07Kp_YxOo_ya6-jACJ3X2gNihp=5F83BJQiQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>

By using this we prevent scenarios where cephx keys are not accepted
in various situations.

Replacing the + and / by - and _ we generate URL-safe base64 keys

Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 src/common/armor.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/common/armor.c b/src/common/armor.c
index d1d5664..7f73da1 100644
--- a/src/common/armor.c
+++ b/src/common/armor.c
@@ -9,7 +9,7 @@
  * base64 encode/decode.
  */
 
-const char *pem_key = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
+const char *pem_key = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
 
 static int encode_bits(int c)
 {
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

