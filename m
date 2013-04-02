From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Trouble with paxos service for large PG count
Date: Tue, 2 Apr 2013 14:36:56 -0600
Message-ID: <515B4168.2000402@sandia.gov>
References: <5159F899.4090001@sandia.gov> <515AFC5F.4000705@inktank.com>
 <515B20F8.5060203@sandia.gov>
 <CAGgG2xTdTOWvaPAK2FnxpzC1fsok50_HXXSgayEoD3J8SK6k3w@mail.gmail.com>
 <515B2E8C.5090001@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:53462 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756511Ab3DBUhW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Apr 2013 16:37:22 -0400
In-Reply-To: <515B2E8C.5090001@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Joao Luis <joao.luis@inktank.com>, ceph-devel@vger.kernel.org

On 04/02/2013 01:16 PM, Jim Schutt wrote:
> On 04/02/2013 12:28 PM, Joao Luis wrote:
>> Right.  I'll push a patch to bump that sort of output to 30 when I get home.
> 
> Thanks - but FWIW, I don't think it's the root cause of my
> issue -- more below....

OK, I see now that you're talking about the output from list_proposals().
Indeed, when I cause list_proposals() in propose_queued() to only
be called at paxos debug 30, the stall in finish_queued_proposal()
mostly goes away.  Now, with 55392 PGs I'm seeing this:

2013-04-02 14:21:19.401820 7ffff328d700 10 mon.cs31@0(leader).paxosservice(pgmap) propose_pending
2013-04-02 14:21:19.535731 7ffff328d700  5 mon.cs31@0(leader).paxos(paxos active c 1..33) queue_proposal bl 19870402 bytes; ctx = 0x11ecff0
2013-04-02 14:21:19.535917 7ffff328d700  5 mon.cs31@0(leader).paxos(paxos preparing update c 1..33) propose_queued 34 19870402 bytes
2013-04-02 14:21:19.535925 7ffff328d700 10 mon.cs31@0(leader).paxos(paxos preparing update c 1..33) begin for 34 19870402 bytes
2013-04-02 14:21:19.754326 7ffff328d700 10 mon.cs31@0(leader).paxos(paxos updating c 1..33) commit 34
2013-04-02 14:21:19.975747 7ffff328d700 10 mon.cs31@0(leader).paxos(paxos active c 1..34) finish_queued_proposal finishing proposal
2013-04-02 14:21:19.975799 7ffff328d700 10 mon.cs31@0(leader).paxos(paxos active c 1..34) finish_queued_proposal finish it (proposal = 0x790c0c0)
2013-04-02 14:21:19.975802 7ffff328d700 10 mon.cs31@0(leader).paxos(paxos active c 1..34) finish_queued_proposal proposal took 0.439887 to finish
2013-04-02 14:21:19.975913 7ffff328d700 10 mon.cs31@0(leader).paxosservice(pgmap) _active

>>
>> If you're willing, try reducing the paxos debug level to 0 and let us know
>> if those delays in the proposal go away.
> 
> When I started debugging why I couldn't start new filesystems, several
> days ago, I wasn't using any debugging.  It took me until last Friday
> to track the issue into paxos, which is when I turned on its debugging.
> 

With that list_proposals() debug output issue out of the way, I'm
still having trouble starting up a new filesystem -- still working
to try to isolate the source of the issue....

Thanks -- Jim


