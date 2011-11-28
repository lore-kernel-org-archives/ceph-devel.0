From: Andre Noll <maan@systemlinux.org>
Subject: [PATCH/RFC 5/6] doc: Add missing documentation for osd pool get.
Date: Mon, 28 Nov 2011 15:04:35 +0100
Message-ID: <1322489076-31364-6-git-send-email-maan@systemlinux.org>
References: <20111121180656.GO13394@systemlinux.org>
 <1322489076-31364-1-git-send-email-maan@systemlinux.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4.gwdg.de ([134.76.10.17]:35194 "EHLO mx4.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753489Ab1K1OOZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 28 Nov 2011 09:14:25 -0500
In-Reply-To: <1322489076-31364-1-git-send-email-maan@systemlinux.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, Andre Noll <maan@systemlinux.org>

"osd pool set" was already documented, but the corresponding "get"
command was not. This patch adds the list of valid fields for this
command, together with short descriptions.

Signed-Off-By: Andre Noll <maan@systemlinux.org>
---
 doc/ops/monitor.rst |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/doc/ops/monitor.rst b/doc/ops/monitor.rst
index 4de3c19..076c8e1 100644
--- a/doc/ops/monitor.rst
+++ b/doc/ops/monitor.rst
@@ -197,6 +197,17 @@ Changes a pool setting. Valid fields are:
 
 ::
 
+	$ ceph osd pool get POOL FIELD
+
+Get the value of a pool setting. Valid fields are:
+
+	* ``pg_num``: See above.
+	* ``pgp_num``: See above.
+	* ``lpg_num``: The localized pg number.
+	* ``lpgp_num``: The number of localized pgs.
+
+::
+
 	$ ceph osd scrub N
 
 Sends a scrub command to osdN. To send the command to all osds, use ``*``.
-- 
1.7.8.rc1.14.g248db

