From: Sage Weil <sage@newdream.net>
Subject: Re: autoconfigured haproxy service?
Date: Tue, 11 Jul 2017 15:11:14 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1707111507220.3424@piezo.novalocal>
References: <alpine.DEB.2.11.1707111458470.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48692 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754931AbdGKPLR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Jul 2017 11:11:17 -0400
In-Reply-To: <alpine.DEB.2.11.1707111458470.3424@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ceph-users@ceph.com

On Tue, 11 Jul 2017, Sage Weil wrote:
> Hi all,
> 
> Luminous features a new 'service map' that lets rgw's (and rgw nfs 
> gateways and iscsi gateways and rbd mirror daemons and ...) advertise 
> themselves to the cluster along with some metadata (like the addresses 
> they are binding to and the services the provide).
> 
> It should be pretty straightforward to build a service that 
> auto-configures haproxy based on this information so that you can deploy 
> an rgw front-end that dynamically reconfigures itself when additional 
> rgw's are deployed or removed.  haproxy has a facility to adjust its 
> backend configuration at runtime[1].
> 
> Anybody interested in tackling this?  Setting up the load balancer in 
> front of rgw is one of the more annoying pieces of getting ceph up and 
> running in production and until now has been mostly treated as out of 
> scope.  It would be awesome if there was an autoconfigured service that 
> did it out of the box (and had all the right haproxy options set).

[1] https://stackoverflow.com/questions/42678269/haproxy-dynamic-configuration
