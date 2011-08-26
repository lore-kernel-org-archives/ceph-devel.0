From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH 2/2] rbd: add an option for md5 checksumming (v3)
Date: Fri, 26 Aug 2011 13:19:06 -0700
Message-ID: <CAC-hyiFVymb1iw=jWyOytWoJZTjx7x+OwKqwhDg=kyPDB5asRg@mail.gmail.com>
References: <20110826185117.GA19365@sir.fritz.box>
	<CAORUGqAJi+Erq9diLjkNhXmoeHY11H8O2+ugBBWaW=BJay72=A@mail.gmail.com>
	<CAC-hyiGPmbMYi0t5kswjSrUHsQWbvT1Z0oqfo+f=KJQunALU5A@mail.gmail.com>
	<CAORUGqCdmK0ZPUPspVVtak-gQ+o86TrmCX8sm6TRnA5WNWy3iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40964 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566Ab1HZUTI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Aug 2011 16:19:08 -0400
Received: by bke11 with SMTP id 11so2807314bke.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Aug 2011 13:19:06 -0700 (PDT)
In-Reply-To: <CAORUGqCdmK0ZPUPspVVtak-gQ+o86TrmCX8sm6TRnA5WNWy3iA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Christian Brunner <chb@muc.de>, ceph-devel@vger.kernel.org

On Fri, Aug 26, 2011 at 1:03 PM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
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
>

Yeah, you're right.. the librbd::read() already does everything.
