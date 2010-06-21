From: Thomas Mueller <thomas@chaschperli.ch>
Subject: ceph: splice_dentry error
Date: Mon, 21 Jun 2010 12:01:22 +0000 (UTC)
Message-ID: <hvnkai$3lg$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:53492 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932223Ab0FUMBd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 21 Jun 2010 08:01:33 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OQfgx-0001xu-8m
	for ceph-devel@vger.kernel.org; Mon, 21 Jun 2010 14:01:31 +0200
Received: from cust.dyn.95-152-66-220.swisscomdata.ch ([95.152.66.220])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 21 Jun 2010 14:01:31 +0200
Received: from thomas by cust.dyn.95-152-66-220.swisscomdata.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 21 Jun 2010 14:01:31 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi

since 2 days 1 of my tests fail and crash my machine. 

the script crashing the machine is:
http://github.com/vinzent/ceph-testsuite/blob/master/tests/snaptest-2 
( take lines 13 to 67 for standalone usage)

i can see these messages before my machine stops responding:

[11188.432605] ceph:  tid 67394 timed out on osd0, will reset osd
[11530.455936] ceph: splice_dentry error ffff8800a4891d80 inode 
ffff880100349d30 ino 10000001a4d.6
[11530.455961] BUG: unable to handle kernel NULL pointer dereference at 
0000000000000078
[11530.455964] IP: [<ffffffffa0734049>] update_dentry_lease+0x20/0x10a 
[ceph]

(full output: http://pastebin.com/WFUztaEP)


kclient: ceph-client-standalone/unstable-backport
ceph: ceph/unstable

last known working ceph/unstable git ref
 c626ac384678661b765c1ae1dee8db48b2c70993 

- Thomas

