From: Samuel Just <sam.just@inktank.com>
Subject: Re: messenger refactor notes
Date: Sat, 9 Nov 2013 10:37:04 -0800
Message-ID: <CA+4uBUZYSkujS=+rUcJRwKyah97_Hm=GR7YJ7KG9x8LZDBTEUw@mail.gmail.com>
References: <alpine.DEB.2.00.1311090052130.8192@cobra.newdream.net>
	<CA+4uBUZ_W2_-e+BgVMCGBa=3uz2d5sieGyrHwRqa7_wK5pvbWA@mail.gmail.com>
	<CAPYLRzjKKVU76Wfitd674_NzjTayMHf20ZY-K5Qc97w6WDWKnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:64375 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756290Ab3KIShI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Nov 2013 13:37:08 -0500
Received: by mail-qc0-f178.google.com with SMTP id x19so2888313qcw.23
        for <ceph-devel@vger.kernel.org>; Sat, 09 Nov 2013 10:37:04 -0800 (PST)
In-Reply-To: <CAPYLRzjKKVU76Wfitd674_NzjTayMHf20ZY-K5Qc97w6WDWKnQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yeah, the Dispatcher, by allowing messages to go through the
fast_dispatch path, agrees to deal with the ordering consequences.  As
for 2), I'm trying to ensure that the ms_fast_dispatch call in the OSD
does not need any locks which would cause it to block for long.
-Sam

On Sat, Nov 9, 2013 at 10:26 AM, Gregory Farnum <greg@inktank.com> wrote:
> On Sat, Nov 9, 2013 at 10:13 AM, Samuel Just <sam.just@inktank.com> wrote:
>> Currently, the messenger delivers messages to the Dispatcher
>> implementation from a single thread (See src/msg/DispatchQueue.h/cc).
>> My take away from the performance work so far is that we probably need
>> client IO related messages to bypass the DispatchQueue bottleneck by
>> allowing the thread reading the message to call directly into the
>> Dispatcher.  wip-queueing is a very preliminary branch implementing
>> this behavior for OSD ops and subops (note, this branch does not work
>> yet!).  The main change is to add to the Dispatcher interface
>> ms_can_fast_dispatch and ms_fast_dispatch.  This allows the dispatcher
>> implementation to designate some messages as safe to dispatch in
>> parallel without queueing.
>
> With this, the Messenger checks if it can dispatch earlier than normal
> (in the SimpleMessenger, within the Pipe threads) and does so if it's
> allowed. (I suddenly realize that we probably need to make that check
> required, not something the Messenger can choose to do or ignore,
> which is kind of a bummer.)
> There are two concerns with this:
> 1) if the Dispatcher lets through some messages but not others, the
> normal ordering constraints will be violated. It's the Dispatcher's
> responsibility to make sure that's not a problem (easy enough for the
> OSD; it can just sort by type).
> 2) (I didn't think about this one on Thursday, sorry Sam) If the fast
> dispatch loop takes longer than reading a message does, the Pipe might
> get backed up a little more than it normally would when it's just
> placing a message in the DispatchQueue. I don't think this should be a
> big problem since the OS is handling the sockets for us, but it might
> become a concern when we switch to many sockets per thread. The OSD
> should be okay though since the messages are just getting placed into
> PG queues.
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
