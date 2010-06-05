From: Thomas Mueller <thomas@chaschperli.ch>
Subject: "VFS: Busy inodes after unmount of ceph" kernel-message after
 umount
Date: Sat, 5 Jun 2010 12:24:45 +0000 (UTC)
Message-ID: <hudfmd$kjm$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:46019 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932946Ab0FEMY6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 5 Jun 2010 08:24:58 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OKsQq-0008Ic-Ff
	for ceph-devel@vger.kernel.org; Sat, 05 Jun 2010 14:24:56 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 05 Jun 2010 14:24:56 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 05 Jun 2010 14:24:56 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

since running an new snapshot test* that creates some(many?) snapshots I 
get this kernel message on umount:

VFS: Busy inodes after unmount of ceph. Self-destruct in 5 seconds.  Have 
a nice day...

this is with kernel 2.6.34 and ceph-client-standalone

- Thomas


* see script here:
http://github.com/vinzent/ceph-testsuite/blob/master/tests/snaptest-2

