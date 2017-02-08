From: Sage Weil <sage@newdream.net>
Subject: Re: switch "ms bind ipv6" default to "true"?
Date: Wed, 8 Feb 2017 18:44:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702081842420.7782@piezo.novalocal>
References: <CALqRxCxqUP6V0enicL4EM=aeH1Qt5G0vvmcrqQrmAa9TirpLoQ@mail.gmail.com> <1330200336.9468.1486571050945@ox.pcextreme.nl> <alpine.DEB.2.11.1702081658100.7782@piezo.novalocal> <o7foak$rob$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54852 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbdBHSoo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Feb 2017 13:44:44 -0500
In-Reply-To: <o7foak$rob$1@blaine.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Daniel Swarbrick <daniel.swarbrick@profitbricks.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 8 Feb 2017, Daniel Swarbrick wrote:
> On 08/02/17 17:59, Sage Weil wrote:
> > On Wed, 8 Feb 2017, Wido den Hollander wrote:
> >>
> >> Isn't it possible that this causes troubles when explicitly setting 
> >> public and/or cluster network?
> > 
> > Yeah.  But I think even more importantly, it assumes that the host is 
> > using ipv6, which it might not be.  Currently the messenger *either* uses 
> > ipv4 or ipv6, but it can't do both.
> 
> Assuming that the cluster / public network has not been explicitly set,
> can't we bind in such a way that it will accept either, i.e., bind an
> IPv6 socket and setsockopt IPV6_V6ONLY = 0?
> 
> Most network daemons these days seem to be moving towards that trend. We
> would just need to check for non-IPv6 capable IP stacks (seriously...?)
> before the bind, in which case it's a moot point anyway.

It's not just the binding part; all ceph daemons advertise their address 
to the rest of the system, and that address is either v4 or v6.  Only half 
of the infrastructure to advertise multiple addrs is in place; the 
AsyncMessenger still needs to be updated so that it will bind to both and 
then also advertise both.

sage
