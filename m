From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: ceph, slow (cheap) and fast (expensive) storage?
Date: Tue, 8 Jun 2010 12:41:21 +0000 (UTC)
Message-ID: <huldph$fmu$1@dough.gmane.org>
References: <4C0E1BAC.8070306@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:48713 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754463Ab0FHMlb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 8 Jun 2010 08:41:31 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OLy7V-0003w2-Vj
	for ceph-devel@vger.kernel.org; Tue, 08 Jun 2010 14:41:29 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 08 Jun 2010 14:41:29 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 08 Jun 2010 14:41:29 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Tue, 08 Jun 2010 12:30:04 +0200 schrieb Tomasz Chmielewski:

> I'd like to build a cluster for storing large amounts of data.
> 
> The cluster would consist of slow (cheap) storage and fast (expensive)
> storage.
> 
> I would like to migrate data from fast (expensive) storage to slow
> (cheap) storage if it wasn't accessed for, say, 6 months.
> 
> Would ceph somehow help me achieve that?


I would not expect to be the fast (expensive) storage to be that faster 
in a ceph cluster. if you get enough cheap storage nodes it will scale 
with the amount of disks/nics as the date is striped among all the nodes 
(osd's). But this is just my speculation.

if you have some amount storage nodes and you are on GigE you will hit 
the ethernet limit on the client faster than anything else. 

"cheap" not in sens of crap hardware. cheap as in SATA 24x7 enterprise 
drives.

and remember:

 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **

- Thomas

PS: "cheap" storage selfmade: 
http://blog.backblaze.com/2009/09/01/petabytes-on-a-budget-how-to-build-
cheap-cloud-storage/

