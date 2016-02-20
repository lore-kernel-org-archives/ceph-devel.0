From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 1/4] libceph: don't bail early from try_read() when
 skipping a message
Date: Sat, 20 Feb 2016 14:38:47 -0600
Message-ID: <56C8CED6.7080701@ieee.org>
References: <1455986729-12544-1-git-send-email-idryomov@gmail.com>
 <1455986729-12544-2-git-send-email-idryomov@gmail.com>
 <56C8B03A.3020602@ieee.org>
 <CAOi1vP8V7Ni6G53Y-xhmuJihd=dmM6Fg6960CQZmLt451y5V5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:34608 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbcBTUit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 20 Feb 2016 15:38:49 -0500
Received: by mail-io0-f181.google.com with SMTP id 9so143053337iom.1
        for <ceph-devel@vger.kernel.org>; Sat, 20 Feb 2016 12:38:49 -0800 (PST)
In-Reply-To: <CAOi1vP8V7Ni6G53Y-xhmuJihd=dmM6Fg6960CQZmLt451y5V5A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Varada Kari <Varada.Kari@sandisk.com>

On 02/20/2016 02:21 PM, Ilya Dryomov wrote:
>> > So...  There are two places in try_read_message() where
>> > incoming messages should be discarded, and they represent:
>> > receipt of a duplicate (re-sent) message; receipt of an
>> > unexpected message type; receipt of a response message
>> > that was not expected; or receipt of a response that was
>> > too large for the buffer that had been allocated to hold it.
> Just a note: it's less about the preallocated buffer being too small
> part (in theory we could allocate everything in alloc_msg(), although
> that would be stupid) and more about the "no outstanding request is
> waiting for that response" part.  Stray and/or duplicate replies from
> the OSDs are expected in various cases.

Agreed.  That one case (buffer too large) is anomalous.  But
the code *does* say "skip the message" in that case, which
is why I mentioned it.

Like I said before, when it's been a while since I've reviewed
code I need to go immerse myself in it for a little while.  And
while I'm at it, I figure I might as well explain it all for the
benefit of other people.  This is especially true for these tiny
patches--sometimes the smaller the patch, the bigger the context
needed to understand why it fixes a problem.

					-Alex

