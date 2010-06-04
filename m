From: Thomas Mueller <thomas@chaschperli.ch>
Subject: cfuse fail on dbench (ceph.git testing)
Date: Fri, 4 Jun 2010 09:14:28 +0000 (UTC)
Message-ID: <huag5k$te4$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:60815 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753913Ab0FDJOh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jun 2010 05:14:37 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OKSz6-0007FL-JZ
	for ceph-devel@vger.kernel.org; Fri, 04 Jun 2010 11:14:36 +0200
Received: from cust.dyn.95-152-71-88.swisscomdata.ch ([95.152.71.88])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jun 2010 11:14:36 +0200
Received: from thomas by cust.dyn.95-152-71-88.swisscomdata.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jun 2010 11:14:36 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

cfuse fails dbench with ceph.git testing. See logs:

Debian testing ("Squeeze"):
http://chaschperli.ch/testing/testDetails.php?test=71&build=35

Centos 5.5
http://chaschperli.ch/testing/testDetails.php?test=73&build=38


- Thomas

