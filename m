From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: fix broken data length assertions
Date: Sat, 30 Mar 2013 14:34:06 -0500
Message-ID: <51573E2E.5090406@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:61527 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757011Ab3C3TeI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 30 Mar 2013 15:34:08 -0400
Received: by mail-qa0-f48.google.com with SMTP id hu16so356690qab.7
        for <ceph-devel@vger.kernel.org>; Sat, 30 Mar 2013 12:34:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It's OK for the result of a read to come back with fewer bytes than
were requested.  So don't trigger a BUG() in that case when
initializing the data cursor.

This resolves:
    http://tracker.ceph.com/issues/4598

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index d4e46d8..24f3aba 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -833,7 +833,7 @@ static void ceph_msg_data_pages_cursor_init(struct
ceph_msg_data *data,

 	BUG_ON(!data->pages);
 	BUG_ON(!data->length);
-	BUG_ON(length != data->length);
+	BUG_ON(length > data->length);	/* short reads are OK */

 	cursor->resid = length;
 	page_count = calc_pages_for(data->alignment, (u64)data->length);
@@ -905,7 +905,7 @@ static void
ceph_msg_data_pagelist_cursor_init(struct ceph_msg_data *data,

 	pagelist = data->pagelist;
 	BUG_ON(!pagelist);
-	BUG_ON(length != pagelist->length);
+	BUG_ON(length > pagelist->length);	/* short reads are OK */

 	if (!length)
 		return;		/* pagelist can be assigned but empty */
-- 
1.7.9.5

