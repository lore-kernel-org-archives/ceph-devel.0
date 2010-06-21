From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH] rbd: add queuing delay
Date: Mon, 21 Jun 2010 16:52:35 -0700
Message-ID: <AANLkTikMSExF8V783S_wOsfCK7mRQT24g5SV4qaYUlrv@mail.gmail.com>
References: <20100620204426.GA7139@chb-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57914 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908Ab0FUXwh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Jun 2010 19:52:37 -0400
Received: by vws9 with SMTP id 9so126999vws.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 Jun 2010 16:52:36 -0700 (PDT)
In-Reply-To: <20100620204426.GA7139@chb-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

On Sun, Jun 20, 2010 at 1:44 PM, Christian Brunner <chb@muc.de> wrote:
> Hi Yehuda,
>
> while running tests with qemu-io I've been experiencing a lot of
> messages when running a large writev request (several hundred MB in
> a single call):
>
> 10.06.20 22:10:07.337108 b67dcb70 client4136.objecter =A0pg 3.437e on=
 [0] is laggy: 33
> 10.06.20 22:10:07.337708 b67dcb70 client4136.objecter =A0pg 3.2553 on=
 [0] is laggy: 19
> [...]
>
> Everything is working fine, though. I think that the large number of
> queued requests is the cause for this behaviour and I would propose t=
o
> delay futher requests (see attached patch).
>
> What do you think about it?

It seems that the osd is lagging behind. The usleep might work for you
as you avoid the pressure, but it's also somewhat random and will
probably hurt performance on other setups. I'd rather see a
configurable solution that lets you specify a total in-flight bytes or
some other resizable window scheme.

>
> Another question: I there a way to figure out max_osd through librado=
s?

Not currently.

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
