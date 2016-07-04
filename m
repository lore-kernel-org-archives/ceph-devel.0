From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: mem leaks in Bluestore?
Date: Mon, 4 Jul 2016 16:11:34 +0300
Message-ID: <dc93d98c-0a6e-6a27-475d-04b0cf7b5cdc@mirantis.com>
References: <d75d6d88-3407-45a3-7495-44d4587aaa06@mirantis.com>
 <66c9974d-8cf8-2876-8dd5-7040aef4630c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33371 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416AbcGDNLo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jul 2016 09:11:44 -0400
Received: by mail-lf0-f50.google.com with SMTP id f6so116949995lfg.0
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jul 2016 06:11:43 -0700 (PDT)
In-Reply-To: <66c9974d-8cf8-2876-8dd5-7040aef4630c@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Mark,

I suspect that BlueStore's buffer cache holds the memory. Could you 
please try to set 'bluestore buffer cache size = 4194304' in your config 
file and check what's happening again.

And another question - how many pools do you have for your test case? In 
Bluestore each collection can allocate up to 512M for the buffer cache 
by default. Not sure if collection == pool but there is some correlation 
between them hence this might be the case.

Thanks,

Igor



On 30.06.2016 22:30, Mark Nelson wrote:
> Not sure how related this is, but for both reads and random reads I'm 
> seeing very large memory spikes (not necessarily leaks).  I've 
> included both the massif output and a screenshot from massif-visualizer.
>
> The spikes appear to be due to:
>
> bufferptr p = buffer::create_page_aligned(len)
>
> in KernelDevice::read on line ~477 in KernelDevice.cc.  Running via 
> massif slows things down enough that the node doesn't go out of memory 
> and the tests keep running, but if I attempt these tests without 
> massif, very quickly the OSD will spike to ~64GB of memory and then 
> get killed by the kernel.
>
> There were a number of recent commits that modified KernelDevice.cc as 
> well as buffer.cc:
>
> https://github.com/ceph/ceph/commits/master/src/os/bluestore/KernelDevice.cc 
>
> https://github.com/ceph/ceph/commits/master/src/common/buffer.cc
>
> Still looking through them for signs of what might be amiss.
>
> Mark
>
> On 06/27/2016 09:11 AM, Igor Fedotov wrote:
>> Hi All,
>>
>> let me share some observations I collected while running
>> ceph_test_objectstore against the bluestore.
>>
>> Initially I started this investigations due to a failure in
>> SyntheticMatrixCompressionAlgorithm test case. The issue appeared while
>> running the the whole test suite and had a pretty odd symptom: failed
>> test case was run with settings that aren't provided for it: compression
>> = none, compression algorithm = snappy. No attempts to run for zlib
>> despite the fact zlib is the first in the list. When running single test
>> case everything is OK.
>> Additional investigations led me to the fact that RAM at my VM decreases
>> almost to zero while running the test suite and that probably prevents
>> from setting desired config params. Hence I proceeded with mem leak
>> investigation.
>>
>> Since Synthetic test cases are pretty complex I switched to less complex
>> one - Many4KWriteNoCSumTest. As it performs writes only against the
>> single object this eliminates other ops, compression, csum, multiple
>> object handlings etc from under the suspicion.
>> Currently I can see ~6Gb mem consumption when doing ~3000 random writes
>> (up to 4K) over 4M object. Counting Bluestore's Buffer, Blob and Onode
>> objects shows that they aren't grow unexpectedly over the time for the
>> test case.
>> Then I changed the test case to perform fixed length(64K) writes - mem
>> consumption for 3000 writes reduced to 500M but I can see that Buffer
>> count is permanently growing - one buffer per single write. Thus
>> original issue is rather specific for small writes. But probably there
>> is another issue with buffer cache for big ones.
>> That's all what I have so far.
>>
>> Any comments/ideas are appreciated.
>>
>>
>> Thanks,
>> Igor
>>
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html

