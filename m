From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 1/4] libceph: don't bail early from try_read() when
 skipping a message
Date: Sat, 20 Feb 2016 12:28:10 -0600
Message-ID: <56C8B03A.3020602@ieee.org>
References: <1455986729-12544-1-git-send-email-idryomov@gmail.com>
 <1455986729-12544-2-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:33610 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbcBTS2N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 20 Feb 2016 13:28:13 -0500
Received: by mail-io0-f170.google.com with SMTP id z135so141218021iof.0
        for <ceph-devel@vger.kernel.org>; Sat, 20 Feb 2016 10:28:13 -0800 (PST)
In-Reply-To: <1455986729-12544-2-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc: Varada Kari <Varada.Kari@sandisk.com>

On 02/20/2016 10:45 AM, Ilya Dryomov wrote:
> The contract between try_read() and try_write() is that when called
> each processes as much data as possible.  When instructed by osd_client
> to skip a message, try_read() is violating this contract by returning
> after receiving and discarding a single message instead of checking for
> more.  try_write() then gets a chance to write out more requests,
> generating more replies/skips for try_read() to handle, forcing the
> messenger into a starvation loop.

This makes sense.  If (for example) two messages are pending
(either arriving or already arrived and buffered), and the
first is going to be discarded, we should still process the
second one to the extent possible.


I'm going to review the way this stuff works. (I always have
to do that anyway it seems, so I document it in the process...)


There are two places when read_partial_message() will decide
to discard a message.  One is if a completely valid message
header arrives, but the sequence number is wrong (this means
re-sent message has arrived).  The second place the messenger
discards an incoming message is if the connection's message
buffer allocation method indicates the message should be
skipped.  The MDS msg_alloc method never calls for a buffer
to be skipped.  But the mon client and the OSD client do.

The mon client and OSD client issue requests to their
servers which are expected to receive response messages.
When a mon or OSD request is set up, a buffer to hold its
corresponding response message is preallocated.  So when
receiving a message on a mon or OSD connection, the message
allocation function used by the messenger looks up and
returns that preallocated buffer.  If a response message
arrives from a mon server or OSD was not expected (i.e.,
no outstanding request is waiting for that response) the
incoming response message should be skipped.

Additionally, an OSD client expects to receive only a few
types of messages.  It peeks at an incoming message to
determine how it should be handled.  If an incoming message
is not of a type recognized by the OSD client, the message
should be skipped.  Even if an incoming message is an OSD
response that was expected, it is possible that the buffer
allocated to receive the response is too small for the
incoming message; and in that case the incoming message
should be skipped.

So...  There are two places in try_read_message() where
incoming messages should be discarded, and they represent:
receipt of a duplicate (re-sent) message; receipt of an
unexpected message type; receipt of a response message
that was not expected; or receipt of a response that was
too large for the buffer that had been allocated to hold it.


A stream of data coming in a connection consists of blocks
of data, each of which begins with a "tag" that indicates
what is contained within the block that follows. A
connection's "in_tag" indicates what we're expecting to
see next on input, and if it's READY it means we've
finished reading a previous block (and so the next
byte should be a tag).

If a connection should discard some incoming data, this is
represented by having its "in_base_pos" value be negative.
The value of "in_base_pos" in this case is negative the
number of bytes to be discarded.  Whenever a negative
value is recorded in "in_base_pos", the connection's
"in_tag" field is set to READY, indicating that immediately
following the discarded bytes is expected to be a tag.

When a connection is in OPEN state, the first thing
try_read() does is discard the incoming message data if
it is supposed to be skipped.  Once this is done, it looks
at "in_tag" to determine what to do next, and if it's READY
it sets "in_tag" to the next byte on input, and prepares
for receiving the block of data that follows accordingly.


OK, now coming back to the issue at hand.  In try_read(),
if the current "in_tag" is MSG, a message is expected on
input, and read_partial_message() is called.  If that
returns 0 (or negative), try_read() completes and returns
to its caller.  Otherwise, if the connection's "in_tag"
is READY, try_read() jumps back to the top again, to
continue reading the next block of data on the input.

Currently, if read_partial_message() ever finds that the
incoming message should be skipped, it indicates that
by setting the negated number of bytes to be skipped in
the connection's "in_base_pos" field, and setting its
"in_tag" to READY.  HOWEVER, read_partial_message()
currently returns 0 in this case, which causes its
caller, try_read(), to quit reading.


This fix changes the two places in read_partial_message()
that arrange to skip the current incoming message so they
return 1 rather than 0.  The result is that when control
returns to try_read(), it will return to its top.  That
will cause the incoming message to be discarded, *and*
will cause the next block of incoming data to be processed.

Without this change, try_write() will get called again
before try_read() gets a chance to discard the current
message and read the next one.


In other words...

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> Cc: stable@vger.kernel.org # 3.10+
> Reported-by: Varada Kari <Varada.Kari@sandisk.com>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> Tested-by: Varada Kari <Varada.Kari@sandisk.com>
> ---
>  net/ceph/messenger.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 9cfedf565f5b..fec20819a5ea 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -2337,7 +2337,7 @@ static int read_partial_message(struct ceph_connection *con)
>  		con->in_base_pos = -front_len - middle_len - data_len -
>  			sizeof(m->footer);
>  		con->in_tag = CEPH_MSGR_TAG_READY;
> -		return 0;
> +		return 1;
>  	} else if ((s64)seq - (s64)con->in_seq > 1) {
>  		pr_err("read_partial_message bad seq %lld expected %lld\n",
>  		       seq, con->in_seq + 1);
> @@ -2363,7 +2363,7 @@ static int read_partial_message(struct ceph_connection *con)
>  				sizeof(m->footer);
>  			con->in_tag = CEPH_MSGR_TAG_READY;
>  			con->in_seq++;
> -			return 0;
> +			return 1;
>  		}
>  
>  		BUG_ON(!con->in_msg);
> k

