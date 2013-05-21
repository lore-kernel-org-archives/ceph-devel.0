From: Sage Weil <sage@inktank.com>
Subject: Re: OSD memory leak when scrubbing [0.56.6]
Date: Tue, 21 May 2013 12:31:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305211231450.16413@cobra.newdream.net>
References: <519B9196.5090402@filoo.de> <CAF6-1L6E6s_wP6012ifwTRwZA4bp5+OLmYo92Y5QbmS20uxReA@mail.gmail.com> <FB4F06C0-410B-43C0-A5CE-64AFD18B29D0@profihost.ag> <alpine.DEB.2.00.1305210841410.30656@cobra.newdream.net> <519BCB15.8070502@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42156 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755512Ab3EUTbz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 May 2013 15:31:55 -0400
In-Reply-To: <519BCB15.8070502@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Sylvain Munaut <s.munaut@whatever-company.com>, Oliver Francke <Oliver.Francke@filoo.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 21 May 2013, Stefan Priebe wrote:
> Am 21.05.2013 17:44, schrieb Sage Weil:
> > On Tue, 21 May 2013, Stefan Priebe - Profihost AG wrote:
> > > Am 21.05.2013 um 17:35 schrieb Sylvain Munaut
> > > <s.munaut@whatever-company.com>:
> > > 
> > > > Hi,
> > > > 
> > > > > subject seems familiar, version was 0.48.3 in the last mail.
> > > > > 
> > > > > Not anyone else with perhaps large pg's experiencing such behaviour?
> > > > > 
> > > > > Any advice on how to proceed?
> > > > 
> > > > I had the same behavior in both argonaut and bobtail, raising sharply
> > > > ~ 100M or so at each scrub (every 24h).
> > > > 
> > > > It's now resolved in cuttlefish AFAICT.
> > > > 
> > > > However given the mon leveldb issues I'm having with cuttlefish, I'm
> > > > not sure I'd recommend upgrading ...
> > > 
> > > I thought all mon leveldb issues were solved?
> > 
> > Not quite.  I'm now able to reproduce the leveldb growth from Mike
> > Dawson's trace (thanks!) but we don't have a fix yet.
> 
> Oh OK. Is there a tracker id?

http://tracker.ceph.com/issues/4895

> 
> > I thought the scrub memory issues were addressed by
> > f80f64cf024bd7519d5a1fb2a5698db97a003ce8 in 0.56.4... :(
> > 
> > sage
> > 
> 
> 
