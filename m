From: Andre Noll <maan@systemlinux.org>
Subject: [PATCH v2 6/6] doc: Clarify documentation of reweight command.
Date: Fri,  9 Dec 2011 18:57:45 +0100
Message-ID: <1323453465-30053-7-git-send-email-maan@systemlinux.org>
References: <1323453465-30053-1-git-send-email-maan@systemlinux.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4.gwdg.de ([134.76.10.17]:2297 "EHLO mx4.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752153Ab1LIR6G (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 9 Dec 2011 12:58:06 -0500
In-Reply-To: <1323453465-30053-1-git-send-email-maan@systemlinux.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, Andre Noll <maan@systemlinux.org>

This caused some discussions on the mailing list, so let's try to be clear
about the meaning of an OSD weight.

Signed-Off-By: Andre Noll <maan@systemlinux.org>
---
 doc/control.rst |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/doc/control.rst b/doc/control.rst
index 2c69ddc..133e0ac 100644
--- a/doc/control.rst
+++ b/doc/control.rst
@@ -152,7 +152,9 @@ resending pending requests. ::
 
 	$ ceph osd reweight N W
 
-Sets the weight of osdN to W. ::
+Set the weight of osdN to W. Two OSDs with the same weight will receive
+roughly the same number of I/O requests and store approximately the
+same amount of data. ::
 
 	$ ceph osd reweight-by-utilization [threshold]
 
-- 
1.7.8.rc1.14.g248db

