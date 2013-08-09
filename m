From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: bug in /etc/init.d/ceph debian
Date: Fri, 9 Aug 2013 07:09:14 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B62E8B318@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B62E7617E@BITCOM1.int.sbss.com.au>
 <6035A0D088A63A46850C3988ED045A4B62E82A96@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1308070822180.3006@cobra.newdream.net>
 <6035A0D088A63A46850C3988ED045A4B62E84BA8@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1308080843400.18359@cobra.newdream.net>
 <6035A0D088A63A46850C3988ED045A4B62E86B22@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1308081809410.11353@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.bendigoit.com.au ([203.16.224.4]:35701 "EHLO
	smtp1.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967344Ab3HIHJW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Aug 2013 03:09:22 -0400
In-Reply-To: <alpine.DEB.2.00.1308081809410.11353@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> > I haven't tried your patch yet, but can it ever return 0? It seems to
> > set it to 3 initially, and then change it to 1 if it finds an error. I
> > can't see that it ever sets it to 0 indicating that daemons are running.
> > Easy enough to fix by setting the EXIT_STATUS=0 after the check of
> > daemon_is_running, I think, but it still doesn't allow for the case
> > where there are three OSD's, one is running, one is stopped, and one is
> > failed. The EXIT_STATUS in that case appears to be based on the last
> > daemon checked, eg basically random.
> 
> What should it return in that case?
> 

I've been thinking about this some more and I'm still not sure. I think my patch says:
if _any_ are in error then return 1
else if any are running return 0
else if all are stopped return 3

But I think this still won't have the desired outcome if you have 2 OSD's. The possible situations if the resource is supposed to be running are:
. Both running => all good, pacemaker will do nothing
. Both stopped => all good, pacemaker will start the services
. One stopped one running => not good, pacemaker won't make any effort to start services
. One in error, one running => not good. I'm not sure exactly what will happen but it won't be what you expect.

The only solution I can see is to manage the services individually, in which case the init.d script with your patch + setting to 0 if running does the right thing anyway.

James
