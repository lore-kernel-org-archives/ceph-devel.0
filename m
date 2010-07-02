From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: PATCH: ceph.spec.in
Date: Fri, 2 Jul 2010 19:45:24 +0000 (UTC)
Message-ID: <i0lfkk$uhq$1@dough.gmane.org>
References: <i0k73i$g5f$2@dough.gmane.org>
	<Pine.LNX.4.64.1007020802470.17984@cobra.newdream.net>
	<4C2E412E.1010408@chaschperli.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:60187 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220Ab0GBTpe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 2 Jul 2010 15:45:34 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OUmB2-0000VX-Hb
	for ceph-devel@vger.kernel.org; Fri, 02 Jul 2010 21:45:32 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 02 Jul 2010 21:45:32 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 02 Jul 2010 21:45:32 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Fri, 02 Jul 2010 21:42:38 +0200 schrieb Thomas Mueller:

> On 02.07.2010 17:04, Sage Weil wrote:
>> Applied this, sans the unpackaged files part.. those are for debugging
>> and testing, and don't need to be installed.  (That probably means
>> 'make install' should ignore them...)
> 
> as long as they are installed with "make install" (at least with mock)
> the build of the packages fail with the message that there are
> unpackaged files and no rpm's are produced.
> 
> 
> - Thomas

PS: maybe only build these binarys with debug enabled?



