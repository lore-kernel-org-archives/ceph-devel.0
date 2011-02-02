From: Chris Dunlop <chris@onthe.net.au>
Subject: Speling fixes
Date: Wed, 2 Feb 2011 05:38:54 +0000 (UTC)
Message-ID: <slrnikhrff.3cc.chris@chris.onthe.net.au>
Reply-To: chris@onthe.net.au
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:38206 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752184Ab1BBFkI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 2 Feb 2011 00:40:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1PkVRk-0003Jr-Sv
	for ceph-devel@vger.kernel.org; Wed, 02 Feb 2011 06:40:05 +0100
Received: from 180.148.179.26 ([180.148.179.26])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 02 Feb 2011 06:40:04 +0100
Received: from chris by 180.148.179.26 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 02 Feb 2011 06:40:04 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Trivial spelling fixes...

diff --git a/man/mount.ceph.8 b/man/mount.ceph.8
index d5fe62a..cfcf8f8 100644
--- a/man/mount.ceph.8
+++ b/man/mount.ceph.8
@@ -134,7 +134,7 @@ Report rbytes for st_size on directories.  Default: on
 
 norbytes
 .IP
-Do not report rbytse for st_size.
+Do not report rbytes for st_size.
 .PP
 
 nocrc
diff --git a/src/mds/MDSMap.h b/src/mds/MDSMap.h
index 7bcdd27..6e8a9fa 100644
--- a/src/mds/MDSMap.h
+++ b/src/mds/MDSMap.h
@@ -59,7 +59,7 @@ extern CompatSet mdsmap_compat_base; // pre v0.20
 #define MDS_FEATURE_INCOMPAT_BASE CompatSet::Feature(1, "base v0.20")
 #define MDS_FEATURE_INCOMPAT_CLIENTRANGES CompatSet::Feature(2, "client writeable ranges")
 #define MDS_FEATURE_INCOMPAT_FILELAYOUT CompatSet::Feature(3, "default file layouts on dirs")
-#define MDS_FEATURE_INCOMPAT_DIRINODE CompatSet::Feature(4, "dir inode in separate objec")
+#define MDS_FEATURE_INCOMPAT_DIRINODE CompatSet::Feature(4, "dir inode in separate object")
 
 class MDSMap {
 public:

