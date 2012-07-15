From: Jiaju Zhang <jjzhang@suse.de>
Subject: [PATCH] libceph: trivial fix for the incorrect debug output
Date: Sun, 15 Jul 2012 14:45:26 +0800
Message-ID: <1342334726-28541-1-git-send-email-jjzhang@suse.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42898 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807Ab2GOGp4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 15 Jul 2012 02:45:56 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id C62EEA2111
	for <ceph-devel@vger.kernel.org>; Sun, 15 Jul 2012 08:45:54 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jiaju Zhang <jjzhang@suse.de>

This is a trivial fix for the debug output, as it is inconsistent
with the function name so may confuse people when debugging.

Signed-off-by: Jiaju Zhang <jjzhang@suse.de>
---
 net/ceph/osd_client.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 1ffebed..ad6d745 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -688,7 +688,7 @@ static void __remove_osd(struct ceph_osd_client *osdc, struct ceph_osd *osd)
 
 static void remove_all_osds(struct ceph_osd_client *osdc)
 {
-	dout("__remove_old_osds %p\n", osdc);
+	dout("__remove_all_osds %p\n", osdc);
 	mutex_lock(&osdc->request_mutex);
 	while (!RB_EMPTY_ROOT(&osdc->osds)) {
 		struct ceph_osd *osd = rb_entry(rb_first(&osdc->osds),
