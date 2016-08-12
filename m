From: John Spray <jspray@redhat.com>
Subject: Re: [ceph-users] cephfs performance benchmark -- metadata intensive
Date: Fri, 12 Aug 2016 11:03:02 +0100
Message-ID: <CALe9h7cDeh7tDbUQniJxQMCquT0tTCqdRT5zpoDCpMSP=e8FiQ@mail.gmail.com>
References: <CAEYCsVKksnVV+HeNBo4YofPz4Re1CRT3jCTCE2L12NqieMVYWA@mail.gmail.com>
 <CALe9h7fqrOCGn564HLPyMS6ouOHaY0phuZ64OHnq0Vx8VJWoug@mail.gmail.com> <CAMdDSN3gKZCV0+6nVC7ba_9KqvWQgMrGq1jPxm9EPws4Ls286Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:33017 "EHLO
	mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504AbcHLKDY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Aug 2016 06:03:24 -0400
Received: by mail-qt0-f182.google.com with SMTP id w38so10231624qtb.0
        for <ceph-devel@vger.kernel.org>; Fri, 12 Aug 2016 03:03:24 -0700 (PDT)
In-Reply-To: <CAMdDSN3gKZCV0+6nVC7ba_9KqvWQgMrGq1jPxm9EPws4Ls286Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brett Niver <bniver@redhat.com>
Cc: Xiaoxi Chen <superdebuger@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, james.liu@alibaba-inc.com, "Chen, Xiaoxi" <xiaoxchen@ebay.com>

On Thu, Aug 11, 2016 at 1:24 PM, Brett Niver <bniver@redhat.com> wrote:
> Patrick and I had a related question yesterday, are we able to dynamically
> vary cache size to artificially manipulate cache pressure?

Yes -- at the top of MDCache::trim the max size is read straight out
of g_conf so it should pick up on any changes you do with "tell
injectargs".  Things might be a little bit funny though because the
new cache limit wouldn't be reflected in the logic in lru_adjust().

John

> On Thu, Aug 11, 2016 at 6:07 AM, John Spray <jspray@redhat.com> wrote:
>>
>> On Thu, Aug 11, 2016 at 8:29 AM, Xiaoxi Chen <superdebuger@gmail.com>
>> wrote:
>> > Hi ,
>> >
>> >
>> >      Here is the slide I shared yesterday on performance meeting.
>> > Thanks and hoping for inputs.
>> >
>> >
>> >
>> > http://www.slideshare.net/XiaoxiChen3/cephfs-jewel-mds-performance-benchmark
>>
>> These are definitely useful results and I encourage everyone working
>> with cephfs to go and look at Xiaoxi's slides.
>>
>> The main thing that this highlighted for me was our lack of testing so
>> far on systems with full caches.  Too much of our existing testing is
>> done on freshly configured systems that never fill the MDS cache.
>>
>> Test 2.1 notes that we don't enable directory fragmentation by default
>> currently -- this is an issue, and I'm hoping we can switch it on by
>> default in Kraken (see thread "Switching on mds_bal_frag by default").
>> In the meantime we have the fix that Patrick wrote for Jewel which at
>> least prevents people creating dirfrags too large for the OSDs to
>> handle.
>>
>> Test 2.2: since a "failing to respond to cache pressure" bug is
>> affecting this, I would guess we see the performance fall off at about
>> the point where the *client* caches fill up (so they start trimming
>> things even though they're ignore cache pressure).  It would be
>> interesting to see this chart with addition lines for some related
>> perf counters like mds_log.evtrm and mds.inodes_expired, that might
>> make it pretty obvious where the MDS is entering different stages that
>> see a decrease in the rate of handling client requests.
>>
>> We really need to sort out the "failing to respond to cache pressure"
>> issues that keep popping up, especially if they're still happening on
>> a comparatively simple test that is just creating files.  We have a
>> specific test for this[1] that is currently being run against the fuse
>> client but not the kernel client[2].  This is a good time to try and
>> push that forward so I've kicked off an experimental run here:
>>
>> http://pulpito.ceph.com/jspray-2016-08-10_16:14:52-kcephfs:recovery-master-testing-basic-mira/
>>
>> In the meantime, although there are reports of similar issues with
>> newer kernels, it would be very useful to confirm if the same issue is
>> still occurring with more recent kernels.  Issues with cache trimming
>> have occurred due to various (separate) bugs, so it's possible that
>> while some people are still seeing cache trimming issues with recent
>> kernels, the specific case you're hitting might be fixed.
>>
>> Test 2.3: restarting the MDS doesn't actually give you a completely
>> empty cache (everything in the journal gets replayed to pre-populate
>> the cache on MDS startup).  However, the results are still valid
>> because you're using a different random order in the non-caching test
>> case, and the number of inodes in your journal is probably much
>> smaller than the overall cache size so it's only a little bit
>> populated.  We don't currently have a "drop cache" command built into
>> the MDS but it would be pretty easy to add one for use in testing
>> (basically just call mds->mdcache->trim(0)).
>>
>> As one would imagine, the non-caching case is latency-dominated when
>> the working set is larger than the cache, where each client is waiting
>> for one open to finish before proceeding to the next.  The MDS is
>> probably capable of handling many more operations per second, but it
>> would need more parallel IO operations from the clients.  When a
>> single client is doing opens one by one, you're potentially seeing a
>> full network+disk latency for each one (though in practice the OSD
>> read cache will be helping a lot here).  This non-caching case would
>> be the main argument for giving the metadata pool low latency (SSD)
>> storage.
>>
>> Test 2.5: The observation that the CPU bottleneck makes using fast
>> storage for the metadata pool less useful (in sequential/cached cases)
>> is valid, although it could still be useful to isolate the metadata
>> OSDs (probably SSDs since not so much capacity is needed) to avoid
>> competing with data operations.  For random access in the non-caching
>> cases (2.3, 2.4) I think you would probably see an improvement from
>> SSDs.
>>
>> Thanks again to the team from ebay for sharing all this.
>>
>> John
>>
>>
>>
>> 1.
>> https://github.com/ceph/ceph-qa-suite/blob/master/tasks/cephfs/test_client_limits.py#L96
>> 2. http://tracker.ceph.com/issues/9466
>>
>>
>> >
>> > Xiaoxi
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>
