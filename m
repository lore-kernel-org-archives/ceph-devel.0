From: Dong Yuan <yuandong1222@gmail.com>
Subject: Re: messenger refactor notes
Date: Mon, 11 Nov 2013 10:28:10 +0800
Message-ID: <CAMm-wcKLvTjT_Cf+E633L0366ynj_T35G7r7c6hGPkbU1i+X4w@mail.gmail.com>
References: <alpine.DEB.2.00.1311090052130.8192@cobra.newdream.net>
	<CA+4uBUZ_W2_-e+BgVMCGBa=3uz2d5sieGyrHwRqa7_wK5pvbWA@mail.gmail.com>
	<CAPYLRzjKKVU76Wfitd674_NzjTayMHf20ZY-K5Qc97w6WDWKnQ@mail.gmail.com>
	<CA+4uBUZYSkujS=+rUcJRwKyah97_Hm=GR7YJ7KG9x8LZDBTEUw@mail.gmail.com>
	<alpine.DEB.2.00.1311091407500.20233@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:40967 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008Ab3KKC2M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Nov 2013 21:28:12 -0500
Received: by mail-wi0-f170.google.com with SMTP id m19so1779050wiv.1
        for <ceph-devel@vger.kernel.org>; Sun, 10 Nov 2013 18:28:10 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1311091407500.20233@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Samuel Just <sam.just@inktank.com>, Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I am not sure I get all the details of the msg, But in my opinion, The msg
works as follows:

1. Every socket connection has two threads (read/write) in their pipes
2. All pipes put their received messages in the DispatchQueue
3. DispatchQueue has one dispatch thread to deliver or directly handle the
message.
4. Some role such as mds, the dispatch thread is the main work thread.

If I am wrong, please tell me, thanks.

Based on above points, I think the DispatchQueue is the key of the msg
performance. But there may be two problem with the DispatchQueue :

1. All pipes will put their message into the DispatchQueue,  so they all
want the lock of dispatch queue. while the lock is also wanted by dispatch
thread, so there may be a race of the lock of DispatchQueue.

2. There is only one dispatch thread, and sometimes this thread is very
busy to handle but not only dispatch the message, so the dispatch thread
may become the bottleneck of the whole process.

So I think the thread per socket model may need some changse, maybe other
models such as Leader/Follower model can give better performance.

Regards!

On 10 November 2013 06:10, Sage Weil <sage@inktank.com> wrote:
> On Sat, 9 Nov 2013, Samuel Just wrote:
>> Yeah, the Dispatcher, by allowing messages to go through the
>> fast_dispatch path, agrees to deal with the ordering consequences.  As
>> for 2), I'm trying to ensure that the ms_fast_dispatch call in the OSD
>> does not need any locks which would cause it to block for long.
>
> This all sounds good to me, as long as we keep in mind that the new
> threading model will likely be a handful of threads servicing connections,
> so blocking will be more expensive.  I assume that as long as the CPU is
> busy during fast_dispatch (and not waiting for locks), and as long as we
> can have multiple CPUs servicing connections with pending io, it should be
> a good situation all around.
>
> sage
>
>
>> -Sam
>>
>> On Sat, Nov 9, 2013 at 10:26 AM, Gregory Farnum <greg@inktank.com> wrote:
>> > On Sat, Nov 9, 2013 at 10:13 AM, Samuel Just <sam.just@inktank.com> wrote:
>> >> Currently, the messenger delivers messages to the Dispatcher
>> >> implementation from a single thread (See src/msg/DispatchQueue.h/cc).
>> >> My take away from the performance work so far is that we probably need
>> >> client IO related messages to bypass the DispatchQueue bottleneck by
>> >> allowing the thread reading the message to call directly into the
>> >> Dispatcher.  wip-queueing is a very preliminary branch implementing
>> >> this behavior for OSD ops and subops (note, this branch does not work
>> >> yet!).  The main change is to add to the Dispatcher interface
>> >> ms_can_fast_dispatch and ms_fast_dispatch.  This allows the dispatcher
>> >> implementation to designate some messages as safe to dispatch in
>> >> parallel without queueing.
>> >
>> > With this, the Messenger checks if it can dispatch earlier than normal
>> > (in the SimpleMessenger, within the Pipe threads) and does so if it's
>> > allowed. (I suddenly realize that we probably need to make that check
>> > required, not something the Messenger can choose to do or ignore,
>> > which is kind of a bummer.)
>> > There are two concerns with this:
>> > 1) if the Dispatcher lets through some messages but not others, the
>> > normal ordering constraints will be violated. It's the Dispatcher's
>> > responsibility to make sure that's not a problem (easy enough for the
>> > OSD; it can just sort by type).
>> > 2) (I didn't think about this one on Thursday, sorry Sam) If the fast
>> > dispatch loop takes longer than reading a message does, the Pipe might
>> > get backed up a little more than it normally would when it's just
>> > placing a message in the DispatchQueue. I don't think this should be a
>> > big problem since the OS is handling the sockets for us, but it might
>> > become a concern when we switch to many sockets per thread. The OSD
>> > should be okay though since the messages are just getting placed into
>> > PG queues.
>> > -Greg
>> > Software Engineer #42 @ http://inktank.com | http://ceph.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Dong Yuan
Email:yuandong1222@gmail.com
