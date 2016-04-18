From: Milosz Tanski <milosz@adfin.com>
Subject: Re: Ann Arbor Team's Flexible I/O Proposals (Ceph Next)
Date: Mon, 18 Apr 2016 13:19:33 -0400
Message-ID: <CANP1eJHtmX55YYGX0N1w8DZe-faG86s7Q_cuMciUKt_Q=0Ei0A@mail.gmail.com>
References: <20160415210536.GA16458@ultraspiritum.redhat.com>
	<CANP1eJHFQXjkUogms3hqP=cqvt4GJZ62LMsmjp9d2JR+jf_j_g@mail.gmail.com>
	<20160415221233.GA6331@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35879 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbcDRRTf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2016 13:19:35 -0400
Received: by mail-lf0-f49.google.com with SMTP id g184so224996450lfb.3
        for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2016 10:19:35 -0700 (PDT)
In-Reply-To: <20160415221233.GA6331@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Fri, Apr 15, 2016 at 6:12 PM, Adam C. Emerson <aemerson@redhat.com> wrote:
> On 15/04/2016, Milosz Tanski wrote:
> [snip]
>> As librados is today, it encapsulates it's own networking and event
>> code. This is pretty frustrating to apps that already have their own
>> eventloop that want to integrate it.
>
> When you say integrating with an event loop, would being able to hand off a
> function or object to asynchronous calls that would then use whatever mechanism
> your event loop had for submitting events be sufficient?
>
> I'm not sure what you mean by networking in this case. Some means for the
> library to ask your client to set up or terminate a connection when it needs to
> talk to an OSD or monitor?

Sorry I wasn't explicit enough in the first round (eod friday).

Ideally the library would let you reentrant and let you hand off all
networking eg. opening, closing connections & read/write to your
chosen API. In my case I would hook it up to folly, but I can imagine
people would want to use their library of choice (libev / libevent /
boost::asio / whatever).

This can open possibilities like using DPDK sdk (via SeaStar) or
tighter integration with the qemu eventloop.


-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
