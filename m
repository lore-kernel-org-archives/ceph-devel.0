From: Thomas Mueller <thomas@chaschperli.ch>
Subject: [PATCH] ceph.spec.in: create /var/log/ceph/stat dir
Date: Thu, 29 Jul 2010 15:52:05 +0000 (UTC)
Message-ID: <i2s835$33r$3@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:59407 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757875Ab0G2PwS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 Jul 2010 11:52:18 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OeVP5-0001f7-HX
	for ceph-devel@vger.kernel.org; Thu, 29 Jul 2010 17:52:15 +0200
Received: from cust.dyn.95-152-98-129.swisscomdata.ch ([95.152.98.129])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jul 2010 17:52:15 +0200
Received: from thomas by cust.dyn.95-152-98-129.swisscomdata.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jul 2010 17:52:15 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

the logrotate config expects a var/log/ceph/stat dir - create it.


diff --git a/ceph.spec.in b/ceph.spec.in
index a74702d..908a65b 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -73,6 +73,7 @@ chmod 0644 $RPM_BUILD_ROOT%{_sysconfdir}/ceph/
sample.ceph.conf
 install -m 0644 -D debian/ceph.logrotate $RPM_BUILD_ROOT%{_sysconfdir}/
logrotate.d/ceph
 mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/lib/ceph/tmp/
 mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/log/ceph/
+mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/log/ceph/stat
 
 %clean
 rm -rf $RPM_BUILD_ROOT

