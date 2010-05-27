From: Thomas Mueller <thomas@chaschperli.ch>
Subject: "Inappropriate ioctl for device"  without "osd journal size"
 specified (0.20.1)
Date: Thu, 27 May 2010 12:52:47 +0000 (UTC)
Message-ID: <htlpuv$70g$3@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:44783 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754561Ab0E0MxD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 27 May 2010 08:53:03 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OHca2-0003Li-Qi
	for ceph-devel@vger.kernel.org; Thu, 27 May 2010 14:52:58 +0200
Received: from cust.static.109-164-193-63.swisscomdata.ch ([109.164.193.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 27 May 2010 14:52:58 +0200
Received: from thomas by cust.static.109-164-193-63.swisscomdata.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 27 May 2010 14:52:58 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

without "osd journal size" specified in ceph.conf the mkcephfs stopps 
with:

 /usr/bin/cosd -c /etc/ceph/ceph.conf --monmap /tmp/monmap.26881 -i 0 --
mkfs --osd-data /ceph/osd0
 ** WARNING: Ceph is still under heavy development, and is only suitable 
for **
 **          testing and review.  Do not trust it with important 
data.       **
mount failed to open journal /ceph/osd0/journal: Inappropriate ioctl for 
device
error creating empty object store in /ceph/osd0: Inappropriate ioctl for 
device


all is ok if "osd journal size = 100" is configured in ceph.conf

- Thomas

