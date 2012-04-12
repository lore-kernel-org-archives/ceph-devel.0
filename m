From: Madhusudhana U <madhusudhana.u.acharya@gmail.com>
Subject: Partition for OSD journal
Date: Thu, 12 Apr 2012 16:22:02 +0000 (UTC)
Message-ID: <loom.20120412T181758-343@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42423 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932196Ab2DLQWX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 12 Apr 2012 12:22:23 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SIMmn-0006t6-PW
	for ceph-devel@vger.kernel.org; Thu, 12 Apr 2012 18:22:18 +0200
Received: from Static-93.145.96.14.tataidc.co.in ([Static-93.145.96.14.tataidc.co.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 12 Apr 2012 18:22:17 +0200
Received: from madhusudhana.u.acharya by Static-93.145.96.14.tataidc.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 12 Apr 2012 18:22:17 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,
I read in the wiki that, to have a better performance compared to file
under OSD data dir, we can have a seperate partition for OSD journal.
can someone suggest me, how i can mention this in ceph.conf file ?
I have below lines in my ceph.conf file. Is this means I already have
a partition for OSD journal

[osd]
        osd data = /data/osd.$id
        keyring = /etc/ceph/keyring.$name
        osd journal = /journal/osd.$id.journal

/journal is a separate partition of 20G.

Thanks
__M

