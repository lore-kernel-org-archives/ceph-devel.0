From: Andre Noll <maan@systemlinux.org>
Subject: [PATCH v2 3/6] doc: Document pause and unpause osd commands.
Date: Fri,  9 Dec 2011 18:57:42 +0100
Message-ID: <1323453465-30053-4-git-send-email-maan@systemlinux.org>
References: <1323453465-30053-1-git-send-email-maan@systemlinux.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3.gwdg.de ([134.76.10.16]:13142 "EHLO mx3.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751238Ab1LIR6D (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 9 Dec 2011 12:58:03 -0500
In-Reply-To: <1323453465-30053-1-git-send-email-maan@systemlinux.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, Andre Noll <maan@systemlinux.org>

These two commands were undocumented so far. This patch adds a short
description.

Signed-Off-By: Andre Noll <maan@systemlinux.org>
---
 doc/control.rst |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/doc/control.rst b/doc/control.rst
index 61e1523..af3c252 100644
--- a/doc/control.rst
+++ b/doc/control.rst
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

