From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: mon crash
Date: Wed, 19 Jun 2013 23:31:59 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B5C219BA2@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B5C2183F2@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1306190900030.27900@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.bendigoit.com.au ([203.16.224.4]:43146 "EHLO
	smtp1.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934170Ab3FSXcT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jun 2013 19:32:19 -0400
In-Reply-To: <alpine.DEB.2.00.1306190900030.27900@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> 
> On Wed, 19 Jun 2013, James Harper wrote:
> > Every time I start up one of my mons it crashes. Two others are running
> > but there seems to be long delays (=several seconds) when doing mon
> > status (maybe this is the behaviour when one mon is down?)
> >
> > The tail of /var/log/ceph/ceph-mon.4.log follows this email.
> >
> > Version is 0.61.3-1~bpo70+1 from http://ceph.com/debian-cuttlefish
> wheezy main
> >
> > This was happening in a previous version, and then even before that but
> > I thought I'd fixed it by wiping the errant mon and recreating it.
> >
> > Anything else I can supply that might help?
> 
> Can you try installing the current cuttlefish branch package and see if
> the problem is still present?  If so, we can gather logs to fully
> diagnose.
> 
> http://gitbuilder.ceph.com/ceph-deb-precise-x86_64-basic/ref/cuttlefish/
> 

I used http://gitbuilder.ceph.com/ceph-deb-wheezy-x86_64-basic/ref/cuttlefish and mon started and joined the cluster within 30 seconds (probably much less), and appears to be running and stable.

Will this patch hit the regular repository soon?

Thanks

James
