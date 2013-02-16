From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/2] libceph: update ceph_mds_state_name() and ceph_mds_op_name()
Date: Sat, 16 Feb 2013 11:06:52 -0600
Message-ID: <511FBCAC.4090506@inktank.com>
References: <511FBC54.9060408@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:49520 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786Ab3BPRGz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 12:06:55 -0500
Received: by mail-qa0-f44.google.com with SMTP id bv4so739351qab.3
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 09:06:54 -0800 (PST)
In-Reply-To: <511FBC54.9060408@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Update ceph_mds_state_name() and ceph_mds_op_name() to include the
newly-added definitions in "ceph_fs.h", and to match its counterpart
in the user space code.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/strings.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/strings.c b/fs/ceph/strings.c
index cd5097d..89fa4a9 100644
--- a/fs/ceph/strings.c
+++ b/fs/ceph/strings.c
@@ -15,6 +15,7 @@ const char *ceph_mds_state_name(int s)
 	case CEPH_MDS_STATE_BOOT:       return "up:boot";
 	case CEPH_MDS_STATE_STANDBY:    return "up:standby";
 	case CEPH_MDS_STATE_STANDBY_REPLAY:    return "up:standby-replay";
+	case CEPH_MDS_STATE_REPLAYONCE: return "up:oneshot-replay";
 	case CEPH_MDS_STATE_CREATING:   return "up:creating";
 	case CEPH_MDS_STATE_STARTING:   return "up:starting";
 		/* up and in */
@@ -50,10 +51,13 @@ const char *ceph_mds_op_name(int op)
 	case CEPH_MDS_OP_LOOKUP:  return "lookup";
 	case CEPH_MDS_OP_LOOKUPHASH:  return "lookuphash";
 	case CEPH_MDS_OP_LOOKUPPARENT:  return "lookupparent";
+	case CEPH_MDS_OP_LOOKUPINO:  return "lookupino";
 	case CEPH_MDS_OP_GETATTR:  return "getattr";
 	case CEPH_MDS_OP_SETXATTR: return "setxattr";
 	case CEPH_MDS_OP_SETATTR: return "setattr";
 	case CEPH_MDS_OP_RMXATTR: return "rmxattr";
+	case CEPH_MDS_OP_SETLAYOUT: return "setlayou";
+	case CEPH_MDS_OP_SETDIRLAYOUT: return "setdirlayout";
 	case CEPH_MDS_OP_READDIR: return "readdir";
 	case CEPH_MDS_OP_MKNOD: return "mknod";
 	case CEPH_MDS_OP_LINK: return "link";
-- 
1.7.9.5

