From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: bug in /etc/init.d/ceph debian
Date: Wed, 7 Aug 2013 23:20:50 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B62E84BA8@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B62E7617E@BITCOM1.int.sbss.com.au>
 <6035A0D088A63A46850C3988ED045A4B62E82A96@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1308070822180.3006@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.bendigoit.com.au ([203.16.224.4]:56305 "EHLO
	smtp1.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933689Ab3HGXUy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Aug 2013 19:20:54 -0400
In-Reply-To: <alpine.DEB.2.00.1308070822180.3006@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> Hi James,
> 
> Here is a somewhat simpler patch; does this work for you?  Note that if
> you something like /etc/init.d/ceph status osd.123 where osd.123 isn't in
> ceph.conf then you get a status 1 instead of 3.  But for the
> /etc/init.d/ceph status mds (or osd or mon) case where there are no
> daemons of a particular type it works.
> 
> Perhaps the "does not exist" check should be also modified to return 3?
> 

Pacemaker will call the RA on every node to see what is running. On a node in an asymmetric cluster where ceph isn't configured, the RA just wants to know that it isn't running - it won't like an error being returned. For a node without even the RA script installed it would return not-installed, but I think that's okay too.

Do you think maybe the 'ceph status' check and the RA check have conflicting requirements here? Maybe it would be better to leave the init.d script as-is and build the smarts into the RA script instead.

Do idle mds's add any load to the system? Would it be useful to be able to have pacemaker bring up mds's on any two nodes so you always have exactly two running, without actually tying them to specific nodes?

James

