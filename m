From: Gregory Farnum <greg@gregs42.com>
Subject: Re: rados bench throughput with no disk or network activity
Date: Thu, 28 May 2015 17:56:33 -0700
Message-ID: <CAC6JEv88Xt4gtYSSbKSPQ+vj5w7GqH3p2mdg3zCLD3X3b+pXGw@mail.gmail.com>
References: <BC97738F8E7C8742BABED7F06FB9DF9166995A9B@satlexdag04.amd.com>
	<CAC6JEv82uAz2kwZM9iRfkMSdtUx=AJ03ZBDW4v598sWE-7B53Q@mail.gmail.com>
	<BC97738F8E7C8742BABED7F06FB9DF9166995BA6@satlexdag04.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:33100 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755350AbbE2A4g convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 20:56:36 -0400
Received: by qcmi9 with SMTP id i9so21828749qcm.0
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2015 17:56:34 -0700 (PDT)
Received: from mail-qk0-f180.google.com (mail-qk0-f180.google.com. [209.85.220.180])
        by mx.google.com with ESMTPSA id 67sm1885940qhw.43.2015.05.28.17.56.33
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2015 17:56:34 -0700 (PDT)
Received: by qkoo18 with SMTP id o18so36661452qko.1
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2015 17:56:33 -0700 (PDT)
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF9166995BA6@satlexdag04.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, May 28, 2015 at 4:50 PM, Deneau, Tom <tom.deneau@amd.com> wrote=
:
>
>
>> -----Original Message-----
>> From: Gregory Farnum [mailto:greg@gregs42.com]
>> Sent: Thursday, May 28, 2015 6:18 PM
>> To: Deneau, Tom
>> Cc: ceph-devel
>> Subject: Re: rados bench throughput with no disk or network activity
>>
>> On Thu, May 28, 2015 at 4:09 PM, Deneau, Tom <tom.deneau@amd.com> wr=
ote:
>> > I've noticed that
>> >    * with a single node cluster with 4 osds
>> >    * and running rados bench rand on that same node so no network =
traffic
>> >    * with a number of objects small enough so that everything is i=
n
>> > the cache so no disk traffic
>> >
>> > we still peak out at about 1600 MB/sec.
>> >
>> > And the cpu is 40% idle. (and a good chunk of the cpu activity is =
the
>> > rados benchmark itself)
>> >
>> > What is likely causing the throttling here?
>>
>> Well, rados bench itself is essentially single-threaded, so if it's =
using
>> 100% CPU that's probably the bottleneck you're hitting.
>>
>> Otherwise, by default it will limit itself to 100MB of outstanding I=
O
>> (there's an objecter config value you can change for this; it's been
>> discussed recently) and that might not be enough given the latencies=
 of
>> hopping packets across different CPUs, and the OSDs have a slightly-
>> embarrassing amount of CPU computation and thread hopping they have =
to
>> perform on every op (around half a millisecond's worth on each read,=
 I
>> think?).
>> -Gerg
>
> Right.  I was involved in the objecter config discussion :) and
> I have set the limits higher.   And this 1600 MB/sec limit seems to b=
e
> the same whatever the size of the objects.
>
> rados bench is using about 30% of the cpu and the total cpu usage is =
about 60%
> (the rest being mostly from the 4 osds).
>
> Hmm, I just tried running 4 copies of rados bench rand, and I can get=
 a little bit
> higher combined totals, but not much higher maybe 1800 MB/sec.

You might also just be approaching the limits of your hardware's
effective memory bandwidth in a configuration like that =E2=80=94 that =
seems
low to me but between shuffling data back and forth on a bunch of
sockets and things adds up. I don't know if there's a good way to
measure that.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
