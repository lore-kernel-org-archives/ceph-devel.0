From: Gregory Farnum <greg@gregs42.com>
Subject: Re: crc error when decode_message?
Date: Tue, 17 Mar 2015 06:58:13 -0700
Message-ID: <CAC6JEv_TzKg1-n1pkVgxXk5oEmMnj__a4xdK2Ag2xxrqadvVLA@mail.gmail.com>
References: <CANE=7sWQaG8PZYEU9OsjkmU6GB6jKhcnSG1cm6o38EeMb65pGw@mail.gmail.com>
	<CANE=7sXX9mFuuFGJE7edXdE2q7pt+teOjXkCgb5aWjToAYM1MA@mail.gmail.com>
	<CACJqLybJus0ijP+xB7OorE7sAkhn8DWb7MPTJAMxSOVRL1mR4g@mail.gmail.com>
	<CANE=7sWuRcWhNx9VFBDp5csKed06a2ZDXbd1am2G+6Ua=wFC4w@mail.gmail.com>
	<CACJqLyZ50EkaLwSv2yEDuNq0Yj+=Og+x5gK01ao-woN1UqZPjw@mail.gmail.com>
	<CALZt5jyiiM2NcurGLSVYYkNn+bPuwhWX8+zb0bBndKQ92p2KNg@mail.gmail.com>
	<alpine.DEB.2.00.1503170643410.7043@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:33353 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916AbbCQN63 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Mar 2015 09:58:29 -0400
Received: by iecvj10 with SMTP id vj10so11124034iec.0
        for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2015 06:58:28 -0700 (PDT)
Received: from mail-ig0-f180.google.com (mail-ig0-f180.google.com. [209.85.213.180])
        by mx.google.com with ESMTPSA id b17sm5980335iob.31.2015.03.17.06.58.28
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2015 06:58:28 -0700 (PDT)
Received: by igbue6 with SMTP id ue6so53368182igb.1
        for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2015 06:58:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1503170643410.7043@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ning Yao <zay11022@gmail.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, Xinze Chi <xmdxcxz@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Mar 17, 2015 at 6:46 AM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 17 Mar 2015, Ning Yao wrote:
>> 2015-03-16 22:06 GMT+08:00 Haomai Wang <haomaiwang@gmail.com>:
>> > On Mon, Mar 16, 2015 at 10:04 PM, Xinze Chi <xmdxcxz@gmail.com> wrote:
>> >> How to process the write request in primary?
>> >>
>> >> Thanks.
>> >>
>> >> 2015-03-16 22:01 GMT+08:00 Haomai Wang <haomaiwang@gmail.com>:
>> >>> AFAR Pipe and AsyncConnection both will mark self fault and shutdown
>> >>> socket and peer will detect this reset. So each side has chance to
>> >>> rebuild the session.
>> >>>
>> >>> On Mon, Mar 16, 2015 at 9:19 PM, Xinze Chi <xmdxcxz@gmail.com> wrote:
>> >>>> Such as, Client send write request to osd.0 (primary), osd.0 send
>> >>>> MOSDSubOp to osd.1 and osd.2
>> >>>>
>> >>>> osd.1 send reply to osd.0 (primary), but accident happened:
>> >>>>
>> >>>> 1. decode_message crc error when decode reply msg
>> >>>> or
>> >>>> 2. the reply msg is lost when send to osd.0, so osd.0 do not receive replay msg
>> >>>>
>> >>>> Could anyone tell me what is the behavior if osd.0 (primary)?
>> >>>>
>> >
>> > osd.0 and osd.1 both will try to reconnect peer side, and the lost
>> > message will be resend to osd.0 from osd.1
>> So I wonder if different routing path delays the arrival of one
>> message, then the in_seq would be setting ahead, then based on the
>> logic. Later, if the delaying message arrives, it will be dropping and
>> discard. Thus, if it is just a sub_op reply message as xinze
>> describes, how ceph works after that? It seems repop of the write Op
>> will be waiting infinite times until the osd restart?
>
> These sorts of scenarios are why src/msg/simple/Pipe.cc (an in particular,
> accept()) is not so simple.  The case you describe is
>
>  https://github.com/ceph/ceph/blob/master/src/msg/simple/Pipe.cc#L492
> or
>  https://github.com/ceph/ceph/blob/master/src/msg/simple/Pipe.cc#L492
>
> In other words, this is all masked by the Messenger layer so that the
> higher layers (OSD.cc etc) see a single, ordered, reliable stream of
> messages and all of the failure/retry/reconnect logic is hidden.

Just to be clear, that's the original described case of reconnecting.
The different routing paths stuff are all handled by TCP underneath
us, which is one of the reasons we use it. ;)
-Greg
