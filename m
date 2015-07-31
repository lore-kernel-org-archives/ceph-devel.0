From: Marcus Watts <mwatts@redhat.com>
Subject: Re: Cluster Network & Public Network w.r.t XIO ?
Date: Fri, 31 Jul 2015 16:28:35 -0400
Message-ID: <20150731202835.GA2358@pika.private.linuxbox.com>
References: <CAFkUHxddmOdyZHcjzCoEJYu_YkkUZ=3aq_FZ4QfJNqdKJ_xO3A@mail.gmail.com>
 <1508871103.877228.1438354197061.JavaMail.zimbra@redhat.com>
 <CAFkUHxcyxHO-0OyB9-v+6TeHAXRPQVS+LFeP7K7ywvEw0g=b_A@mail.gmail.com>
 <1211289190.918749.1438362252889.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49443 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754671AbbGaU2f (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 31 Jul 2015 16:28:35 -0400
Content-Disposition: inline
In-Reply-To: <1211289190.918749.1438362252889.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: kernel neophyte <neophyte.hacker001@gmail.com>, vu@mellanox.com, raju kurunkad <raju.kurunkad@sandisk.com>, ceph-devel@vger.kernel.org

On Fri, Jul 31, 2015 at 01:04:12PM -0400, Matt Benjamin wrote:
> Hi Neo,
> 
> I'm not sure of the state of current WIP, but Marcus (CC'd) is coordinating atm
> from our end.  I'm sure we'd love help, so we'll check back in with updated branch
> info--maybe next week?
> 
> Matt

I have a branch that builds on what Sage did, but specifically intended
to fix the xio addressing problem.  I think I got most of the changes
necessary in; it builds, but doesn't run.  Besides fixing the "not running" problem
it will also need a bit more smarts so connections can based on connection
flavor pick the right address.  Ie, definitely "work in progress".
Also needs to be updated to the latest whatever.

I think it's already somewhere public, but not obvious.  If it's not, I'll
make sure it is.  I'll post information later today with where it is.
I'll also work to get it in the right place, but that make take a bit longer.
Finally, I'll also work on making it useable.

					-Marcus Watts
