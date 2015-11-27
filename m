From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: What's the difference between Paxos::trim() and
 PaxosService::trim?
Date: Fri, 27 Nov 2015 11:20:08 +0000
Message-ID: <56583C68.6050801@suse.de>
References: <6F3FA899187F0043BA1827A69DA2F7CC03653DD1@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48304 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504AbbK0LUK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 27 Nov 2015 06:20:10 -0500
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC03653DD1@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Xiaoxi,

cc-ing ceph-devel for posterity ;)

On 11/27/2015 08:25 AM, Chen, Xiaoxi wrote:
> Hi joao,
> 
>         I am a bit confuse about  the difference between in
> Paxos::trim() and PaxosService::trim? Seems they did same work basically?

In essence, both have the same purpose: remove no longer needed versions
from the monitor store. They do, however, focus on different kinds of
versions.

The main difference is the way the Paxos class and PaxosService access
the store.

PaxosService provides an abstraction to services (e.g., OSDService) such
that each service, in a way, doesn't have to care much how their keys
are named. PaxosService handles this by suffixing each key with the
service's name (e.g., osdmap). Also, services tend to keep both
incremental and full versions, and the PaxosService class is also aware
of this.

Hence, PaxosService::trim() removes both incremental and full versions
when the service prescribes a trim, while making sure that only versions
related to that service are actually removed -- upon trim, the
OSDMonitor will not remove MonmapMonitor's versions.

On the other hand, Paxos::trim() deals solely with paxos versions.

One should also take into account that each service may have different
criteria on when to trim -- and PaxosService's abstraction takes that
into account -- while the Paxos class' criteria is pretty
straightforward: keep a minimum of N versions and a maximum of M.

Then you have PaxosService::maybe_trim(), where most of the logic on
deciding "when to trim" is located, even though ascertaining the bounds
are delegated to the services themselves. Again, given PaxosService is
an abstraction for the various services, you also get a bunch of logic
related to the nuances of removing versions from a paxos service, such
as allowing each service to trim additional stuff beyond the incremental
and full versions.

In the end, maybe we could find a generic function that could serve both
the Paxos class and PaxosServices, but these are both simple enough that
I don't think that is warranted. I have the feeling we would always end
up with at least one additional function (the generic one) and would
maintain most of the logic on both Paxos::trim() and
PaxosService::trim() in place anyway, and I don't think that's worth it.

Hope this helps clarifying things a bit.

  -Joao
