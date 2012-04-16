From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: librados aio completion
Date: Mon, 16 Apr 2012 12:51:46 -0700
Message-ID: <D763974EEA9A43E08946E03484894631@dreamhost.com>
References: <Pine.LNX.4.64.1204152141160.14018@cobra.newdream.net>
 <CAC-hyiFiL=a6dRaE-UkJ-egj1hJTSWQD-6GUitcmRiXvNrEUEA@mail.gmail.com>
 <Pine.LNX.4.64.1204161157440.10153@cobra.newdream.net>
 <CAC-hyiEFKkohqWhYRgrc0zvbhrZeca=YCrW00JTSqe-0v5DEpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45023 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705Ab2DPTvt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Apr 2012 15:51:49 -0400
Received: by mail-ob0-f174.google.com with SMTP id ta14so4049960obb.19
        for <ceph-devel@vger.kernel.org>; Mon, 16 Apr 2012 12:51:48 -0700 (PDT)
In-Reply-To: <CAC-hyiEFKkohqWhYRgrc0zvbhrZeca=YCrW00JTSqe-0v5DEpQ@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Monday, April 16, 2012 at 12:37 PM, Yehuda Sadeh Weinraub wrote:
> On Mon, Apr 16, 2012 at 12:00 PM, Sage Weil <sage@newdream.net (mailto:sage@newdream.net)> wrote:
> > 
> > I pushed a wip-2301 that does this. The downside to this approach is that
> > the is_safe() and is_complete() methods will return false until after the
> > callback returns, which includes the callback itself. So a callback that
> > assumes that is_complete() will return true will be wrong.
> > 
> > If that's not okay, the alternative is to make the wait_for_complete()
> > actually be a wait_for_complete_and_callback_has_returned(). That drops
> > the symmetry between wait_for_complete() and is_complete(), which is
> > awkward.
> 
> 
> maybe is_ack(), is_safe() and is_complete()?
> 
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html

Or set the bool to true, then do the callback, then signal? 

