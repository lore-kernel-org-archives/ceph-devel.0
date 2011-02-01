From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: Simple test system not working
Date: Tue, 1 Feb 2011 06:56:01 +0000 (UTC)
Message-ID: <loom.20110201T075137-33@post.gmane.org>
References: <loom.20110201T072445-567@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:43334 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849Ab1BAG4N (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 1 Feb 2011 01:56:13 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1PkA9s-00058v-8r
	for ceph-devel@vger.kernel.org; Tue, 01 Feb 2011 07:56:12 +0100
Received: from 180.148.179.26 ([180.148.179.26])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 01 Feb 2011 07:56:12 +0100
Received: from chris by 180.148.179.26 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 01 Feb 2011 07:56:12 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Chris Dunlop <chris <at> onthe.net.au> writes:
> The ceph filesystem is created using the attached ceph.conf and:

Sorry, no attachments.

ceph.conf:
--------------------------------------------------
[global]
	pid file = /var/run/ceph/$name.pid
	debug ms = 20
	debug mon = 20
[mon]
	mon data = /data/mon$id
	debug ms = 90
	debug mon = 90
	debug paxos = 90
	debug auth = 90
[mon0]
	host = b3
	mon addr = 10.200.63.129:6789
[mds]
	keyring = /data/keyring.$name
[mds.b3]
	host = b3
[osd]
	osd data = /data/osd$id
	osd journal = /data/osd$id/journal
	osd journal size = 1000 ; journal size, in megabytes
	debug ms = 1
	debug osd = 20
	debug filestore = 20
	debug journal = 20
[osd0]
	host = b3
	btrfs devs = /dev/sdb1
--------------------------------------------------

> The attached logs.zip has the full logs from one attempted start.

Available at: http://www.onthe.net.au/private/logs.zip


