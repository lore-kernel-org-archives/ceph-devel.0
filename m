From: Thomas Mueller <thomas@chaschperli.ch>
Subject: ceph.conf sanity checks
Date: Thu, 17 Jun 2010 14:24:05 +0000 (UTC)
Message-ID: <hvdb65$5tm$4@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:37466 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752999Ab0FQOYV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 17 Jun 2010 10:24:21 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OPG0x-0006JB-1D
	for ceph-devel@vger.kernel.org; Thu, 17 Jun 2010 16:24:19 +0200
Received: from cust.dyn.95-152-101-48.swisscomdata.ch ([95.152.101.48])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jun 2010 16:24:19 +0200
Received: from thomas by cust.dyn.95-152-101-48.swisscomdata.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jun 2010 16:24:19 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

doing some testing I've made some mistakes and configured the same device 
for "btrfs devs" and "osd journal". 

I then ran happily "mkcephfs -c /etc/ceph/ceph.conf --mkbtrfs", started 
ceph, mounted it and wrote to it, umounted and stopped ceph.

no errors thrown.

Either ceph does some magic when the journal is on the same device as the 
osd btrfs or it should already stop on parsing the conf if a device is 
configured twice. :) 

- Thomas


