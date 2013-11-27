From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 09/18] ceph: Add inline fields to InodeStat
Date: Wed, 27 Nov 2013 21:40:48 +0800
Message-ID: <f4ac331ac81f52b6dba807263f265af990d34ed8.1385558324.git.liwang@ubuntukylin.com>
References: <cover.1385558324.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:48461 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692Ab3K0NlW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Nov 2013 08:41:22 -0500
In-Reply-To: <cover.1385558324.git.liwang@ubuntukylin.com>
In-Reply-To: <cover.1385558324.git.liwang@ubuntukylin.com>
References: <cover.1385558324.git.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Li Wang <liwang@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 src/messages/MClientReply.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/messages/MClientReply.h b/src/messages/MClientReply.h
index 896245f..47908e9 100644
--- a/src/messages/MClientReply.h
+++ b/src/messages/MClientReply.h
@@ -108,6 +108,8 @@ struct InodeStat {
   uint64_t truncate_size;
   utime_t ctime, mtime, atime;
   version_t time_warp_seq;
+  bufferlist inline_data;
+  uint64_t inline_version;
 
   frag_info_t dirstat;
   nest_info_t rstat;
-- 
1.7.9.5

