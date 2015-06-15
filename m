From: James Devine <fxmulder@gmail.com>
Subject: [PATCH] Allow CRLF in config files
Date: Mon, 15 Jun 2015 17:53:38 -0600
Message-ID: <1434412418-32247-1-git-send-email-fxmulder@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp-cuda2.gwtc.net ([64.251.188.104]:54374 "EHLO
	smtp-cuda2.e-filtering.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751885AbbFPAMJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 15 Jun 2015 20:12:09 -0400
Received: from smtp-cluster2.gwtc.net (smtp-outgoing1.gwtc.net [64.251.188.229]) by smtp-cuda2.e-filtering.net with ESMTP id 28kQy3IEu20Cj3Rg for <ceph-devel@vger.kernel.org>; Mon, 15 Jun 2015 17:53:45 -0600 (MDT)
Received: from kernel1.gwtc.net (unknown [64.251.162.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: jdevine@rapidnet.com)
	by smtp-cluster2.gwtc.net (Postfix) with ESMTPSA id DCC57400F6
	for <ceph-devel@vger.kernel.org>; Mon, 15 Jun 2015 17:53:45 -0600 (MDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Change config fopen to binary mode, allowing LF and CRLF EOL characters so
ceph-dokan can work with native windows configuration files going forward.
The carriage return is ignored and trimmed as whitespace during parsing via
isspace().

Signed-off-by: James Devine <fxmulder@gmail.com>
---
 src/common/ConfUtils.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common/ConfUtils.cc b/src/common/ConfUtils.cc
index 1ae5df5..a717077 100644
--- a/src/common/ConfUtils.cc
+++ b/src/common/ConfUtils.cc
@@ -99,7 +99,7 @@ parse_file(const std::string &fname, std::deque<std::string> *errors,
   int ret = 0;
   size_t sz;
   char *buf = NULL;
-  FILE *fp = fopen(fname.c_str(), "r");
+  FILE *fp = fopen(fname.c_str(), "rb");
   if (!fp) {
     ret = -errno;
     return ret;
-- 
1.9.1

