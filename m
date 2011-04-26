From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH] auth: Avoid const mismatch when calling
 nss_aes_operation()
Date: Tue, 26 Apr 2011 15:06:13 -0600
Message-ID: <1303851974-29838-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:57503 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757623Ab1DZVHS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Apr 2011 17:07:18 -0400
Received: from interceptor1.sandia.gov (interceptor1.sandia.gov [132.175.109.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-three.sandia.gov (Postfix) with ESMTP id 179784E8AF4
	for <ceph-devel@vger.kernel.org>; Tue, 26 Apr 2011 15:07:07 -0600 (MDT)
Received: from sentry.sandia.gov (mm03snlnto.sandia.gov [132.175.109.20]) by interceptor1.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Tue, 26 Apr 2011 15:02:30 -0600
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>


Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 src/auth/Crypto.cc |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/auth/Crypto.cc b/src/auth/Crypto.cc
index 3dbfd88..757ed79 100644
--- a/src/auth/Crypto.cc
+++ b/src/auth/Crypto.cc
@@ -101,7 +101,7 @@ decrypt(const bufferptr& secret, const bufferlist& in, bufferlist& out) const
 # define AES_KEY_LEN	16
 # define AES_BLOCK_LEN   16
 
-static int nss_aes_operation(CK_ATTRIBUTE_TYPE op, bufferptr& secret, const bufferlist& in, bufferlist& out) {
+static int nss_aes_operation(CK_ATTRIBUTE_TYPE op, const bufferptr& secret, const bufferlist& in, bufferlist& out) {
   const CK_MECHANISM_TYPE mechanism = CKM_AES_CBC_PAD;
 
   // sample source said this has to be at least size of input + 8,
-- 
1.6.6


