From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 0/3] RFC: Enable clients to distinguish busy and unreachable
 OSDs
Date: Wed, 22 Jun 2011 13:31:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1106221316310.16816@cobra.newdream.net>
References: <1308767187-10376-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55409 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758042Ab1FVU3E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jun 2011 16:29:04 -0400
In-Reply-To: <1308767187-10376-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org

Hi Jim,

On Wed, 22 Jun 2011, Jim Schutt wrote:
> Previously, when clients' sustained offered write load exceeded the
> sustained throughput of the OSDs, normal operation was that client
> messages timed out while waiting to be processed by the OSDs.  The
> client response to this was to reset the connection to the OSD
> handling a timed-out message.
> 
> That has at least two types of impact:
>     
> - the reset frequently happens while data is being sent, so data
>   that was successfully received must be discarded and resent.
> 
> - after several such connection resets, many sockets can remain open,
>   waiting for readers to be granted space by the policy throttler,
>   so that they can notice that the pipe has been shut down, and the
>   socket can be closed.
> 
> This patchset causes Ceph OSDs to send keepalives when waiting for 
> sufficient buffer space to receive a message from a client. There is
> also a companion kernel client patch that causes clients to notice
> the keepalives, and not reset a connection serving a timed-out
> message if anything, particularly a keepalive, has been received
> recently.
> 
> This patchset also has the operational impact of eliminating client log
> messages about resetting OSDs under normal operation with a heavy write
> load, which makes it easier to notice other issues in the client logs.

This looks pretty good, with one exception: the keepalive needs to be 
somehow be specific to the message getting throttled in order for it to 
make sense.  Otherwise, we might

 - client sends request A, B
 - osd msgr receives A, starts processing, it hits a bug and hangs
 - osd msgr throttles on B, sends keepalives
 - client never times out A

Basically, the whole purpose of the timeout on the client side is to make 
noise and retry if the OSD is buggy or broken.  If we have a coarse 
never-timeout-anything-on-this-connection flag we may as well just turn 
the timeouts off (mount -o osdtimeout=0 I think).

The key for this to be useful is to only make the requests being throttled 
(and those that follow) avoid timing out.  I think we can accomplish that 
by looking at which messages were ACKed (as well as the new last_rcv)... 
going to start a branch and take a closer look!

sage


> 
> 
> Jim Schutt (3):
>   common/Throttle: Remove unused return type on Throttle::get()
>   common/Throttle: Add timed_wait().
>   msgr: Send keepalive periodically when waiting in policy throttler
> 
>  src/common/Throttle.h      |   45 +++++++++++++++++++++++++++++++++++++++++--
>  src/common/config.cc       |    1 +
>  src/common/config.h        |    1 +
>  src/msg/SimpleMessenger.cc |    6 ++++-
>  4 files changed, 49 insertions(+), 4 deletions(-)
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
