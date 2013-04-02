From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: Trouble with paxos service for large PG count
Date: Tue, 02 Apr 2013 16:42:23 +0100
Message-ID: <515AFC5F.4000705@inktank.com>
References: <5159F899.4090001@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f44.google.com ([74.125.83.44]:33071 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932588Ab3DBPtD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Apr 2013 11:49:03 -0400
Received: by mail-ee0-f44.google.com with SMTP id l10so312978eei.31
        for <ceph-devel@vger.kernel.org>; Tue, 02 Apr 2013 08:49:02 -0700 (PDT)
In-Reply-To: <5159F899.4090001@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/01/2013 10:14 PM, Jim Schutt wrote:
> Hi,
>
> I've been having trouble starting a new file system
> created using the current next branch (most recently,
> commit 3b5f663f11).
>
> I believe the trouble is related to how long it takes paxos to
> process a pgmap proposal.
>
> For a configuration with 1 mon, 1 mds, and 576 osds, using
> pg_bits = 3 and debug paxos = 10, if I start just the monitor,
> here's what I get when paxos processes the first non-trivial
> pgmap proposal:
>

Just noticed one other thing.  With 'debug paxos = 10', you should have 
a whole bunch of output (the proposal's dump) after this:

> 2013-04-01 14:04:16.330735 7ffff7fbe780 10 mon.cs31@0(leader).paxosservice(pgmap) propose_pending
> 2013-04-01 14:04:16.358973 7ffff7fbe780  5 mon.cs31@0(leader).paxos(paxos active c 1..3) queue_proposal bl 4943990 bytes; ctx = 0x11e81f0
> 2013-04-01 14:04:16.359021 7ffff7fbe780  5 mon.cs31@0(leader).paxos(paxos preparing update c 1..3) propose_queued 4 4943990 bytes
> 2013-04-01 14:04:16.359025 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos preparing update c 1..3) propose_queued list_proposals 1 in queue:

and before this:

> 2013-04-01 14:04:28.096284 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos preparing update c 1..3) begin for 4 4943990 bytes

for every snippet you sent on your previous email.

The code responsible for that shouldn't ever have made into master, and 
should be to blame for a great deal of the time spent.

Jim, can you confirm such output is present?


   -Joao
