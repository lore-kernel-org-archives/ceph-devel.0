From: Stratos Psomadakis <psomas@grnet.gr>
Subject: [PATCH] rbd: Fix the showmapped cmd usage
Date: Thu, 10 Nov 2011 00:05:35 +0200
Message-ID: <1320876335-671-1-git-send-email-psomas@grnet.gr>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from averel.grnet-hq.admin.grnet.gr ([195.251.29.3]:14732 "EHLO
	averel.grnet-hq.admin.grnet.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753503Ab1KIWFl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2011 17:05:41 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

If the rbd showmapped cmd is given any extra arguments, rbd will fail
with "assert(0)". Fix it by exiting with "usage_exit()", if any
arguments are present, instead of failing.

Signed-off-by: Stratos Psomadakis <psomas@grnet.gr>
---
 src/rbd.cc |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/rbd.cc b/src/rbd.cc
index 30f045f..47b556d 100644
--- a/src/rbd.cc
+++ b/src/rbd.cc
@@ -986,6 +986,9 @@ int main(int argc, const char **argv)
       case OPT_RENAME:
 	set_conf_param(v, &imgname, &destname);
 	break;
+      case OPT_SHOWMAPPED:
+	usage_exit();
+	break;
       default:
 	assert(0);
 	break;
-- 
1.7.2.5

