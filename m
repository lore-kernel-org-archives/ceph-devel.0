From: Thomas Mueller <thomas@chaschperli.ch>
Subject: pdj-fstest mkdir/rm error messages  again
Date: Thu, 17 Jun 2010 14:55:33 +0000 (UTC)
Message-ID: <hvdd15$r1o$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:40302 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756173Ab0FQOzv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 17 Jun 2010 10:55:51 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OPGVO-0000s7-Ss
	for ceph-devel@vger.kernel.org; Thu, 17 Jun 2010 16:55:46 +0200
Received: from cust.dyn.95-152-101-48.swisscomdata.ch ([95.152.101.48])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jun 2010 16:55:46 +0200
Received: from thomas by cust.dyn.95-152-101-48.swisscomdata.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jun 2010 16:55:46 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

for a while the pdj-fstest worked without error messages. 

now the pdj-fstest says again "successfull" but prints these:

/home/tmu//home/tmu/src/ceph-testsuite/tools/pjd-fstest-20080816/tests/chmod/02.t ..... ok
mkdir: cannot create directory `_xxxxveryveryveryverylongxxxxxxxxxxx': File name too long
rm: cannot remove `_xxveryveryveryverylongxxxxxx': File name too long
/home/tmu/src/ceph-testsuite/tools/pjd-fstest-20080816/tests/chmod/03.t ..... oksrc/ceph-testsuite/tools/pjd-fstest-20080816/tests/chmod/02.t ..... ok
mkdir: cannot create directory `_xxxxveryveryveryverylongxxxxxxxxxxx': File name too long
rm: cannot remove `_xxveryveryveryverylongxxxxxx': File name too long
/home/tmu/src/ceph-testsuite/tools/pjd-fstest-20080816/tests/chmod/03.t ..... ok


ceph.git revs (maybe this is kclient related and this means nothing):
rev ok: 
658d51dae14a724f167a02f18ebce19ca943f465 (2010-06-13 10:25:45 CEST)

rev bad again: 
658d51dae14a724f167a02f18ebce19ca943f465 (2010-06-14 16:32:03 CEST)

- Thomas

