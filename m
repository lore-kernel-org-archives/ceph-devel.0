From: Junwang Zhao <zhjwpku@gmail.com>
Subject: Re: msgr2 protocol
Date: Mon, 6 Jun 2016 16:23:12 +0800
Message-ID: <CAEG8a3KKtw122rY1kt3DMw_9y87ivK7FO1h0LbhoWn05mUD8Tg@mail.gmail.com>
References: <alpine.DEB.2.11.1605261358330.6221@cpach.fuggernut.com>
 <CAJ4mKGYxu1CKbusKp5Sn5269Q3PNuUWWRMQt1qUNR2SQQPjuFQ@mail.gmail.com>
 <alpine.DEB.2.11.1606021416510.6221@cpach.fuggernut.com> <CAJ4mKGaWx8m4Zh_f6tQWe9ows77HHyMmv5y52Rr-5Q-ob_N1Yg@mail.gmail.com>
 <alpine.DEB.2.11.1606030912000.6221@cpach.fuggernut.com> <CACJqLyZs9EdbnjSiazPzxD_R+yuwPT9BzDq-GmEyS55f_pYFdw@mail.gmail.com>
 <alpine.DEB.2.11.1606031333050.6221@cpach.fuggernut.com> <CACJqLya8rdipTW9hAikgyyDAWTFeTuqOizvDQSY88L_QnzeKFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:34486 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbcFFIXO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Jun 2016 04:23:14 -0400
Received: by mail-vk0-f52.google.com with SMTP id e4so53190301vkb.1
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jun 2016 01:23:13 -0700 (PDT)
In-Reply-To: <CACJqLya8rdipTW9hAikgyyDAWTFeTuqOizvDQSY88L_QnzeKFQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: Sage Weil <sweil@redhat.com>, Marcus Watts <mwatts@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

My understanding is that before the protocol msgr2 begins, each party
already has it's own secrete key, and it's public key has been known by
it's peer, and they have alreay shared the session key that will be used
by encryption/decryption.

The secrete key will be used by signature, and the public key will be
used to identify.

I am not sure about the whole key exchange part, is that done by cephx?


On Sat, Jun 4, 2016 at 1:35 AM, Haomai Wang <haomai@xsky.com> wrote:
> On Sat, Jun 4, 2016 at 1:33 AM, Sage Weil <sweil@redhat.com> wrote:
>> On Sat, 4 Jun 2016, Haomai Wang wrote:
>>> On Fri, Jun 3, 2016 at 9:24 PM, Sage Weil <sweil@redhat.com> wrote:
>>> > I updated the PR with an additional commit that simplifies the
>>> > confounder.  It seems like we only need the confoudner at teh beginning of
>>> > the session, not for every message, since the signature and encryption
>>> > state is chained from the previous frame.  Is that right?
>>> >
>>> >         https://github.com/ceph/ceph/pull/9461/commits/45766fed1864733c5216a7b50f11cce256338170
>>> >
>>> > Full PR:
>>> >
>>> >         https://github.com/ceph/ceph/pull/9461
>>> >
>>> > --
>>> >
>>> > Also, I just realized that now might be a good time to address the ability
>>> > to multiplex different endpoints (sessions) into the same connection.  We
>>> > could add it later with the msgr feature bits, but it'll probably be
>>> > simpler not to have to support two variants of the protocol.  On the other
>>> > hand, it's a lot more complicated.  :(
>>>
>>> What's the use case? different session shares the same connection? Do
>>> you mean different messenger instance will share the same connection
>>> pool?
>>
>> Many OSD's in the same unix process, sharing the same messenger connection
>> pool, eventually using SPDK/DPDK.
>
> OH, great to push this!
>
>>
>> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
