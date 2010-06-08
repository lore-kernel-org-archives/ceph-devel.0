From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: "VFS: Busy inodes after unmount of ceph" kernel-message after
 umount
Date: Tue, 8 Jun 2010 08:34:50 +0000 (UTC)
Message-ID: <hukvba$f6o$1@dough.gmane.org>
References: <hudfmd$kjm$1@dough.gmane.org>
	<Pine.LNX.4.64.1006062109410.14891@cobra.newdream.net>
	<huias5$pf4$1@dough.gmane.org>
	<Pine.LNX.4.64.1006072209280.3013@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:37774 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753438Ab0FHIfG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 8 Jun 2010 04:35:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OLuH0-0000K2-N2
	for ceph-devel@vger.kernel.org; Tue, 08 Jun 2010 10:35:02 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 08 Jun 2010 10:35:02 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 08 Jun 2010 10:35:02 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Mon, 07 Jun 2010 22:21:33 -0700 schrieb Sage Weil:

>> > On Sat, 5 Jun 2010, Thomas Mueller wrote:
>> >> hi
>> >> 
>> >> since running an new snapshot test* that creates some(many?)
>> >> snapshots I get this kernel message on umount:
>> >> 
>> >> VFS: Busy inodes after unmount of ceph. Self-destruct in 5 seconds.
>> >> Have a nice day...
>> >> 
>> >> this is with kernel 2.6.34 and ceph-client-standalone
> 
> This turned out to be an MDS bug (not replying to snap flush messages,
> leaving the inodes pinned).  The server side is fixed in the unstable
> and testing branches.  The client should still be fixed to make some
> noise about such problems.
> 
> Thanks for that test script... being able to reliably reproduce the
> problem made fixing it so much easier!
> 
> sage

thanks, verified that the message is gone.

I noticed that it takes now longer to execute the script:
test time now: 1300s
test time before: 800-900s


- Thomas

