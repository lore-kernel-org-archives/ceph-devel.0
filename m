From: Thomas Mueller <thomas@chaschperli.ch>
Subject: filename too long (pjd-fstest on centos5 with ceph 0.20.2)
Date: Mon, 31 May 2010 10:35:30 +0000 (UTC)
Message-ID: <hu03dh$vgc$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:51702 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756736Ab0EaKfj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 31 May 2010 06:35:39 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OJ2LK-0007ue-7Z
	for ceph-devel@vger.kernel.org; Mon, 31 May 2010 12:35:38 +0200
Received: from zux221-125-110.adsl.green.ch ([81.221.125.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 31 May 2010 12:35:38 +0200
Received: from thomas by zux221-125-110.adsl.green.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 31 May 2010 12:35:38 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi 

i'm doing some testing. i've ran pjd-fstest. on ceph (kclient) 
mountpoints there are many "file name too long" messages. 

example error message:
mkdir: `_xxxxxx-veryveryveryverylongpath/x': File name too long


fstest results:

Failed Test                   Stat Wstat Total Fail  Failed  List of Failed
-------------------------------------------------------------------------------
/tmp/fstest/tests/mkdir/00.t                36    5  13.89%  30-34
/tmp/fstest/tests/mkfifo/00.t               36    5  13.89%  30-34
/tmp/fstest/tests/open/00.t                 47    5  10.64%  30-34
Failed 3/184 test scripts, 98.37% okay. 15/1957 subtests failed, 99.23% 
okay.


if I run fstest on the local filesystem it completes without errors - so 
the "filename too long" seems to be a ceph specific error.

- Thomas

Env:
- 4x osd, 1x mds, 1x mon, 1x kclient
- ceph 0.20.2, ceph kclient 2.6.34, Cento5, pjd-fstest-20080816

