From: Andre Noll <maan@systemlinux.org>
Subject: [PATCH/RFC 4/6] doc: Update the list of fields for the pool set command.
Date: Mon, 28 Nov 2011 15:04:34 +0100
Message-ID: <1322489076-31364-5-git-send-email-maan@systemlinux.org>
References: <20111121180656.GO13394@systemlinux.org>
 <1322489076-31364-1-git-send-email-maan@systemlinux.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3.gwdg.de ([134.76.10.16]:45690 "EHLO mx3.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752522Ab1K1OQr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 28 Nov 2011 09:16:47 -0500
In-Reply-To: <1322489076-31364-1-git-send-email-maan@systemlinux.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, Andre Noll <maan@systemlinux.org>

This list was lacking a few fields: crash_replay_interval, pg_num,
pgp_num and crush_ruleset. Include these fields and add add short
descriptions.

Signed-Off-By: Andre Noll <maan@systemlinux.org>
---
 doc/ops/monitor.rst |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/doc/ops/monitor.rst b/doc/ops/monitor.rst
index e7314ae..4de3c19 100644
--- a/doc/ops/monitor.rst
+++ b/doc/ops/monitor.rst
@@ -64,6 +64,7 @@ file. This is functionally equivalent to ::
 
 	$ ceph osd getmap -o /tmp/osdmap
 	$ osdmaptool /tmp/osdmap --export-crush file
+
 ::
 
 	$ ceph osd dump [--format format>]
@@ -188,8 +189,11 @@ Creates/deletes a storage pool. ::
 Changes a pool setting. Valid fields are:
 
 	* ``size``: Sets the number of copies of data in the pool.
-	* ``pg_num``: TODO
-	* ``pgp_num``: TODO
+	* ``crash_replay_interval``: The number of seconds to allow
+	  clients to replay acknowledged but uncommited requests.
+	* ``pg_num``: The placement group number.
+	* ``pgp_num``: Effective number when calculating pg placement.
+	* ``crush_ruleset``: rule number for mapping placement.
 
 ::
 
-- 
1.7.8.rc1.14.g248db

