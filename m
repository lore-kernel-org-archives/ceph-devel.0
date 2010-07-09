From: Christian Brunner <chb@muc.de>
Subject: [PATCH] ceph.spec.in: create /var/log/ceph directory
Date: Fri, 9 Jul 2010 16:01:47 +0200
Message-ID: <20100709140147.GA14880@bambus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45908 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054Ab0GIOBs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jul 2010 10:01:48 -0400
Received: by bwz1 with SMTP id 1so1123791bwz.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Jul 2010 07:01:46 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've missed this one in my previous patch series.

Regards,
Christian
---
 ceph.spec.in |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/ceph.spec.in b/ceph.spec.in
index dd6bb8a..75f5c01 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -72,6 +72,7 @@ install -D src/init-ceph $RPM_BUILD_ROOT%{_initrddir}/ceph
 chmod 0644 $RPM_BUILD_ROOT%{_sysconfdir}/ceph/sample.ceph.conf
 install -m 0644 -D debian/ceph.logrotate $RPM_BUILD_ROOT%{_sysconfdir}/logrotate.d/ceph
 mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/lib/ceph/tmp/
+mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/log/ceph/
 
 %clean
 rm -rf $RPM_BUILD_ROOT
@@ -143,6 +144,7 @@ fi
 %{_mandir}/man8/cclsinfo.8.gz
 %dir %{_localstatedir}/lib/ceph/
 %dir %{_localstatedir}/lib/ceph/tmp/
+%dir %{_localstatedir}/log/ceph/
 
 %files fuse
 %defattr(-,root,root,-)
-- 
1.6.5.2

