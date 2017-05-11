From: Sage Weil <sage@newdream.net>
Subject: Re: Mon identity in a dynamic environment
Date: Thu, 11 May 2017 15:26:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1705111521580.18953@piezo.novalocal>
References: <D538DFE2.8B37F%travis.nielsen@quantum.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34758 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756882AbdEKP0V (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 11 May 2017 11:26:21 -0400
In-Reply-To: <D538DFE2.8B37F%travis.nielsen@quantum.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Nielsen <Travis.Nielsen@Quantum.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Travis,

On Wed, 10 May 2017, Travis Nielsen wrote:
> How can we get monitors to work in an environment where their
> identity/endpoint might change? (Kubernetes). On the Rook team we have a
> few ideas on how to deal with this. What is your recommendation on which
> one of these we should pursue or if you have another recommendation
> altogether?
> 
> Background: Consider the following in Kubernetes:
> 
> * A monitor runs inside a pod, which has an unstable ip address. Whenever
> the pod restarts it might get a new ip address. This is not a frequent
> event, but it also must be an expected part of failure or maintenance
> * A stable endpoint can be created with a Kubernetes service, which is
> done by routing to the ip address of the pod. Now you have a stable
> address routing to the unstable address. You can hand out the service
> address and theoretically nobody should care there is an unstable address
> under the covers.
> 
> Solutions:
> 
> There are at least two approaches to this problem.
> 
> 1) Modify Ceph with the concept of an "advertise address" that is
> different from the "bind address". In other words, the ip address the
> monitor binds to locally is different than the ip address that is
> advertised to the monmap. Other monitors and clients would all connect to
> a mon with its advertise_addr, which would be routed to the the local
> bind_addr where the mon is actually listening. The monmap would be stable
> for a given set of mons even if they had a new bind_addr after restart.
> The main challenge with this is that it would be a non-trivial change for
> Ceph to support the advertise_addr.
> 
> This is a pattern followed in other systems such as etcd that support both
> a bind and advertise address.
> 
> Today the mons prohibit an advertised address from being different from
> the bind address with a check for the mon identity in a couple places such
> as this:
> https://github.com/ceph/ceph/blob/7f72100be553072d2b8fcf2699296fd2b23f2665/
> src/msg/async/AsyncConnection.cc#L980
> 
> In a prototype, I confirmed that disabling this error allowed the
> communication with monitors to be successful with a simulated
> advertise_addr. Essentially I generated config files with an advertised ip
> address, except that a mon would start with its own bind_addr in the
> config. The prototype has the shortcoming that the bind_addr is in the mon
> map, so there is still a problem as soon as the pod restarts. We still
> need the advertise_addr to be in the monmap, while the mon binds to a
> bind_addr.

I think this is the way to go, and I don't think it will be *that* 
involved.  Probably it just requires an option to supplement public_addr 
with bind_addr.  As long as the Messenger myaddr field is populated with 
the public_addr (and not bind_addr) field I suspect everything will Just 
Work.  Peers connecting to us will see the public_addr for their 
getpeeraddr config and that's the one that the messenger will advertise 
during its handshake; bind_addr would be used *only* by the actual bind 
call.  Does that seem reasonable?

> 2) Every time the mons get a new address, inject a new monmap to the
> changed monitors. This would require no changes in the Ceph codebase, but
> Rook would implement automation around the monmap injection. Rook would
> carefully track the health of the monitors. When a mon ip address changes,
> if quorum has been lost Rook would inject the new address to the monmap of
> each mon, and the monitors would come up again. This seems feasible, but
> it's also very difficult to get right.
> 
> This proposal is along a similar vein as #2 to move the same mon to a new
> endpoint, but it doesn't seem complete for the scenario.
> https://trello.com/c/mgmh0YGO/214-mon-ceph-mon-move

Yeah, this seems more fragile.  :)

sage
