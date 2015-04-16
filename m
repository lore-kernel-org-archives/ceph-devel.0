From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: leaking mons on a latest dumpling
Date: Thu, 16 Apr 2015 09:30:09 +0100
Message-ID: <552F7311.9000405@suse.de>
References: <CABYiri9j=bDPGu1KLTzvywt6shCnJ7AWbtywV8WoUtG8m1=_xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43082 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752330AbbDPIaJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 16 Apr 2015 04:30:09 -0400
In-Reply-To: <CABYiri9j=bDPGu1KLTzvywt6shCnJ7AWbtywV8WoUtG8m1=_xA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>, ceph-devel <ceph-devel@vger.kernel.org>

On 04/15/2015 05:38 PM, Andrey Korolyov wrote:
> Hello,
> 
> there is a slow leak which is presented in all ceph versions I assume
> but it is positively exposed only on large time spans and on large
> clusters. It looks like the lower is monitor placed in the quorum
> hierarchy, the higher the leak is:
> 
> 
> {"election_epoch":26,"quorum":[0,1,2,3,4],"quorum_names":["0","1","2","3","4"],"quorum_leader_name":"0","monmap":{"epoch":1,"fsid":"a2ec787e-3551-4a6f-aa24-deedbd8f8d01","modified":"2015-03-05
> 13:48:54.696784","created":"2015-03-05
> 13:48:54.696784","mons":[{"rank":0,"name":"0","addr":"10.0.1.91:6789\/0"},{"rank":1,"name":"1","addr":"10.0.1.92:6789\/0"},{"rank":2,"name":"2","addr":"10.0.1.93:6789\/0"},{"rank":3,"name":"3","addr":"10.0.1.94:6789\/0"},{"rank":4,"name":"4","addr":"10.0.1.95:6789\/0"}]}}
> 
> ceph heap stats -m 10.0.1.95:6789 | grep Actual
> MALLOC: =    427626648 (  407.8 MiB) Actual memory used (physical + swap)
> ceph heap stats -m 10.0.1.94:6789 | grep Actual
> MALLOC: =    289550488 (  276.1 MiB) Actual memory used (physical + swap)
> ceph heap stats -m 10.0.1.93:6789 | grep Actual
> MALLOC: =    230592664 (  219.9 MiB) Actual memory used (physical + swap)
> ceph heap stats -m 10.0.1.92:6789 | grep Actual
> MALLOC: =    253710488 (  242.0 MiB) Actual memory used (physical + swap)
> ceph heap stats -m 10.0.1.91:6789 | grep Actual
> MALLOC: =     97112216 (   92.6 MiB) Actual memory used (physical + swap)
> 
> for almost same uptime, the data difference is:
> rd KB 55365750505
> wr KB 82719722467
> 
> The leak itself is not very critical but of course requires some
> script work to restart monitors at least once per month on a 300Tb
> cluster to prevent >1G memory consumption by monitor processes. Given
> a current status for a dumpling, it would be probably possible to
> identify leak source and then forward-port fix to the newer releases,
> as the freshest version I am running on a large scale is a top of
> dumpling branch, otherwise it would require enormous amount of time to
> check fix proposals.

There have been numerous reports of a slow leak in the monitors on
dumpling and firefly.  I'm sure there's a ticket for that but I wasn't
able to find it.

Many hours were spent chasing down this leak to no avail, despite of
plugging several leaks throughout the code (especially in firefly, that
should have been backported to dumpling at some point or the other).

This was mostly hard to figure out because it tends to require a
long-term cluster to show up, and the biggest the cluster is the larger
the probability of triggering it.  This behavior has me believing that
this should be somewhere in the message dispatching workflow and, given
it's the leader that suffers the most, should be somewhere in the
read-write message dispatching (PaxosService::prepare_update()).  But
despite code inspections, I don't think we ever found the cause -- or
that any fixed leak was ever flagged as the root of the problem.

Anyway, since Giant, most complaints (if not all!) went away.  Maybe I
missed them, or maybe people suffering from this just stopped
complaining.  I'm hoping it's the first rather than the latter and, as
luck has it, maybe the fix was a fortunate side-effect of some other change.

  -Joao

