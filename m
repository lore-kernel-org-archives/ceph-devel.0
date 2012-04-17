From: Sage Weil <sage@newdream.net>
Subject: Re: librados aio completion
Date: Mon, 16 Apr 2012 17:44:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204161736170.26253@cobra.newdream.net>
References: <Pine.LNX.4.64.1204152141160.14018@cobra.newdream.net>
 <CAC-hyiFiL=a6dRaE-UkJ-egj1hJTSWQD-6GUitcmRiXvNrEUEA@mail.gmail.com>
 <Pine.LNX.4.64.1204161157440.10153@cobra.newdream.net>
 <CAC-hyiEFKkohqWhYRgrc0zvbhrZeca=YCrW00JTSqe-0v5DEpQ@mail.gmail.com>
 <D763974EEA9A43E08946E03484894631@dreamhost.com>
 <Pine.LNX.4.64.1204161405580.31853@cobra.newdream.net>
 <59070F5B091941E0934A1175E82717B7@dreamhost.com>
 <CAC-hyiGhHr+Pqf2z53ONZsuUfr-RKUedWU-GyteB8hB8Zgzobw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45911 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755738Ab2DQAoz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Apr 2012 20:44:55 -0400
In-Reply-To: <CAC-hyiGhHr+Pqf2z53ONZsuUfr-RKUedWU-GyteB8hB8Zgzobw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Greg Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

On Mon, 16 Apr 2012, Yehuda Sadeh Weinraub wrote:
> wait_for_ack() : got ack or safe response, entails is_ack()
> wait_for_safe(): got safe response, entails is_safe(), is_ack()
> wait_for_complete(): done with the request, callback returned, entails
> is_complete(), is_safe(), is_ack()

The problem is we already have is_complete() and it means what you mean by 
is_ack().

Either:
1- add new is_complete_and_cb() and wait_for_complete_and_cb(), 
   is_safe_and_cb() and wait_for_safe_and_cb().
2- make existing is_complete() mean the above (and 
   is_safe()/wait_for_safe() mean is_safe_and_cb()).  is_complete() will 
   be false when called from the callback.  (i.e., current wip branch.)
3- is_complete() means is complete, but wait_for_complete() waits for 
   complete and cb.
4- status quo (user has no idea when cb has been called).

I like #1, personally.  I doubt there are current users using both the cb 
and wait_for_*() methods (aside from our functional tests).

sage
