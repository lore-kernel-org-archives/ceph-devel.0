From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH] rbd: add queuing delay
Date: Tue, 22 Jun 2010 14:03:59 -0700
Message-ID: <AANLkTilzf9GqS4Nqyz02IH59Wyb28gy5ojgxDU78CWsK@mail.gmail.com>
References: <AANLkTikMSExF8V783S_wOsfCK7mRQT24g5SV4qaYUlrv@mail.gmail.com>
	<20100622202705.GA17975@chb-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44104 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705Ab0FVWL6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jun 2010 18:11:58 -0400
Received: by vws9 with SMTP id 9so1485239vws.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jun 2010 15:11:57 -0700 (PDT)
In-Reply-To: <20100622202705.GA17975@chb-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

On Tue, Jun 22, 2010 at 1:27 PM, Christian Brunner <chb@muc.de> wrote:
> On Tue, Jun 22, 2010 at 09:50:24PM +0200, Christian Brunner wrote:
>> > while running tests with qemu-io I've been experiencing a lot of
>> > messages when running a large writev request (several hundred MB i=
n
>> > a single call):
>> >
>> > 10.06.20 22:10:07.337108 b67dcb70 client4136.objecter =A0pg 3.437e=
 on [0] is laggy: 33
>> > 10.06.20 22:10:07.337708 b67dcb70 client4136.objecter =A0pg 3.2553=
 on [0] is laggy: 19
>> > [...]
>> >
>> > Everything is working fine, though. I think that the large number =
of
>> > queued requests is the cause for this behaviour and I would propos=
e to
>> > delay futher requests (see attached patch).
>> >
>> > What do you think about it?
>>
>> It seems that the osd is lagging behind. The usleep might work for y=
ou
>> as you avoid the pressure, but it's also somewhat random and will
>> probably hurt performance on other setups. I'd rather see a
>> configurable solution that lets you specify a total in-flight bytes =
or
>> some other resizable window scheme.
>
> I'm not sure if I understand what "lagging behind" means. If the in-f=
light
> bytes are the sum of all requests in the queue, a solution could look=
 like
> this (although it isn't configurable yet).
>
The problem is that the sleep will lead to having the osd being
underutilized in certain configurations. What you probably need here
is some mechanism that keeps feeding the osd with pending data
whenever old data has been cleared. E.g., make use of the async
callbacks to wake up the sender whenever the amount of pending
outgoing data has fell below some threshold.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
