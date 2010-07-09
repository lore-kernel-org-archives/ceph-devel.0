From: Christian Brunner <chb@muc.de>
Subject: [PATCH 3/4] ceph.spec.in: add /var/lib/ceph/
Date: Fri, 9 Jul 2010 11:12:39 +0200
Message-ID: <20100709091235.GE29300@bambus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46083 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab0GIJMi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jul 2010 05:12:38 -0400
Received: by fxm14 with SMTP id 14so894179fxm.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Jul 2010 02:12:37 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

---
 ceph.spec.in |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/ceph.spec.in b/ceph.spec.in
index da19a67..de35c24 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -51,6 +51,7 @@ find $RPM_BUILD_ROOT -type f -name "*.a" -exec rm -f {} ';'
 install -D src/init-ceph $RPM_BUILD_ROOT%{_initrddir}/ceph
 chmod 0644 $RPM_BUILD_ROOT%{_sysconfdir}/ceph/sample.ceph.conf
 install -m 0644 -D debian/ceph.logrotate $RPM_BUILD_ROOT%{_sysconfdir}/logrotate.d/ceph
+mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/lib/ceph/tmp/
 
 %clean
 rm -rf $RPM_BUILD_ROOT
@@ -120,7 +121,8 @@ fi
 %{_mandir}/man8/cauthtool.8*
 %{_mandir}/man8/cclass.8.gz
 %{_mandir}/man8/cclsinfo.8.gz
-
+%dir %{_localstatedir}/lib/ceph/
+%dir %{_localstatedir}/lib/ceph/tmp/
 
 %files fuse
 %defattr(-,root,root,-)
-- 
1.6.5.2

