From: Dan van der Ster <dan@vanderster.com>
Subject: Re: Object Write Latency
Date: Mon, 23 Sep 2013 09:39:34 +0200
Message-ID: <CABZ+qqnXbycX4C_brF4eiRVb0PeA4SKf2kW_d3g8RYxwD6xFDg@mail.gmail.com>
References: <3472A07E6605974CBC9BC573F1BC02E4A52724A9@PLOXCHG03.cern.ch> <alpine.DEB.2.00.1309200830040.25752@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:41020 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558Ab3IWHkR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Sep 2013 03:40:17 -0400
Received: by mail-bk0-f49.google.com with SMTP id r7so1001402bkg.36
        for <ceph-devel@vger.kernel.org>; Mon, 23 Sep 2013 00:40:16 -0700 (PDT)
Received: by mail-la0-f41.google.com with SMTP id ec20so2270722lab.0
        for <ceph-devel@vger.kernel.org>; Mon, 23 Sep 2013 00:40:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1309200830040.25752@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Sep 20, 2013 at 5:34 PM, Sage Weil <sage@inktank.com> wrote:
> On Fri, 20 Sep 2013, Andreas Joachim Peters wrote:
>> Hi,
>>
>>
>> we made some benchmarks about object read/write latencies on the CERN ceph installation.
>>
>> The cluster has 44 nodes and ~1k disks, all on 10GE and the pool configuration has 3 copies.
>> Client & Server is 0.67.
>>
>> The latencies we observe (using tiny objects ... 5 bytes) on the idle pool:
>>
>> write full object(sync) ~65-80ms
>> append to object ~60-75ms
>> set xattr object ~65-80ms
>> lock object ~65-80ms
>> stat object ~1ms
>
> How are the individual OSDs configured?  Are they purely HDD's with a
> journal partition, or is there an SSD journal?  If it's pure HDD, this
> will be a signnificant source of latency.

No SSD journal, same HDD for journal and partition. It still seems
large to have >45ms for 1 copy though, no?


>
> That said, Dieter just recently pointed out to me that he's observing
> significant time in a request turnaround (single request, 1 request in
> flight) that is not be related to the storage backend.  I've been
> traveling this week and haven't had time to look into it yet.  Tracking
> this down should just be a matter of turning up the logs and looking
> carefully at the timestamps to see where things are being delayed.

Which logs.. debug_ms or debug_osd or both or something else?


>
>> We seem to saturate the pools writing ~ 20k objects/s (= internally 60k/s).
>>
>> Is there an easy explanation for 80 ms (quasi without payload) and a possible tuning to reduce that?
>> I measured (append few bytes +fsync) on such a disk around 33ms which explains probably part of the latency.
>>
>> Then I tried with the async API to see if there is a difference in the
>> measurement between wait_for_complete or wait_for_safe ... shouldn't
>> wait_for_complete be much shorter, but I get always comparable results
>> ...
>
> If you are using XFS or ext4 on teh backend, the OSD is doing write-ahead
> journaling, which means that in reality the commit happens before the op
> is applied to the fs and is readable.  (The 'commit/ondisk' reply implies
> an ack so the OSD has some internal locking to maintain this illusion from
> the client's perspective.)

It's XFS.

Cheers, Dan


>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
