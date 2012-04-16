From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: librados aio completion
Date: Mon, 16 Apr 2012 14:20:50 -0700
Message-ID: <59070F5B091941E0934A1175E82717B7@dreamhost.com>
References: <Pine.LNX.4.64.1204152141160.14018@cobra.newdream.net>
 <CAC-hyiFiL=a6dRaE-UkJ-egj1hJTSWQD-6GUitcmRiXvNrEUEA@mail.gmail.com>
 <Pine.LNX.4.64.1204161157440.10153@cobra.newdream.net>
 <CAC-hyiEFKkohqWhYRgrc0zvbhrZeca=YCrW00JTSqe-0v5DEpQ@mail.gmail.com>
 <D763974EEA9A43E08946E03484894631@dreamhost.com>
 <Pine.LNX.4.64.1204161405580.31853@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49049 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755004Ab2DPVUx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Apr 2012 17:20:53 -0400
Received: by gghe5 with SMTP id e5so2768619ggh.19
        for <ceph-devel@vger.kernel.org>; Mon, 16 Apr 2012 14:20:53 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1204161405580.31853@cobra.newdream.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, ceph-devel@vger.kernel.org

On Monday, April 16, 2012 at 2:07 PM, Sage Weil wrote:
> On Mon, 16 Apr 2012, Greg Farnum wrote:
> > Or set the bool to true, then do the callback, then signal? 
> 
> 
> That's sort of what I was getting at with 
> wait_for_complete_and_callback_returned(). We could make 
> wait_for_complete() do that, although it should be a second bool because 
> cond.Wait() can wake up nondeterministically (because of a signal or 
> something). For example I could clear the callback pointer after it 
> returns, and make the wait loop check for the bool and callback_ptr == 
> NULL.
> 
> It just means the wait_for_complete() does not actually wait for 
> is_complete(), but is_complete() && did callback.


Okay. I'm just thinking that we need "wait_for_complete()" to be the stronger variant, since that's how it previously behaved. (Whereas I believe that previously is_complete() and is_safe() functioned correctly inside callbacks, correct? So we need to preserve that behavior as well.)
If we want the weaker guarantee for some reason, we can add a wait_for_complete_response() or similar.

