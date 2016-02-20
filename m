From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 1/4] libceph: don't bail early from try_read() when
 skipping a message
Date: Sat, 20 Feb 2016 21:21:12 +0100
Message-ID: <CAOi1vP8V7Ni6G53Y-xhmuJihd=dmM6Fg6960CQZmLt451y5V5A@mail.gmail.com>
References: <1455986729-12544-1-git-send-email-idryomov@gmail.com>
	<1455986729-12544-2-git-send-email-idryomov@gmail.com>
	<56C8B03A.3020602@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36632 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbcBTUVN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 20 Feb 2016 15:21:13 -0500
Received: by mail-wm0-f49.google.com with SMTP id g62so121297497wme.1
        for <ceph-devel@vger.kernel.org>; Sat, 20 Feb 2016 12:21:12 -0800 (PST)
In-Reply-To: <56C8B03A.3020602@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Varada Kari <Varada.Kari@sandisk.com>

On Sat, Feb 20, 2016 at 7:28 PM, Alex Elder <elder@ieee.org> wrote:
> On 02/20/2016 10:45 AM, Ilya Dryomov wrote:
>> The contract between try_read() and try_write() is that when called
>> each processes as much data as possible.  When instructed by osd_client
>> to skip a message, try_read() is violating this contract by returning
>> after receiving and discarding a single message instead of checking for
>> more.  try_write() then gets a chance to write out more requests,
>> generating more replies/skips for try_read() to handle, forcing the
>> messenger into a starvation loop.
>
> This makes sense.  If (for example) two messages are pending
> (either arriving or already arrived and buffered), and the
> first is going to be discarded, we should still process the
> second one to the extent possible.
>
>
> I'm going to review the way this stuff works. (I always have
> to do that anyway it seems, so I document it in the process...)
>
>
> There are two places when read_partial_message() will decide
> to discard a message.  One is if a completely valid message
> header arrives, but the sequence number is wrong (this means
> re-sent message has arrived).  The second place the messenger
> discards an incoming message is if the connection's message
> buffer allocation method indicates the message should be
> skipped.  The MDS msg_alloc method never calls for a buffer
> to be skipped.  But the mon client and the OSD client do.
>
> The mon client and OSD client issue requests to their
> servers which are expected to receive response messages.
> When a mon or OSD request is set up, a buffer to hold its
> corresponding response message is preallocated.  So when
> receiving a message on a mon or OSD connection, the message
> allocation function used by the messenger looks up and
> returns that preallocated buffer.  If a response message
> arrives from a mon server or OSD was not expected (i.e.,
> no outstanding request is waiting for that response) the
> incoming response message should be skipped.
>
> Additionally, an OSD client expects to receive only a few
> types of messages.  It peeks at an incoming message to
> determine how it should be handled.  If an incoming message
> is not of a type recognized by the OSD client, the message
> should be skipped.  Even if an incoming message is an OSD
> response that was expected, it is possible that the buffer
> allocated to receive the response is too small for the
> incoming message; and in that case the incoming message
> should be skipped.
>
>
> So...  There are two places in try_read_message() where
> incoming messages should be discarded, and they represent:
> receipt of a duplicate (re-sent) message; receipt of an
> unexpected message type; receipt of a response message
> that was not expected; or receipt of a response that was
> too large for the buffer that had been allocated to hold it.

Just a note: it's less about the preallocated buffer being too small
part (in theory we could allocate everything in alloc_msg(), although
that would be stupid) and more about the "no outstanding request is
waiting for that response" part.  Stray and/or duplicate replies from
the OSDs are expected in various cases.

>
>
> A stream of data coming in a connection consists of blocks
> of data, each of which begins with a "tag" that indicates
> what is contained within the block that follows. A
> connection's "in_tag" indicates what we're expecting to
> see next on input, and if it's READY it means we've
> finished reading a previous block (and so the next
> byte should be a tag).
>
> If a connection should discard some incoming data, this is
> represented by having its "in_base_pos" value be negative.
> The value of "in_base_pos" in this case is negative the
> number of bytes to be discarded.  Whenever a negative
> value is recorded in "in_base_pos", the connection's
> "in_tag" field is set to READY, indicating that immediately
> following the discarded bytes is expected to be a tag.
>
> When a connection is in OPEN state, the first thing
> try_read() does is discard the incoming message data if
> it is supposed to be skipped.  Once this is done, it looks
> at "in_tag" to determine what to do next, and if it's READY
> it sets "in_tag" to the next byte on input, and prepares
> for receiving the block of data that follows accordingly.
>
>
> OK, now coming back to the issue at hand.  In try_read(),
> if the current "in_tag" is MSG, a message is expected on
> input, and read_partial_message() is called.  If that
> returns 0 (or negative), try_read() completes and returns
> to its caller.  Otherwise, if the connection's "in_tag"
> is READY, try_read() jumps back to the top again, to
> continue reading the next block of data on the input.
>
> Currently, if read_partial_message() ever finds that the
> incoming message should be skipped, it indicates that
> by setting the negated number of bytes to be skipped in
> the connection's "in_base_pos" field, and setting its
> "in_tag" to READY.  HOWEVER, read_partial_message()
> currently returns 0 in this case, which causes its
> caller, try_read(), to quit reading.
>
>
> This fix changes the two places in read_partial_message()
> that arrange to skip the current incoming message so they
> return 1 rather than 0.  The result is that when control
> returns to try_read(), it will return to its top.  That
> will cause the incoming message to be discarded, *and*
> will cause the next block of incoming data to be processed.
>
> Without this change, try_write() will get called again
> before try_read() gets a chance to discard the current
> message and read the next one.
>
>
> In other words...
>
> Looks good.
>
> Reviewed-by: Alex Elder <elder@linaro.org>

Thanks for the review, Alex!  These walkthroughs of yours on the list
have been extremely helpful at times ;)

                Ilya
