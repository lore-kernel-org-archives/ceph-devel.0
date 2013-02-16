From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/3] libdeph: don't export ceph_osdc_init() or ceph_osdc_stop()
Date: Sat, 16 Feb 2013 10:34:31 -0600
Message-ID: <511FB517.50602@inktank.com>
References: <511FB4D9.7050009@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:34676 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753572Ab3BPQee (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 11:34:34 -0500
Received: by mail-qa0-f46.google.com with SMTP id o13so731310qaj.5
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 08:34:33 -0800 (PST)
In-Reply-To: <511FB4D9.7050009@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The only callers of ceph_osdc_init() and ceph_osdc_stop()
ceph_create_client() and ceph_destroy_client() (respectively)
and they are in the same kernel module as those two functions.
There's therefore no need to export those interfaces, so don't.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index edda070..0d67cd3 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1799,7 +1799,6 @@ out_mempool:
 out:
 	return err;
 }
-EXPORT_SYMBOL(ceph_osdc_init);

 void ceph_osdc_stop(struct ceph_osd_client *osdc)
 {
@@ -1816,7 +1815,6 @@ void ceph_osdc_stop(struct ceph_osd_client *osdc)
 	ceph_msgpool_destroy(&osdc->msgpool_op);
 	ceph_msgpool_destroy(&osdc->msgpool_op_reply);
 }
-EXPORT_SYMBOL(ceph_osdc_stop);

 /*
  * Read some contiguous pages.  If we cross a stripe boundary, shorten
-- 
1.7.9.5

