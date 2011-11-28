From: Andre Noll <maan@systemlinux.org>
Subject: [PATCH/RFC 3/6] doc: Document pause and unpause osd commands.
Date: Mon, 28 Nov 2011 15:04:33 +0100
Message-ID: <1322489076-31364-4-git-send-email-maan@systemlinux.org>
References: <20111121180656.GO13394@systemlinux.org>
 <1322489076-31364-1-git-send-email-maan@systemlinux.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4.gwdg.de ([134.76.10.17]:35194 "EHLO mx4.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753872Ab1K1OO0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 28 Nov 2011 09:14:26 -0500
In-Reply-To: <1322489076-31364-1-git-send-email-maan@systemlinux.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, Andre Noll <maan@systemlinux.org>

These two commands were undocumented so far. This patch adds a short
description.

Signed-Off-By: Andre Noll <maan@systemlinux.org>
---
 doc/ops/monitor.rst |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/doc/ops/monitor.rst b/doc/ops/monitor.rst
index 07d9c4f..e7314ae 100644
--- a/doc/ops/monitor.rst
+++ b/doc/ops/monitor.rst
@@ -145,7 +145,9 @@ List classes that are loaded in the ceph cluster. ::
 	$ ceph osd pause
 	$ ceph osd unpause
 
-TODO ::
+Set or clear the pause flags in the OSD map. If set, no IO requests
+will be sent to any OSD. Clearing the flags via unpause results in
+resending pending requests. ::
 
 	$ ceph osd reweight N W
 
-- 
1.7.8.rc1.14.g248db

