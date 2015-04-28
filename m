From: mchristi@redhat.com
Subject: [PATCH 03/10] ceph: export ceph_entity_type_name
Date: Tue, 28 Apr 2015 17:05:40 -0500
Message-ID: <1430258747-12506-4-git-send-email-mchristi@redhat.com>
References: <1430258747-12506-1-git-send-email-mchristi@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46149 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030926AbbD1WFv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Apr 2015 18:05:51 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t3SM5pwq010902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2015 18:05:51 -0400
Received: from rh2.redhat.com (vpn-49-183.rdu2.redhat.com [10.10.49.183])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t3SM5mbO013102
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2015 18:05:51 -0400
In-Reply-To: <1430258747-12506-1-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

The lock info code wants to print this in the debug code so this
patch just exports it.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 net/ceph/ceph_strings.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ceph/ceph_strings.c b/net/ceph/ceph_strings.c
index 139a9cb..5e5ba46 100644
--- a/net/ceph/ceph_strings.c
+++ b/net/ceph/ceph_strings.c
@@ -15,6 +15,7 @@ const char *ceph_entity_type_name(int type)
 	default: return "unknown";
 	}
 }
+EXPORT_SYMBOL(ceph_entity_type_name);
 
 const char *ceph_osd_op_name(int op)
 {
-- 
1.8.3.1

