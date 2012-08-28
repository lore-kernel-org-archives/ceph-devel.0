From: Dieter Kasper <d.kasper@kabelmail.de>
Subject: Re: Integration work
Date: Tue, 28 Aug 2012 20:51:16 +0200
Message-ID: <20120828185116.GC9872@oder.mch.fsc.net>
References: <503D0A00.2080905@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpa1.mediabeam.com ([194.25.41.13]:41291 "EHLO
	smtpa2.mediabeam.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236Ab2H1SwQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Aug 2012 14:52:16 -0400
Content-Disposition: inline
In-Reply-To: <503D0A00.2080905@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ross Turk <ross@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Dieter Kasper (KD)" <d.kasper@kabelmail.de>

Hi Ross,

focusing on core stability and feature expansion for RBD was the right appoach 
in the past and I feel you have reached an adequate maturity level here.

Performance enhancements - especially to reduce the latency of a single IO / increase IOPS -
and a stronger engagement on the CephFS client would be very much appreciated.
A stable and fast CephFS client would allow an efficient integration with
- (clustered) NFS (v3 and v4)
- (clustered) Samba v4


Cheers,
-Dieter


On Tue, Aug 28, 2012 at 08:12:16PM +0200, Ross Turk wrote:
> 
> Hi, ceph-devel! It's me, your friendly community guy.
> 
> Inktank has an engineering team dedicated to Ceph, and we want to work 
> on the right stuff. From time to time, I'd like to check in with you to 
> make sure that we are.
> 
> Over the past several months, Inktank's engineers have focused on core 
> stability, radosgw, and feature expansion for RBD. At the same time, 
> they have been regularly allocating cycles to integration work. 
> Recently, this has consisted of improvements to the way Ceph works 
> within OpenStack (even though OpenStack isn't the only technology that 
> we think Ceph should play nicely with).
> 
> What other sorts of integrations would you like to see Inktank engineers 
> work on? For example, are you interested in seeing Inktank spend more of 
> its resources improving interoperability with Apache CloudStack or 
> Eucalyptus? How about Xen?
> 
> Please share your thoughts. We want to contribute in the best way 
> possible with the resources we have, and your input can help.
> 
> Thx,
> Ross
> 
> --
> Ross Turk
> Community, Ceph
> @rossturk @inktank @ceph
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

