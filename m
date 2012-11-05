From: Jean-Daniel BUSSY <silversurfer972@gmail.com>
Subject: Re: Ceph journal
Date: Mon, 5 Nov 2012 22:06:48 +0900
Message-ID: <CANB=HGiRoGRpnnBMjb6XZvcmFxpRRra4XRcaavqbTeq_rk3dJQ@mail.gmail.com>
References: <CAJH6TXgdkq8ZMUpZYaTActMQ9wS76u7F=OUSvWnt9bS-crJwZQ@mail.gmail.com>
 <CANLRBoyLHrLP_hg6DSbESk=JhfHa5rzHiyLHcAotUokRe--xVA@mail.gmail.com>
 <CAJH6TXjGP5QqOWchRTwUQ-EigCU9qAORA87JrZ6bhG5J4im=-A@mail.gmail.com>
 <5091A06E.20407@kleijkers.nl> <CAJH6TXhwOxtT8XLWYMYiDQ=uFUtkv6CziR7vAFqSovZ_n1JORg@mail.gmail.com>
 <5092E93E.7060302@inktank.com> <CAJH6TXjp+eR1N7ZqAV6eZhLLDO58sx9cJVkqRYw7V43ZqBdBSA@mail.gmail.com>
 <CAPYLRzgV6jx9mf+EhYRm0RgUTc-v99Q39NTOMjHN=xte+c8G+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:40396 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445Ab2KENHK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Nov 2012 08:07:10 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so3955411wgb.1
        for <ceph-devel@vger.kernel.org>; Mon, 05 Nov 2012 05:07:09 -0800 (PST)
In-Reply-To: <CAPYLRzgV6jx9mf+EhYRm0RgUTc-v99Q39NTOMjHN=xte+c8G+A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>, "mark.nelson" <mark.nelson@inktank.com>, "gandalf.corvotempesta" <gandalf.corvotempesta@gmail.com>, =?UTF-8?Q?S=C3=A9bastien_Han?= <han.sebastien@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Interesting.
I am thinking about using tmpfs cached journal in production if the
behavior of the cluster is the same as described by Gregory Farnum.
If application experience long pauses as described by Mark Nelson then
it's quite critical.
I hope the journal in tmpfs really acts as a buffer and doesn't just
commit to disk aggressively to disk when full (I guess that what would
create long pauses).
During my testings with 10G of journal in tmpfs I have experienced
quite linear performances.
My concern is that performance is ~100Mb/s on writes while is should
be 200Mb/s isn't it?
Compared to journal on disk it's still a 2X performance overhaul
(~55Mb/s on disk)

I will run tests on a long run to see if I can reproduce pauses and
report back here.

-JD

BUSSY Jean-Daniel
Computer Engineer | CyberAgent
Mobile: +81 090-3317-1337
Email: silversurfer972@gmail.com
Mobile mail: jakku972@docomo.ne.jp


On Sun, Nov 4, 2012 at 2:29 AM, Gregory Farnum <greg@inktank.com> wrote:
> On Thu, Nov 1, 2012 at 10:33 PM, Gandalf Corvotempesta
> <gandalf.corvotempesta@gmail.com> wrote:
>> 2012/11/1 Mark Nelson <mark.nelson@inktank.com>:
>>> It will do that for a while, based on how you've tweaked the flush intervals
>>> and various journal settings to determine how much data ceph will allow to
>>> hang out in the journal while still accepting new requests.
>>
>> Ceph is not able to write to both journal and disks simultaneously?
>> For example, by using SSD for operating system and journal, we will be
>> able to have not least than 100GB of journal that is a large amount of
>> data wrote at SSD speed.
>>
>> When ceph has to flush this data to disks, will stop to write more
>> data to journal?
>
> No, of course it will flush data to the disk at the same time as it
> will take writes to the journal. However, if you have a 1GB journal
> that writes at 200MB/s and a backing disk that writes at 100MB/s, and
> you then push 200MB/s through long enough that the journal fills up,
> then you will slow down to writing at 100MB/s because that's as fast
> as Ceph can fill up the backing store, and the journal is no longer
> buffering.
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
