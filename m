From: Sage Weil <sweil@redhat.com>
Subject: Re: [ceph-users] autoconfigured haproxy service?
Date: Tue, 11 Jul 2017 20:35:34 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1707112031580.3424@piezo.novalocal>
References: <alpine.DEB.2.11.1707111458470.3424@piezo.novalocal> <1718355157.3684.1499801810149@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753958AbdGKUfg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 11 Jul 2017 16:35:36 -0400
In-Reply-To: <1718355157.3684.1499801810149@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel@vger.kernel.org, ceph-users@ceph.com

On Tue, 11 Jul 2017, Wido den Hollander wrote:
> > Op 11 juli 2017 om 17:03 schreef Sage Weil <sweil@redhat.com>:
> > 
> > 
> > Hi all,
> > 
> > Luminous features a new 'service map' that lets rgw's (and rgw nfs 
> > gateways and iscsi gateways and rbd mirror daemons and ...) advertise 
> > themselves to the cluster along with some metadata (like the addresses 
> > they are binding to and the services the provide).
> > 
> > It should be pretty straightforward to build a service that 
> > auto-configures haproxy based on this information so that you can deploy 
> > an rgw front-end that dynamically reconfigures itself when additional 
> > rgw's are deployed or removed.  haproxy has a facility to adjust its 
> > backend configuration at runtime[1].
> > 
> > Anybody interested in tackling this?  Setting up the load balancer in 
> > front of rgw is one of the more annoying pieces of getting ceph up and 
> > running in production and until now has been mostly treated as out of 
> > scope.  It would be awesome if there was an autoconfigured service that 
> > did it out of the box (and had all the right haproxy options set).
> > 
> 
> Are there easy Python bindings for this? I mean querying the service map.

Yes and no.  There are no special librados hooks (or python wrappers) to 
get the map, but you can issue a mon_command for 'service dump' and get it 
in JSON, which works just as well for python users.

> I'm personally a fan of running Varnish (with Hitch for SSL) in front of 
> RGW. Some people might also prefer Traefik [0] since that also supports 
> dynamic configs.

How would you go about autoconfiguring varnish via the rgw service map in 
this case?

sage
