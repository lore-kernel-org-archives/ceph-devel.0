From: Florian Haas <florian@hastexo.com>
Subject: [PATCH 2/2] OCF RA: fix variable name
Date: Thu,  5 Jan 2012 22:33:32 +0100
Message-ID: <1325799212-14675-3-git-send-email-florian@hastexo.com>
References: <1325799212-14675-1-git-send-email-florian@hastexo.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44884 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758215Ab2AEVdu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jan 2012 16:33:50 -0500
Received: by mail-ee0-f46.google.com with SMTP id c4so668754eek.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jan 2012 13:33:50 -0800 (PST)
In-Reply-To: <1325799212-14675-1-git-send-email-florian@hastexo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Florian Haas <florian@hastexo.com>

---
 src/ocf/ceph.in |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/ocf/ceph.in b/src/ocf/ceph.in
index 9db1bc9..9448a29 100644
--- a/src/ocf/ceph.in
+++ b/src/ocf/ceph.in
@@ -16,15 +16,15 @@ ceph_meta_data() {
     case $__SCRIPT_NAME in
 	"osd")
 	    longdesc="Wraps the ceph init script to provide an OCF resource agent that manages and monitors the Ceph OSD service."
-	    longdesc="Manages a Ceph OSD instance."
+	    shortdesc="Manages a Ceph OSD instance."
 	    ;;
 	"mds")
 	    longdesc="Wraps the ceph init script to provide an OCF resource agent that manages and monitors the Ceph MDS service."
-	    longdesc="Manages a Ceph MDS instance."
+	    shortdesc="Manages a Ceph MDS instance."
 	    ;;
 	"mon")
 	    longdesc="Wraps the ceph init script to provide an OCF resource agent that manages and monitors the Ceph MON service."
-	    longdesc="Manages a Ceph MON instance."
+	    shortdesc="Manages a Ceph MON instance."
 	    ;;
     esac
     
-- 
1.7.5.4

