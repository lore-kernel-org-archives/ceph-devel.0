From: Sage Weil <sage@newdream.net>
Subject: Re: librados aio completion
Date: Mon, 16 Apr 2012 14:07:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204161405580.31853@cobra.newdream.net>
References: <Pine.LNX.4.64.1204152141160.14018@cobra.newdream.net>
 <CAC-hyiFiL=a6dRaE-UkJ-egj1hJTSWQD-6GUitcmRiXvNrEUEA@mail.gmail.com>
 <Pine.LNX.4.64.1204161157440.10153@cobra.newdream.net>
 <CAC-hyiEFKkohqWhYRgrc0zvbhrZeca=YCrW00JTSqe-0v5DEpQ@mail.gmail.com>
 <D763974EEA9A43E08946E03484894631@dreamhost.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58359 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705Ab2DPVHx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Apr 2012 17:07:53 -0400
In-Reply-To: <D763974EEA9A43E08946E03484894631@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <gregory.farnum@dreamhost.com>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, ceph-devel@vger.kernel.org

On Mon, 16 Apr 2012, Greg Farnum wrote:
> On Monday, April 16, 2012 at 12:37 PM, Yehuda Sadeh Weinraub wrote:
> > On Mon, Apr 16, 2012 at 12:00 PM, Sage Weil <sage@newdream.net (mailto:sage@newdream.net)> wrote:
> > > 
> > > I pushed a wip-2301 that does this. The downside to this approach is that
> > > the is_safe() and is_complete() methods will return false until after the
> > > callback returns, which includes the callback itself. So a callback that
> > > assumes that is_complete() will return true will be wrong.
> > > 
> > > If that's not okay, the alternative is to make the wait_for_complete()
> > > actually be a wait_for_complete_and_callback_has_returned(). That drops
> > > the symmetry between wait_for_complete() and is_complete(), which is
> > > awkward.
> > 
> > 
> > maybe is_ack(), is_safe() and is_complete()?
> > 
> > Yehuda
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org)
> > More majordomo info at http://vger.kernel.org/majordomo-info.html
> 
> Or set the bool to true, then do the callback, then signal? 

That's sort of what I was getting at with 
wait_for_complete_and_callback_returned().  We could make 
wait_for_complete() do that, although it should be a second bool because 
cond.Wait() can wake up nondeterministically (because of a signal or 
something).  For example I could clear the callback pointer after it 
returns, and make the wait loop check for the bool and callback_ptr == 
NULL.

It just means the wait_for_complete() does not actually wait for 
is_complete(), but is_complete() && did callback.  

sage
