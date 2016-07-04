From: Mark Nelson <mnelson@redhat.com>
Subject: Re: mem leaks in Bluestore?
Date: Mon, 4 Jul 2016 18:38:02 -0500
Message-ID: <5713cf38-76fc-aea3-3091-254c7cfa3828@redhat.com>
References: <d75d6d88-3407-45a3-7495-44d4587aaa06@mirantis.com>
 <66c9974d-8cf8-2876-8dd5-7040aef4630c@redhat.com>
 <dc93d98c-0a6e-6a27-475d-04b0cf7b5cdc@mirantis.com>
 <alpine.DEB.2.11.1607041314180.31395@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57440 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752246AbcGDXiG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 4 Jul 2016 19:38:06 -0400
In-Reply-To: <alpine.DEB.2.11.1607041314180.31395@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Igor Fedotov <ifedotov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Yep, this was due to the lack of trim in the read path.  We are now 
spiking up to around 2.7GB RSS per OSD but holding steady and not 
exceeding that under normal operation.  I did notice that under valgrind 
we can spike higher.  I wonder if perhaps trim isn't keeping up under 
the strain when massif is used.

I'm now fighting segfaults during random writes on master.  I was able 
to reproduce it with logs and got a core dump but still need to look 
through the code to figure out why it's happening.

Mark

On 07/04/2016 08:15 AM, Sage Weil wrote:
> I think this was fixed by adding a call to trim the cache in the read
> path.  Previously it was only happening on writes.
>
> On Mon, 4 Jul 2016, Igor Fedotov wrote:
>> Hi Mark,
>>
>> I suspect that BlueStore's buffer cache holds the memory. Could you please try
>> to set 'bluestore buffer cache size = 4194304' in your config file and check
>> what's happening again.
>>
>> And another question - how many pools do you have for your test case? In
>> Bluestore each collection can allocate up to 512M for the buffer cache by
>> default. Not sure if collection == pool but there is some correlation between
>> them hence this might be the case.
>
> This could cause a problem if we got nothing but requests that touch 2
> collections and the important one was always second.  In the OSD's case,
> though, we generally touch the PG collection first, so I don't think this
> will be a problem.
>
> sage
>
>>
>> Thanks,
>>
>> Igor
>>
>>
>>
>> On 30.06.2016 22:30, Mark Nelson wrote:
>>> Not sure how related this is, but for both reads and random reads I'm seeing
>>> very large memory spikes (not necessarily leaks).  I've included both the
>>> massif output and a screenshot from massif-visualizer.
>>>
>>> The spikes appear to be due to:
>>>
>>> bufferptr p = buffer::create_page_aligned(len)
>>>
>>> in KernelDevice::read on line ~477 in KernelDevice.cc.  Running via massif
>>> slows things down enough that the node doesn't go out of memory and the
>>> tests keep running, but if I attempt these tests without massif, very
>>> quickly the OSD will spike to ~64GB of memory and then get killed by the
>>> kernel.
>>>
>>> There were a number of recent commits that modified KernelDevice.cc as well
>>> as buffer.cc:
>>>
>>> https://github.com/ceph/ceph/commits/master/src/os/bluestore/KernelDevice.cc
>>> https://github.com/ceph/ceph/commits/master/src/common/buffer.cc
>>>
>>> Still looking through them for signs of what might be amiss.
>>>
>>> Mark
>>>
>>> On 06/27/2016 09:11 AM, Igor Fedotov wrote:
>>>> Hi All,
>>>>
>>>> let me share some observations I collected while running
>>>> ceph_test_objectstore against the bluestore.
>>>>
>>>> Initially I started this investigations due to a failure in
>>>> SyntheticMatrixCompressionAlgorithm test case. The issue appeared while
>>>> running the the whole test suite and had a pretty odd symptom: failed
>>>> test case was run with settings that aren't provided for it: compression
>>>> = none, compression algorithm = snappy. No attempts to run for zlib
>>>> despite the fact zlib is the first in the list. When running single test
>>>> case everything is OK.
>>>> Additional investigations led me to the fact that RAM at my VM decreases
>>>> almost to zero while running the test suite and that probably prevents
>>>> from setting desired config params. Hence I proceeded with mem leak
>>>> investigation.
>>>>
>>>> Since Synthetic test cases are pretty complex I switched to less complex
>>>> one - Many4KWriteNoCSumTest. As it performs writes only against the
>>>> single object this eliminates other ops, compression, csum, multiple
>>>> object handlings etc from under the suspicion.
>>>> Currently I can see ~6Gb mem consumption when doing ~3000 random writes
>>>> (up to 4K) over 4M object. Counting Bluestore's Buffer, Blob and Onode
>>>> objects shows that they aren't grow unexpectedly over the time for the
>>>> test case.
>>>> Then I changed the test case to perform fixed length(64K) writes - mem
>>>> consumption for 3000 writes reduced to 500M but I can see that Buffer
>>>> count is permanently growing - one buffer per single write. Thus
>>>> original issue is rather specific for small writes. But probably there
>>>> is another issue with buffer cache for big ones.
>>>> That's all what I have so far.
>>>>
>>>> Any comments/ideas are appreciated.
>>>>
>>>>
>>>> Thanks,
>>>> Igor
>>>>
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
