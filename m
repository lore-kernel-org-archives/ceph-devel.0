From: Ajit K Jena <ajit@iitb.ac.in>
Subject: Re: Facing some basic stability issues
Date: Fri, 11 Mar 2011 19:55:19 +0530
Message-ID: <1299853519.15120.14.camel@indica.cc.iitb.ac.in>
References: <1299755096.9697.325.camel@indica.cc.iitb.ac.in>
	 <Pine.LNX.4.64.1103100927310.27049@cobra.newdream.net>
Reply-To: ajit@iitb.ac.in
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.iitb.ac.in ([59.162.23.13]:33551 "HELO smtp1.iitb.ac.in"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751488Ab1CKOZf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 11 Mar 2011 09:25:35 -0500
In-Reply-To: <Pine.LNX.4.64.1103100927310.27049@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

We use kernel version 2.6.37. I made a mistake though.
The clients are FC13 and all others (mon-mds, osd1, osd2)
are all running FC14.

Do u feel the difference in OS level (between the client
and others) could cause such behavior during untar ?

Thanks.

--ajit
 
On Thu, 2011-03-10 at 09:27 -0800, Sage Weil wrote:
> On Thu, 10 Mar 2011, Ajit K Jena wrote:
> >     Operating System: All the participating systems
> >                  have Fedora core 14 as the operating
> >                  system.
> 
> Which kernel version is this?
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


