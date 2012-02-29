From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 4/4] ceph: eliminate some abusive casts
Date: Tue, 28 Feb 2012 19:12:16 -0800
Message-ID: <4F4D9790.5010606@dreamhost.com>
References: <4F4D96F4.3080707@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:44147 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030700Ab2B2DMR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:12:17 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id AC8AC24318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:12:16 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id A14C024314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:12:16 -0800 (PST)
In-Reply-To: <4F4D96F4.3080707@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This fixes some spots where a type cast to (void *) was used as
as a universal type hiding mechanism.  Instead, properly cast the
type to the intended target type.

Signed-off-by: Alex Elder <elder@newdream.net>
---
  net/ceph/messenger.c |    8 ++++----
  1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index e95756a..c410c55 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -62,8 +62,8 @@ const char *ceph_pr_addr(const struct sockaddr_storage 
*ss)
  {
  	int i;
  	char *s;
-	struct sockaddr_in *in4 = (void *)ss;
-	struct sockaddr_in6 *in6 = (void *)ss;
+	struct sockaddr_in *in4 = (struct sockaddr_in *) ss;
+	struct sockaddr_in6 *in6 = (struct sockaddr_in6 *) ss;

  	i = atomic_inc_return(&addr_str_seq) & ADDR_STR_COUNT_MASK;
  	s = addr_str[i];
@@ -1108,8 +1108,8 @@ static void addr_set_port(struct sockaddr_storage 
*ss, int p)
  static int ceph_pton(const char *str, size_t len, struct 
sockaddr_storage *ss,
  		char delim, const char **ipend)
  {
-	struct sockaddr_in *in4 = (void *)ss;
-	struct sockaddr_in6 *in6 = (void *)ss;
+	struct sockaddr_in *in4 = (struct sockaddr_in *) ss;
+	struct sockaddr_in6 *in6 = (struct sockaddr_in6 *) ss;

  	memset(ss, 0, sizeof(*ss));

-- 
1.7.5.4

