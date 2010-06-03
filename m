From: Thomas Mueller <thomas@chaschperli.ch>
Subject: automated testing
Date: Thu, 3 Jun 2010 14:53:29 +0000 (UTC)
Message-ID: <hu8fl9$7nd$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:51156 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755589Ab0FCOxj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 3 Jun 2010 10:53:39 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OKBne-0000L0-7p
	for ceph-devel@vger.kernel.org; Thu, 03 Jun 2010 16:53:38 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jun 2010 16:53:38 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jun 2010 16:53:38 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi 

i thought about some automated testing of ceph. :)

i've once used cdash/ctest . I implemented/configured it for ceph.

here is the cdash page:

"root": 
http://chaschperli.ch/testing

project overview site: 
http://chaschperli.ch/testing/index.php?project=ceph

sample configure/build log: 
http://chaschperli.ch/testing/buildSummary.php?buildid=24

if there is some interest i'll publish the code.


- Thomas

