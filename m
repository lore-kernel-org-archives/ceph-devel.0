From: Sage Weil <sage@newdream.net>
Subject: Re: Facing some basic stability issues
Date: Fri, 11 Mar 2011 09:10:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1103110909070.23902@cobra.newdream.net>
References: <1299755096.9697.325.camel@indica.cc.iitb.ac.in>
 <Pine.LNX.4.64.1103100927310.27049@cobra.newdream.net>
 <1299853519.15120.14.camel@indica.cc.iitb.ac.in>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52777 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819Ab1CKRIp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Mar 2011 12:08:45 -0500
In-Reply-To: <1299853519.15120.14.camel@indica.cc.iitb.ac.in>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ajit K Jena <ajit@iitb.ac.in>
Cc: ceph-devel@vger.kernel.org

On Fri, 11 Mar 2011, Ajit K Jena wrote:
> Hi Sage,
> 
> We use kernel version 2.6.37. I made a mistake though.
> The clients are FC13 and all others (mon-mds, osd1, osd2)
> are all running FC14.
> 
> Do u feel the difference in OS level (between the client
> and others) could cause such behavior during untar ?

No, it shouldn't matter.

The first question is whether the client is stalling or the servers are.  
On the client, can you

 mount -t debugfs none /sys/kernel/debug
 cat /sys/kernel/debug/ceph/*/mdsc
 cat /sys/kernel/debug/ceph/*/osdc

to see if there are osd or mds requests hanging?  

On the server side, post the output from

 ceph -s

Also, see if a simple test like

 rados -p casdata bench 60 write

completes successfully (just to verify the object store is working).

Thanks-
sage




> 
> Thanks.
> 
> --ajit
>  
> On Thu, 2011-03-10 at 09:27 -0800, Sage Weil wrote:
> > On Thu, 10 Mar 2011, Ajit K Jena wrote:
> > >     Operating System: All the participating systems
> > >                  have Fedora core 14 as the operating
> > >                  system.
> > 
> > Which kernel version is this?
> > 
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
