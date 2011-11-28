From: Andre Noll <maan@systemlinux.org>
Subject: [PATCH/RFC 2/6] doc: Add documentation of missing osd commands.
Date: Mon, 28 Nov 2011 15:04:32 +0100
Message-ID: <1322489076-31364-3-git-send-email-maan@systemlinux.org>
References: <20111121180656.GO13394@systemlinux.org>
 <1322489076-31364-1-git-send-email-maan@systemlinux.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3.gwdg.de ([134.76.10.16]:45727 "EHLO mx3.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753225Ab1K1ORA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 28 Nov 2011 09:17:00 -0500
In-Reply-To: <1322489076-31364-1-git-send-email-maan@systemlinux.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, Andre Noll <maan@systemlinux.org>

The set of OSD commands which added by the previous commit is
incomplete. This patch adds documentation for the following
OSD commands which were previously missing: dump, tree, crush,
cluster_snap, lost, create, rm.

Signed-Off-By: Andre Noll <maan@systemlinux.org>
---
 doc/ops/monitor.rst |   44 +++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/doc/ops/monitor.rst b/doc/ops/monitor.rst
index 626685e..07d9c4f 100644
--- a/doc/ops/monitor.rst
+++ b/doc/ops/monitor.rst
@@ -64,9 +64,48 @@ file. This is functionally equivalent to ::
 
 	$ ceph osd getmap -o /tmp/osdmap
 	$ osdmaptool /tmp/osdmap --export-crush file
-
 ::
 
+	$ ceph osd dump [--format format>]
+
+Dump the osd map. Valid formats for -f are "plain" and "json". If no
+--format option is given, the osd map is dumped as plain text. ::
+
+	$ ceph osd tree [--format format]
+
+Dump the osd map as a tree with one line per osd containing weight
+and state. ::
+
+	$ ceph osd crush add <id> <name> <weight> [<loc1> [<loc2> ...]]
+
+Add a new item with the given id/name/weight at the specified
+location. ::
+
+	$ ceph osd crush remove <id>
+
+Remove an existing item from the crush map. ::
+
+	$ ceph osd crush reweight <name> <weight>
+
+Set the weight of the item given by ``<name>`` to ``<weight>``. ::
+
+	$ ceph osd cluster_snap <name>
+
+Create a cluster snapshot. ::
+
+	$ ceph osd lost [--yes-i-really-mean-it]
+
+Mark an OSD as lost. This may result in permanent data loss. Use with caution. ::
+
+	$ ceph osd create [<id>]
+
+Create a new OSD. If no ID is given, a new ID is automatically selected
+if possible. ::
+
+	$ ceph osd rm [<id>...]
+
+Remove the given OSD(s). ::
+
 	$ ceph osd getmaxosd
 
 Query the current max_osd parameter in the osd map. ::
@@ -179,5 +218,4 @@ Enables debug messages. ::
 
 Displays the status of all metadata servers.
 
-dump, getmap, stop, set_max_mds, setmap: TODO
-
+set_max_mds: TODO
-- 
1.7.8.rc1.14.g248db

