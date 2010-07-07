From: Thomas Mueller <thomas@chaschperli.ch>
Subject: cmds segfault on startup (ceph.git/unstable)
Date: Wed, 7 Jul 2010 09:58:24 +0000 (UTC)
Message-ID: <i11j40$mk1$3@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:46497 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751922Ab0GGJ6i (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 7 Jul 2010 05:58:38 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OWROk-0004Ld-Rw
	for ceph-devel@vger.kernel.org; Wed, 07 Jul 2010 11:58:34 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 07 Jul 2010 11:58:34 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 07 Jul 2010 11:58:34 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

my tests fail today because cmds segfaults on start.


[116817.230467] cmds[2868]: segfault at 10 ip 0000000000686bee sp 
00007fc0a3831230 error 4 in cmds[400000+335000]



Bad Rev: 83d1ea6636dd432dcbb6a0c6046d551bee7be5c6
Last known good: b0056ad0c09dd4e9cbd46f84a4123cdc9c4b7a02 (yesterday)

- Thomas

