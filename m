From: huang jun <hjwsm1989@gmail.com>
Subject: Re: scrub loadavg too high
Date: Thu, 7 Jul 2011 08:36:09 +0800
Message-ID: <CABAwU-aZMr5FO0h=sizfpEXyNLas4XS7H1EHPLSyUbcLgvj2iQ@mail.gmail.com>
References: <CABAwU-aaJE10=ZtbkXn-OyEmMpO3Nz8BvpS=x39mSr6y0JZQyQ@mail.gmail.com>
	<CAORUGqBVzN2dYdBcPJ8s9qMfYW5GQeLROmwKe2KHRpT9xz4z9w@mail.gmail.com>
	<CABAwU-Yf_oUvKbtbbnDiRB-cXQbOVh+RepAT2XkEjOsErqiauA@mail.gmail.com>
	<CAORUGqAFXOrbRQE5DOUnfr0oVks4VEkVX318LbQkSUNWLkCOLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53154 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755569Ab1GGAgL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jul 2011 20:36:11 -0400
Received: by wyg8 with SMTP id 8so309385wyg.19
        for <ceph-devel@vger.kernel.org>; Wed, 06 Jul 2011 17:36:10 -0700 (PDT)
In-Reply-To: <CAORUGqAFXOrbRQE5DOUnfr0oVks4VEkVX318LbQkSUNWLkCOLw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

thank you Tommi
we know we should use journal if we want keep  data integrity, but it r=
eally
influence the performance even we use btrfs as osd low-level fs, not
fs for journal.
in the debug log, find that :
    journal prepare_single_write 1 will write 3649536 : seq 445 len
4195462 -> 4202496    (head 40 pre_pad 3895 ebl 4195462 post_pad 3059
tail 40) (ebl alignment 3935)

it will generate 4195462 bytes journal of writing  4MB data from client=
=2E
that means we will write 8MB when it actually write 4MB data,
so what advices you can give if we want to lower the overhead of journa=
l?

best regards!

2011/7/7 Tommi Virtanen <tommi.virtanen@dreamhost.com>:
> [Re-added ceph-devel to Cc, it got dropped accidentally.]
>
> 2011/7/5 huang jun <hjwsm1989@gmail.com>
>>
>> thanks=A3=ACTommi
>> now, we have solved this problem, but another occurs.
>> if use osd_journal, the performance goes down heavily.
>> we use rados to bench write performance.
>>  rados -p data bench 30 write
>> use osd journal on ext3 :
>> Total time run:        32.213428
>> Total writes made:     216
>> Write size:            4194304
>> Bandwidth (MB/sec):    26.821
>>
>> Average Latency:       2.32526
>> Max latency:           3.6743
>> Min latency:           0.105108
>>
>> and not use osd journal:
>>  Total time run:        31.057457
>> Total writes made:     452
>> Write size:            4194304
>> Bandwidth (MB/sec):    58.215
>>
>> Average Latency:       1.07141
>> Max latency:           1.23193
>> Min latency:           0.927193
>>
>> i can not figure out what slow down the write procedure,
>> so can you give some direction/tips to find it out.
>
> Journal mode means you end up doing twice as many writes (once in the
> journal, once in the final location). The writes to the journal will =
be
> streaming writes, the writes to the final locations are most likely s=
eeking
> around the disk. In average use, the journal can consume a burst of w=
rites,
> and then do the final location writes at a more idle time. When your =
write
> burst exceeds the size of the journal, you end up bottlenecked by the
> writes, but now you have the writes to the journal in addition. The
> abilities of different disk systems to handle this kind of writing va=
ries a
> lot.
> Note that you need the journal for data integrity purposes, either wa=
y.
> We are not yet focused on this kind of performance tuning, but it's h=
ighly
> likely you will get better performance with btrfs. On btrfs, we can u=
se the
> internals of the filesystem to do the journaling for us.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
