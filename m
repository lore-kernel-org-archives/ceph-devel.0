From: Sage Weil <sage@inktank.com>
Subject: deb/rpm package purge
Date: Tue, 19 Mar 2013 12:48:02 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303191246330.4850@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51169 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542Ab3CSTsD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Mar 2013 15:48:03 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, james.page@ubuntu.com, gcs@debian.hu

Should the package purge remove /var/lib/ceph/* (potential mon data, osd 
data) and/or /var/log/ceph/* (logs)?  Right now it does, but mysql, for 
example, leaves /var/lib/mysql where it is (not sure about logs).

sage
