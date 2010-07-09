From: Christian Brunner <chb@muc.de>
Subject: [PATCH 2/4] ceph.spec.in: add logrotate configuration
Date: Fri, 9 Jul 2010 11:12:16 +0200
Message-ID: <20100709091216.GD29300@bambus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34660 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab0GIJMP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jul 2010 05:12:15 -0400
Received: by bwz1 with SMTP id 1so929222bwz.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Jul 2010 02:12:14 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

---
 ceph.spec.in |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/ceph.spec.in b/ceph.spec.in
index 20bb12a..da19a67 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -100,6 +100,7 @@ fi
 %{_libdir}/ceph
 %config(noreplace) %{_sysconfdir}/ceph/sample.ceph.conf
 %config(noreplace) %{_sysconfdir}/ceph/sample.fetch_config
+%config(noreplace) %{_sysconfdir}/logrotate.d/ceph
 %{_mandir}/man8/cmon.8*
 %{_mandir}/man8/cmds.8*
 %{_mandir}/man8/cosd.8*
-- 
1.6.5.2

