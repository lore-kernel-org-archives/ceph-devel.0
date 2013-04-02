From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Trouble with paxos service for large PG count
Date: Tue, 2 Apr 2013 12:18:32 -0600
Message-ID: <515B20F8.5060203@sandia.gov>
References: <5159F899.4090001@sandia.gov> <515AFC5F.4000705@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:39178 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760629Ab3DBSSy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Apr 2013 14:18:54 -0400
In-Reply-To: <515AFC5F.4000705@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/02/2013 09:42 AM, Joao Eduardo Luis wrote:

> On 04/01/2013 10:14 PM, Jim Schutt wrote:
>> Hi,
>>
>> I've been having trouble starting a new file system
>> created using the current next branch (most recently,
>> commit 3b5f663f11).
>>
>> I believe the trouble is related to how long it takes paxos to
>> process a pgmap proposal.
>>
>> For a configuration with 1 mon, 1 mds, and 576 osds, using
>> pg_bits = 3 and debug paxos = 10, if I start just the monitor,
>> here's what I get when paxos processes the first non-trivial
>> pgmap proposal:
>>
> 
> Just noticed one other thing.  With 'debug paxos = 10', you should have a whole bunch of output (the proposal's dump) after this:
> 
>> 2013-04-01 14:04:16.330735 7ffff7fbe780 10 mon.cs31@0(leader).paxosservice(pgmap) propose_pending
>> 2013-04-01 14:04:16.358973 7ffff7fbe780  5 mon.cs31@0(leader).paxos(paxos active c 1..3) queue_proposal bl 4943990 bytes; ctx = 0x11e81f0
>> 2013-04-01 14:04:16.359021 7ffff7fbe780  5 mon.cs31@0(leader).paxos(paxos preparing update c 1..3) propose_queued 4 4943990 bytes
>> 2013-04-01 14:04:16.359025 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos preparing update c 1..3) propose_queued list_proposals 1 in queue:
> 
> and before this:
> 
>> 2013-04-01 14:04:28.096284 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos preparing update c 1..3) begin for 4 4943990 bytes
> 
> for every snippet you sent on your previous email.
> 
> The code responsible for that shouldn't ever have made into master, and should be to blame for a great deal of the time spent.
> 
> Jim, can you confirm such output is present?

Yep, here's what I see:

2013-04-01 14:04:16.359021 7ffff7fbe780  5 mon.cs31@0(leader).paxos(paxos preparing update c 1..3) propose_queued 4 4943990 bytes
2013-04-01 14:04:16.359025 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos preparing update c 1..3) propose_queued list_proposals 1 in queue:
-- entry #0
 proposed queued 0.000008 tx dump:
{ "ops": [
        { "op_num": 0,
          "type": "PUT",
          "prefix": "pgmap",
          "key": "full_1",
          "length": 46,
          "bl": "0000 : 05 04 28 00 00 00 01 00 00 00 00 00 00 00 00 00 : ..(.............\n0010 : 00 00 00 00 00 00 00 00 00 00 00 00 00 00 33 33 : ..............33\n0020 : 73 3f 9a 99 59 3f 40 e8 59 51 90 f0 a4 07       : s?..Y?@.YQ....\n"},
        { "op_num": 1,
          "type": "PUT",
          "prefix": "pgmap",
          "key": "full_latest",
          "length": 8,
          "bl": "0000 : 01 00 00 00 00 00 00 00                         : ........\n"},
        { "op_num": 2,
          "type": "PUT",
          "prefix": "pgmap",
          "key": "2",
          "length": 4943790,
          "bl": "0000 : 06 05 a8 6f 4b 00 02 00 00 00 00 00 00 00 18 36 : ...oK..........6

[snipped lots more of the bufferlist, then]

        { "op_num": 3,
          "type": "PUT",
          "prefix": "pgmap",
          "key": "last_committed",
          "length": 8,
          "bl": "0000 : 02 00 00 00 00 00 00 00                         : ........\n"}]}
2013-04-01 14:04:28.096284 7ffff7fbe780 10 mon.cs31@0(leader).paxos(paxos preparing update c 1..3) begin for 4 4943990 bytes

As you suggested, I see that sort of thing for every "propose_queued list_proposals" in my logs

-- Jim

> 
> 
>   -Joao
> 
> 


