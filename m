From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: crush update failure ("corrupt inc osdmap epoch 5 off 50")
Date: Thu, 17 Jun 2010 08:41:25 +0000 (UTC)
Message-ID: <hvcn3l$5tm$1@dough.gmane.org>
References: <hv9r6e$4tp$1@dough.gmane.org>
	<Pine.LNX.4.64.1006160950430.12761@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:42710 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756059Ab0FQIlg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 17 Jun 2010 04:41:36 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OPAfF-00021J-Jj
	for ceph-devel@vger.kernel.org; Thu, 17 Jun 2010 10:41:33 +0200
Received: from cust.dyn.95-152-101-48.swisscomdata.ch ([95.152.101.48])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jun 2010 10:41:33 +0200
Received: from thomas by cust.dyn.95-152-101-48.swisscomdata.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jun 2010 10:41:33 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Wed, 16 Jun 2010 09:57:56 -0700 schrieb Sage Weil:

> Hi Thomas,
> 
> On Wed, 16 Jun 2010, Thomas Mueller wrote:
>> i tried to change data "max_size" to 1 to disable replication for
>> testing.
> 
> You don't actually need/want to change the crush map to adjust
> replication.  Each crush rule is written to generalize to some range of
> replication levels (hence the min/max size definitions).  To adjust
> replication for testing/whatever, just do
> 
>  $ ceph osd pool data size 1   # 1x replication
> 
> See
> 
>  http://ceph.newdream.net/wiki/Adjusting_replication_level

ahh, once more i overlooked usefull information.

i've read http://ceph.newdream.net/wiki/Custom_data_placement_with_CRUSH 
and somehow came to the conclusion that this has to be done with an 
update of the crush map. 

the

>  $ ceph osd pool data size 1   # 1x replication

command worked. 

thanks!

- Thomas

