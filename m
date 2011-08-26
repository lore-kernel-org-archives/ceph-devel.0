From: Christian Brunner <chb@muc.de>
Subject: Re: [PATCH 2/2] rbd: add an option for md5 checksumming (v3)
Date: Fri, 26 Aug 2011 22:17:58 +0200
Message-ID: <CAO47_--hFDhbOhyyUXvc=KXDh5F1aLZS+8cdcZ9cf7xw=WjB8A@mail.gmail.com>
References: <20110826185117.GA19365@sir.fritz.box>
	<CAORUGqAJi+Erq9diLjkNhXmoeHY11H8O2+ugBBWaW=BJay72=A@mail.gmail.com>
	<CAC-hyiGPmbMYi0t5kswjSrUHsQWbvT1Z0oqfo+f=KJQunALU5A@mail.gmail.com>
	<CAORUGqCdmK0ZPUPspVVtak-gQ+o86TrmCX8sm6TRnA5WNWy3iA@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:38239 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566Ab1HZUR7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Aug 2011 16:17:59 -0400
Received: by vxi9 with SMTP id 9so2922064vxi.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Aug 2011 13:17:59 -0700 (PDT)
In-Reply-To: <CAORUGqCdmK0ZPUPspVVtak-gQ+o86TrmCX8sm6TRnA5WNWy3iA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, ceph-devel@vger.kernel.org

2011/8/26 Tommi Virtanen <tommi.virtanen@dreamhost.com>:
> On Fri, Aug 26, 2011 at 12:25, Yehuda Sadeh Weinraub <yehudasa@gmail.com> wrote:
>> On Fri, Aug 26, 2011 at 12:10 PM, Tommi Virtanen
>> <tommi.virtanen@dreamhost.com> wrote:
>>> e.g. 8kB at a time. And at that point you might as well just use read
>>> and not read_iterate, that'll do the memsetting etc for you, and then
>>> you can use a static buffer and avoid malloc/free every round. There's
>>> no shortcut to be had from "skipping" holes when you need to feed
>>> bytes to a hash function.
>>
>> Well, when using read_iterate you avoid reading extra data over the
>> network when the object (chunk) exists (and is sparse). We can
>> probably have some optimization here, and only allocate and memset a
>> buffer once for the case where len == objsize and reuse it later.
>
> Reading src/librbd.cc, I don't see the holes going over the wire in
> either case. read() is just a simple wrapper on top of read_iterate(),
> that memsets to 0 in case of a hole. Which in this case he was doing
> manually, so why not just use read() in the first place.

I think Yehuda meant that we could reuse the buffer to avoid the
malloc/memset for every hole.

But I think that the need for optimization in this case isn't really
that big and the code is simpler to read without having a global
buffer of zeros.

Christian
