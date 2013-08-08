From: Sage Weil <sage@inktank.com>
Subject: RE: bug in /etc/init.d/ceph debian
Date: Thu, 8 Aug 2013 08:46:01 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308080843400.18359@cobra.newdream.net>
References: <6035A0D088A63A46850C3988ED045A4B62E7617E@BITCOM1.int.sbss.com.au> <6035A0D088A63A46850C3988ED045A4B62E82A96@BITCOM1.int.sbss.com.au> <alpine.DEB.2.00.1308070822180.3006@cobra.newdream.net>
 <6035A0D088A63A46850C3988ED045A4B62E84BA8@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53429 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757906Ab3HHPqC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Aug 2013 11:46:02 -0400
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B62E84BA8@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 7 Aug 2013, James Harper wrote:
> > Hi James,
> > 
> > Here is a somewhat simpler patch; does this work for you?  Note that if
> > you something like /etc/init.d/ceph status osd.123 where osd.123 isn't in
> > ceph.conf then you get a status 1 instead of 3.  But for the
> > /etc/init.d/ceph status mds (or osd or mon) case where there are no
> > daemons of a particular type it works.
> > 
> > Perhaps the "does not exist" check should be also modified to return 3?
> > 
> 
> Pacemaker will call the RA on every node to see what is running. On a node in an asymmetric cluster where ceph isn't configured, the RA just wants to know that it isn't running - it won't like an error being returned. For a node without even the RA script installed it would return not-installed, but I think that's okay too.
> 
> Do you think maybe the 'ceph status' check and the RA check have conflicting requirements here? Maybe it would be better to leave the init.d script as-is and build the smarts into the RA script instead.

Maybe, but I'm not completely following what the RA's requirements are 
here.  If it's just a matter of the init script returning a different 
error code, though (as we've done so far), I don't see any problem.

> Do idle mds's add any load to the system? Would it be useful to be able to have pacemaker bring up mds's on any two nodes so you always have exactly two running, without actually tying them to specific nodes?

They don't add much load when they are standby, but they will if they end 
up taking over.  There is also no reason to say 'exactly two' IMO.  If you 
have a symmetric cluster I would be more inclined to run one on every node 
for simplicity, recognizing that the active one will use some resources.

sage
