From: Andre Noll <maan@systemlinux.org>
Subject: [PATCH v2 4/6] doc: Update the list of fields for the pool set command.
Date: Fri,  9 Dec 2011 18:57:43 +0100
Message-ID: <1323453465-30053-5-git-send-email-maan@systemlinux.org>
References: <1323453465-30053-1-git-send-email-maan@systemlinux.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4.gwdg.de ([134.76.10.17]:2297 "EHLO mx4.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751361Ab1LIR6E (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 9 Dec 2011 12:58:04 -0500
In-Reply-To: <1323453465-30053-1-git-send-email-maan@systemlinux.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, Andre Noll <maan@systemlinux.org>

This list was lacking a few fields: crash_replay_interval, pg_num,
pgp_num and crush_ruleset. Include these fields and add add short
descriptions.

Signed-Off-By: Andre Noll <maan@systemlinux.org>
---
 doc/control.rst |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/doc/control.rst b/doc/control.rst
index af3c252..7a1f10e 100644
--- a/doc/control.rst
+++ b/doc/control.rst
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

