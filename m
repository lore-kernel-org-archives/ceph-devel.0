From: Noah Watkins <noahwatkins@gmail.com>
Subject: Re: Questions about embedding Lua in the Ceph source tree
Date: Tue, 9 Aug 2016 18:50:52 -0700
Message-ID: <CAB2gnbXJ4BUhYs3+KxVNCUB9FfCwz_AchXWOMPdkn8VCTTyuNQ@mail.gmail.com>
References: <CAC-Np1wVKE5iaaMSOM_3HxwQiX6E1PoH8-RUBcctBVM-ghqMGA@mail.gmail.com>
 <CA+2bHPbrWe-GRSXnNoL639SvRBGahc=Le=k5Ww1byUjCmkoUMQ@mail.gmail.com>
 <CAB2gnbW3-PXaBJN4DiqwnuQ7MUSXpKTvxVUR7VaF4e3PS=tffw@mail.gmail.com> <CAB2gnbU_HMvmhX3ipgP3wdRzJOHgxv_xFnr=48je9KX065pYJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:34623 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932540AbcHJBuy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Aug 2016 21:50:54 -0400
Received: by mail-oi0-f43.google.com with SMTP id l203so41661697oib.1
        for <ceph-devel@vger.kernel.org>; Tue, 09 Aug 2016 18:50:53 -0700 (PDT)
In-Reply-To: <CAB2gnbU_HMvmhX3ipgP3wdRzJOHgxv_xFnr=48je9KX065pYJw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: Alfredo Deza <adeza@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

I've put up cls-lua-syslib branch that builds against the
distro-provided version of Lua. It's currently assuming Lua 5.1 which
is a choice on Ubuntu (along with 5.2), and appears to be only version
available on CentOS 7. My Fedora 24 box only has Lua 5.3. What are the
range of platforms that need support?

On Tue, Aug 9, 2016 at 6:50 PM, Noah Watkins <noahwatkins@gmail.com> wrote:
> I've put up cls-lua-syslib branch that builds against the distro-provided
> version of Lua. It's currently assuming Lua 5.1 which is a choice on Ubuntu
> (along with 5.2), and appears to be only version available on CentOS 7. My
> Fedora 24 box only has Lua 5.3. What are the range of platforms that need
> support?
>
> On Tue, Aug 9, 2016 at 3:17 PM Noah Watkins <noahwatkins@gmail.com> wrote:
>>
>> On Fri, Aug 5, 2016 at 11:49 AM, Patrick Donnelly <pdonnell@redhat.com>
>> wrote:
>> >
>> > We should definitely try to limit changes to Lua unless it's
>> > absolutely necessary. I haven't seen a good reason yet so I suggest
>> > using bare upstream so maintainers can use the system liblua if
>> > desired.
>>
>> We have put together versions of the Lua branch for system liblua,
>> embed (current approach), and LuaJIT and the deltas are very small.
>> I'll toss up a version that links against system liblua. IIRC we had a
>> motivation for compiling our own version, so that should reveal itself
>> if it really existed :)
>>
>> >
>> > --
>> > Patrick Donnelly
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
