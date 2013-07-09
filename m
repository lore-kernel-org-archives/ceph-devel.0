From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: assertion failure in update_from_paxos
Date: Tue, 09 Jul 2013 20:47:54 +0100
Message-ID: <51DC68EA.3020705@inktank.com>
References: <CA+Hcz5_EeKy=stHHKUvL4QkpGT8KsMc7dpr7KAppwBcDAMjLug@mail.gmail.com> <51DC67F7.6050607@inktank.com> <CA+Hcz5-QbboUXYsNU7jXe0Z8Lr6f5rTM=OCMJrm4ya9SchcYVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:55149 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab3GITrr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jul 2013 15:47:47 -0400
Received: by mail-we0-f172.google.com with SMTP id q56so5184803wes.3
        for <ceph-devel@vger.kernel.org>; Tue, 09 Jul 2013 12:47:46 -0700 (PDT)
In-Reply-To: <CA+Hcz5-QbboUXYsNU7jXe0Z8Lr6f5rTM=OCMJrm4ya9SchcYVA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 07/09/2013 08:45 PM, Noah Watkins wrote:
> It appears to be resolved in master now.

Yep!

   -Joao

>
> On Tue, Jul 9, 2013 at 12:43 PM, Joao Eduardo Luis
> <joao.luis@inktank.com> wrote:
>> On 07/09/2013 04:37 PM, Noah Watkins wrote:
>>>
>>> I'm getting the following failure when running a vstart instance with
>>> 1 of each daemon.
>>
>>
>> I can confirm this happens, as it just happened to me as well.
>>
>> My guess is that this is something Sage may have fixed last night, but will
>> have to check.
>>
>>    -Joao
>>
>>>
>>> --
>>>
>>> 0> 2013-07-09 08:30:43.213345 7fdc289e97c0 -1 mon/OSDMonitor.cc: In
>>> function 'virtual void OSDMonitor::update_from_paxos(bool*)' thread
>>> 7fdc289e97c0 time 2013-07-09 08:30:43.207686
>>> mon/OSDMonitor.cc: 129: FAILED assert(latest_bl.length() != 0)
>>>
>>>    ceph version 0.65-307-g0e93dd9
>>> (0e93dd93e5439fb82c416cb8eec7f36598ae7b48)
>>>    1: (OSDMonitor::update_from_paxos(bool*)+0x16bd) [0x5ad5ed]
>>>    2: (PaxosService::refresh(bool*)+0x143) [0x592963]
>>>    3: (Monitor::refresh_from_paxos(bool*)+0x57) [0x536c87]
>>>    4: (Paxos::finish_proposal()+0x3a) [0x58c13a]
>>>    5: (Paxos::begin(ceph::buffer::list&)+0x82c) [0x58bbac]
>>>    6: (Paxos::propose_queued()+0xd9) [0x58be79]
>>>    7: (Paxos::propose_new_value(ceph::buffer::list&, Context*)+0x140)
>>> [0x58d230]
>>>    8: (PaxosService::propose_pending()+0x6c8) [0x593c28]
>>>    9: (PaxosService::_active()+0x58b) [0x5956fb]
>>>    10: (PaxosService::election_finished()+0x328) [0x595c38]
>>>    11: (Monitor::win_election(unsigned int, std::set<int,
>>> std::less<int>, std::allocator<int> >&, unsigned long)+0x2e5)
>>> [0x55ae05]
>>>    12: (Monitor::win_standalone_election()+0x197) [0x55b027]
>>>    13: (Monitor::bootstrap()+0x84b) [0x55b8fb]
>>>    14: (Monitor::init()+0xad) [0x55bbcd]
>>>    15: (main()+0x1ac7) [0x5296b7]
>>>    16: (__libc_start_main()+0xf5) [0x3f2dc21b75]
>>>    17: ./ceph-mon() [0x52e259]
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
>> --
>> Joao Eduardo Luis
>> Software Engineer | http://inktank.com | http://ceph.com


-- 
Joao Eduardo Luis
Software Engineer | http://inktank.com | http://ceph.com
