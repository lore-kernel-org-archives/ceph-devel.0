From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: msgr2 protocol
Date: Mon, 6 Jun 2016 13:16:26 -0700
Message-ID: <CAJ4mKGbyCiWbuwGxhGu_ohf7vxNqVqgf4XQQpQ7eg-tP-YO+gg@mail.gmail.com>
References: <alpine.DEB.2.11.1605261358330.6221@cpach.fuggernut.com>
	<CAJ4mKGYxu1CKbusKp5Sn5269Q3PNuUWWRMQt1qUNR2SQQPjuFQ@mail.gmail.com>
	<alpine.DEB.2.11.1606021416510.6221@cpach.fuggernut.com>
	<CAJ4mKGaWx8m4Zh_f6tQWe9ows77HHyMmv5y52Rr-5Q-ob_N1Yg@mail.gmail.com>
	<alpine.DEB.2.11.1606030912000.6221@cpach.fuggernut.com>
	<CACJqLyZs9EdbnjSiazPzxD_R+yuwPT9BzDq-GmEyS55f_pYFdw@mail.gmail.com>
	<alpine.DEB.2.11.1606031333050.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:36211 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbcFFUQ2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Jun 2016 16:16:28 -0400
Received: by mail-vk0-f41.google.com with SMTP id c66so61455321vkb.3
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jun 2016 13:16:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606031333050.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Haomai Wang <haomai@xsky.com>, Marcus Watts <mwatts@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jun 3, 2016 at 10:33 AM, Sage Weil <sweil@redhat.com> wrote:
> On Sat, 4 Jun 2016, Haomai Wang wrote:
>> On Fri, Jun 3, 2016 at 9:24 PM, Sage Weil <sweil@redhat.com> wrote:
>> > I updated the PR with an additional commit that simplifies the
>> > confounder.  It seems like we only need the confoudner at teh beginning of
>> > the session, not for every message, since the signature and encryption
>> > state is chained from the previous frame.  Is that right?
>> >
>> >         https://github.com/ceph/ceph/pull/9461/commits/45766fed1864733c5216a7b50f11cce256338170
>> >
>> > Full PR:
>> >
>> >         https://github.com/ceph/ceph/pull/9461
>> >
>> > --
>> >
>> > Also, I just realized that now might be a good time to address the ability
>> > to multiplex different endpoints (sessions) into the same connection.  We
>> > could add it later with the msgr feature bits, but it'll probably be
>> > simpler not to have to support two variants of the protocol.  On the other
>> > hand, it's a lot more complicated.  :(
>>
>> What's the use case? different session shares the same connection? Do
>> you mean different messenger instance will share the same connection
>> pool?
>
> Many OSD's in the same unix process, sharing the same messenger connection
> pool, eventually using SPDK/DPDK.

Oof, yes, if we want to make that happen it should be in this design phase.

So, what features do we want/need to include here? Is it just the
ability to send messages which represent different entities on a tag
basis? Full streams with their own encryption settings?
Do we want to do interleaving on some block size, or do
messages/streams on a full frame basis?

I've thought about these some and am mixed-to-clueless on these, but
we need some targets.
-Greg

>
> sage
