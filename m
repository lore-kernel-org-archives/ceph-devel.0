From: Dan van der Ster <dan@vanderster.com>
Subject: Re: Object Write Latency
Date: Mon, 23 Sep 2013 09:37:20 +0200
Message-ID: <CABZ+qqnHf9NG5JirYNtT6LUEbzo52U43Arooo5-CNXR2SPPKaA@mail.gmail.com>
References: <3472A07E6605974CBC9BC573F1BC02E4A52724A9@PLOXCHG03.cern.ch> <CAPYLRziY9YVXp+zW8dS9+dN-r24AXXG84wx0ZgQFtpX2C1Pnfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:55951 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179Ab3IWHiD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Sep 2013 03:38:03 -0400
Received: by mail-bk0-f49.google.com with SMTP id r7so1019652bkg.22
        for <ceph-devel@vger.kernel.org>; Mon, 23 Sep 2013 00:38:01 -0700 (PDT)
Received: by mail-lb0-f173.google.com with SMTP id o14so2365876lbi.18
        for <ceph-devel@vger.kernel.org>; Mon, 23 Sep 2013 00:38:00 -0700 (PDT)
In-Reply-To: <CAPYLRziY9YVXp+zW8dS9+dN-r24AXXG84wx0ZgQFtpX2C1Pnfg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Sep 20, 2013 at 4:47 PM, Gregory Farnum <greg@inktank.com> wrote:
> On Fri, Sep 20, 2013 at 5:27 AM, Andreas Joachim Peters
> <Andreas.Joachim.Peters@cern.ch> wrote:
>> Hi,
>>
>>
>> we made some benchmarks about object read/write latencies on the CERN ceph installation.
>>
>> The cluster has 44 nodes and ~1k disks, all on 10GE and the pool configuration has 3 copies.
>> Client & Server is 0.67.
>>
>> The latencies we observe (using tiny objects ... 5 bytes) on the idle pool:
>
> Does that mean you have non-idle pools in the same cluster? Unless
> you've got physical separation, the fact that the pool is idle doesn't
> mean much unless the cluster is as well. (Though if you're getting 60
> object writes/hard drive/second I think it probably is idle.)

The cluster is pretty idle -- we'll separate with some new hardware to
exclude other usage from this test.


>
>> write full object(sync) ~65-80ms
>> append to object ~60-75ms
>> set xattr object ~65-80ms
>> lock object ~65-80ms
>> stat object ~1ms
>
> Anecdotally those write times look a little high to me, but my
> expectations are probably set for 2x and I'm not sure how much
> difference that makes (I would expect not much, but maybe there's
> something happening I haven't considered).
>
>
>> We seem to saturate the pools writing ~ 20k objects/s (= internally 60k/s).
>>
>> Is there an easy explanation for 80 ms (quasi without payload) and a possible tuning to reduce that?
>> I measured (append few bytes +fsync) on such a disk around 33ms which explains probably part of the latency.
> Ah, and that's also higher than I would normally expect for a disk
> access, so that's probably why the above numbers seem a little large.
> Separately, what's your journal config? Does each spindle have a
> partition? This math all works out to about what I'd expect if so.


The journals are on the same spinning disk & partition as the OSD
data. Each spinning disk is 1 OSD.

Cheers, Dan


>
>> Then I tried with the async API to see if there is a difference in the measurement between wait_for_complete or wait_for_safe ... shouldn't wait_for_complete be much shorter, but I get always comparable results ...
>
> You're presumably on xfs? With non-btrfs FSes, the OSDs have to use
> write-ahead journaling so they always commit the op to disk before
> applying to the local FS.
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
