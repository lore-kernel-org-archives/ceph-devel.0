From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/2] rbd: fix read-only option name
Date: Mon, 22 Oct 2012 11:44:57 -0500
Message-ID: <50857809.2010303@inktank.com>
References: <508577B6.2020708@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:60515 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab2JVQpA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 12:45:00 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so2208733iag.19
        for <ceph-devel@vger.kernel.org>; Mon, 22 Oct 2012 09:45:00 -0700 (PDT)
In-Reply-To: <508577B6.2020708@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The name of the "read-only" mapping option was inadvertently changed
in this commit:

    f84344f3 rbd: separate mapping info in rbd_dev

Revert that hunk to return it to what it should be.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 65e9f1f..d032883 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -397,7 +397,7 @@ enum {
 static match_table_t rbd_opts_tokens = {
 	/* int args above */
 	/* string args above */
-	{Opt_read_only, "mapping.read_only"},
+	{Opt_read_only, "read_only"},
 	{Opt_read_only, "ro"},		/* Alternate spelling */
 	{Opt_read_write, "read_write"},
 	{Opt_read_write, "rw"},		/* Alternate spelling */
-- 
1.7.9.5

