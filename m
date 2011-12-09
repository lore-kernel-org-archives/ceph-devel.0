From: Andre Noll <maan@systemlinux.org>
Subject: [PATCH v2 5/6] doc: Add missing documentation for osd pool get.
Date: Fri,  9 Dec 2011 18:57:44 +0100
Message-ID: <1323453465-30053-6-git-send-email-maan@systemlinux.org>
References: <1323453465-30053-1-git-send-email-maan@systemlinux.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3.gwdg.de ([134.76.10.16]:13147 "EHLO mx3.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561Ab1LIR6F (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 9 Dec 2011 12:58:05 -0500
In-Reply-To: <1323453465-30053-1-git-send-email-maan@systemlinux.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, Andre Noll <maan@systemlinux.org>

"osd pool set" was already documented, but the corresponding "get"
command was not. This patch adds the list of valid fields for this
command, together with short descriptions.

Thanks to Gregory Farnum for pointing out a flaw in the description
of lpl_num and lpgp_num in an earlier version of the patch.

Signed-Off-By: Andre Noll <maan@systemlinux.org>
---
 doc/control.rst |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/doc/control.rst b/doc/control.rst
index 7a1f10e..2c69ddc 100644
--- a/doc/control.rst
+++ b/doc/control.rst
@@ -197,6 +197,17 @@ Changes a pool setting. Valid fields are:
 
 ::
 
+	$ ceph osd pool get POOL FIELD
+
+Get the value of a pool setting. Valid fields are:
+
+	* ``pg_num``: See above.
+	* ``pgp_num``: See above.
+	* ``lpg_num``: The number of local PGs.
+	* ``lpgp_num``: The number used for placing the local PGs.
+
+::
+
 	$ ceph osd scrub N
 
 Sends a scrub command to osdN. To send the command to all osds, use ``*``.
-- 
1.7.8.rc1.14.g248db

