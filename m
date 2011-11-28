From: Andre Noll <maan@systemlinux.org>
Subject: [PATCH/RFC 6/6] doc: Clarify documentation of reweight command.
Date: Mon, 28 Nov 2011 15:04:36 +0100
Message-ID: <1322489076-31364-7-git-send-email-maan@systemlinux.org>
References: <20111121180656.GO13394@systemlinux.org>
 <1322489076-31364-1-git-send-email-maan@systemlinux.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3.gwdg.de ([134.76.10.16]:45662 "EHLO mx3.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753259Ab1K1OQi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 28 Nov 2011 09:16:38 -0500
In-Reply-To: <1322489076-31364-1-git-send-email-maan@systemlinux.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, Andre Noll <maan@systemlinux.org>

This has led to some discussions on the mailing list, so let's try
to be clear about the meaning of an OSD weight.
---
 doc/ops/monitor.rst |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/doc/ops/monitor.rst b/doc/ops/monitor.rst
index 076c8e1..5fcb0aa 100644
--- a/doc/ops/monitor.rst
+++ b/doc/ops/monitor.rst
@@ -152,7 +152,9 @@ resending pending requests. ::
 
 	$ ceph osd reweight N W
 
-Sets the weight of osdN to W. ::
+Set the weight of osdN to W. Two OSDs with the same weight will receive
+roughly the same number of I/O requests and store approximately the
+same amount of data. ::
 
 	$ ceph osd reweight-by-utilization [threshold]
 
-- 
1.7.8.rc1.14.g248db

