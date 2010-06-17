From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: simple performance tests
Date: Thu, 17 Jun 2010 08:53:07 +0000 (UTC)
Message-ID: <hvcnpj$5tm$2@dough.gmane.org>
References: <hva4nu$2nr$1@dough.gmane.org>
	<AANLkTikactG3sjz7mwC1620jM19_6N6W3IPTrbgmIpvr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:54731 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932663Ab0FQIxW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 17 Jun 2010 04:53:22 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OPAqc-0007s4-2B
	for ceph-devel@vger.kernel.org; Thu, 17 Jun 2010 10:53:18 +0200
Received: from cust.dyn.95-152-101-48.swisscomdata.ch ([95.152.101.48])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jun 2010 10:53:18 +0200
Received: from thomas by cust.dyn.95-152-101-48.swisscomdata.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jun 2010 10:53:18 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Wed, 16 Jun 2010 07:45:47 -0700 schrieb Gregory Farnum:

> How's your CPU utilization on that processor? It'd be good if all those
> daemons ran fine on an Atom but I'm not sure?

I'll do some load monitoring and post the results.

> What's your config file
> look like? Journaling enabled?

very simple one derived from sample-ceph.conf:


[global]


[mon]
        mon data = /data/mon$id

[mon0]
        host = ceph
        mon addr = 192.168.236.162:6789

[mds]
        keyring = /data/keyring.$name

[mds.ceph]
        host = ceph

[osd]
        osd data = /data/osd$id
        osd journal = /data/osd$id/journal
        osd journal size = 100

[osd0]
        host = ceph
        btrfs devs = /dev/sda2

[osd1]
        host = ceph
        btrfs devs = /dev/sdb2

