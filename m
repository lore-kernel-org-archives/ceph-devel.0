From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Kernel RBD Readahead
Date: Tue, 25 Aug 2015 17:50:03 +0300
Message-ID: <CAOi1vP8rM6UTMOVm9fDXqjnyvmvAXpApW_LghV9ZS4vZVZBsxg@mail.gmail.com>
References: <3dc364a7.9Ro.9Gf.13.ic3ciX@mailjet.com>
	<CAOi1vP8Tvcdh8Xy+eJKJdoHWDO2=OmVXqfxH9KzoJQQE645Rww@mail.gmail.com>
	<590a725d.9Ro.9Gf.1M.icIth1@mailjet.com>
	<CAOi1vP9=47yYPpJVwSUnZmoK1jv81s_4TmoaxJ=MxMtQ3-7nXQ@mail.gmail.com>
	<CAOi1vP-zmOCAfWQVS2JknOX7QyKwHy8REeHkpKrAYcUJPwJ8Rw@mail.gmail.com>
	<bd4da65e.9Ro.9Gf.13.idFHtU@mailjet.com>
	<CAOi1vP-5bF6zCCaddvpF-TeMs66CLq6KtOL-_POJ6Ayxi-V6EA@mail.gmail.com>
	<b1744442.9Ro.9Gf.1X.idQDIl@mailjet.com>
	<CAOi1vP8V2wknnzS5Rx7reAaQiZk9XHOjRc7o2ZmVQWZyhbCWuQ@mail.gmail.com>
	<32c2ce0c.9Ro.9Gf.1Z.ieeVCT@mailjet.com>
	<CAOi1vP9Rrgn0RVAOdjrqHNRBHNZQXs4tpQ8jKDtz6R6ttqLsmA@mail.gmail.com>
	<cba722de.9Ro.9Gf.13.ieH9GN@mailjet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:34793 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbbHYOuF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Aug 2015 10:50:05 -0400
Received: by laba3 with SMTP id a3so100006619lab.1
        for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2015 07:50:03 -0700 (PDT)
In-Reply-To: <cba722de.9Ro.9Gf.13.ieH9GN@mailjet.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Fisk <nick@fisk.me.uk>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Aug 25, 2015 at 5:05 PM, Nick Fisk <nick@fisk.me.uk> wrote:
>> -----Original Message-----
>> From: Ilya Dryomov [mailto:idryomov@gmail.com]
>> Sent: 25 August 2015 09:45
>> To: Nick Fisk <nick@fisk.me.uk>
>> Cc: Ceph Development <ceph-devel@vger.kernel.org>
>> Subject: Re: Kernel RBD Readahead
>>
>> On Tue, Aug 25, 2015 at 10:40 AM, Nick Fisk <nick@fisk.me.uk> wrote:
>> > I have done two tests one with 1MB objects and another with 4MB ob=
jects,
>> my cluster is a little busier than when I did the quick test yesterd=
ay, so all
>> speeds are slightly down across the board but you can see the scalin=
g effect
>> nicely. Results:
>> >
>> > 1MB Order RBD
>> > Readahead       DD->Null Speed
>> > 128             18MB/s
>> > 1024            32MB/s
>> > 2048            40MB/s
>> > 4096            58MB/s
>> > 8192            75MB/s
>> > 16384           91MB/s
>> > 32768           160MB/s
>> >
>> > 4MB Order RBD
>> > 128             42MB/s
>> > 1024            56MB/s
>> > 2048            61MB/s
>> > 4096            98MB/s
>> > 8192            121MB/s
>> > 16384           170MB/s
>> > 32768           195MB/s
>> > 65536           221MB/s
>> > 131072          271MB/s
>> >
>> > I think the results confirm my suspicions, where a full stripe in =
a raid array
>> will usually only be a couple of MB (eg 256kb chunk * 8 disks) and s=
o a
>> relatively small readahead will involve all the disks for max perfor=
mance. In a
>> Ceph RBD a full stripe will be 4MB * number of OSD's in the cluster.=
 So I think
>> that if sequential read performance is the only goal, then readahead
>> probably needs to equal that figure, which could be massive. But in =
reality
>> like me you will probably find that  you get sufficient performance =
at a lower
>> value. Of course all this theory could all change when the kernel cl=
ient gets
>> striping support.
>> >
>> > However in terms of a default, that=E2=80=99s a tricky one. Even s=
etting it to 4096
>> would probably start to have a negative impact on pure random IO lat=
ency.
>> Each read would make a OSD read a whole 4MB object, see small table =
below
>> for IOP/Read size for disks in my cluster. I would imagine somewhere
>> between 256-1024 would be a good trade off between where the OSD dis=
ks
>> latency starts to rise. Users would need to be aware of their worklo=
ad and
>> tweak readahead if needed.
>> >
>> >                         IOPs
>> > (4k Random Read)        83
>> > (64k Random Read)       81
>> > (256k Random Read)      73
>> > (1M Random Read)        52
>> > (4M Random Read)        25
>>
>> Yeah, we want a sensible default, but it's always going to be a trad=
e off.
>> librbd has readahead knobs, but the only real use case there is shor=
tening
>> qemu boot times, so we can't copy those settings.  I'll have to thin=
k about it
>> some more - it might make more sense to leave things as is.  Users w=
ith large
>> sequential read workloads should know to check and adjust readahead
>> settings, and likely won't be satisfied with 1x object size anyway.
>
> Ok. I might try and create a 4.1 kernel with the blk-mq queue depth/I=
O size + readahead +max_segments fixes in as I'm think the TCP_NODELAY =
bug will still be present in my old 3.14 kernel.

I can build 4.2-rc8 + readahead patch on gitbuilders for you.

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
