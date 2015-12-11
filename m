From: Jean-Tiare Le Bigot <jean-tiare.le-bigot@corp.ovh.com>
Subject: CEPH_MAX_OID_NAME_LEN in rbd kernel driver
Date: Fri, 11 Dec 2015 15:48:46 +0100
Message-ID: <566AE24E.1050107@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 4.mo175.mail-out.ovh.net ([46.105.33.220]:57344 "EHLO
	4.mo175.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbbLKQFs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Dec 2015 11:05:48 -0500
Received: from EX3.OVH.local (corp.ovh.com [5.196.251.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by mo175.mail-out.ovh.net (Postfix) with ESMTPS id 56E9FFF80E1
	for <ceph-devel@vger.kernel.org>; Fri, 11 Dec 2015 15:48:44 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I hit a use case where rbd was failing to map an image because of the
name length.

dmesg output:

WARNING: CPU: 0 PID: 20851 at include/linux/ceph/osdmap.h:97
rbd_osd_req_create.isra.29+0xdd/0x140()

ceph_oid_set_name
'rbd_id.docker:devel:ib8k2cxvci9sh7b4ly8wwvpyjf6kjoyuero1k25zal3ypc916i04x78tbmn60gjm6pyp38lmjq:latest'
len 101 vs 100, truncating


It turns out the maximum ceph object name length is controlled by the
constant CEPH_MAX_OID_NAME_LEN. I naively tried to increase it to 500
which appears to workaround (fix ?) the issue.


diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index 49ff69f..cf34bb0 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -50,7 +50,7 @@ struct ceph_object_locator {
  *
  * (probably outdated: must be >= RBD_MAX_MD_NAME_LEN -- currently 100)
  */
-#define CEPH_MAX_OID_NAME_LEN 100
+#define CEPH_MAX_OID_NAME_LEN 500

 struct ceph_object_id {
        char name[CEPH_MAX_OID_NAME_LEN];


What is the impact of such a change ? Should I submit a proper patch ?
And, last but not least, shouldn't it return an error instead of trucate
it and fail because, obviously the object does not exist ? Worse, It
could exist with a different data. Which would be an interesting vector
for injecting data in a third party image...


-- 
Jean-Tiare, OVH.com
