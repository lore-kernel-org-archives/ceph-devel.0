From: Sage Weil <sage@inktank.com>
Subject: Re: branches
Date: Fri, 18 Jan 2013 11:36:37 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301181133290.8622@cobra.newdream.net>
References: <alpine.DEB.2.00.1301081038580.30467@cobra.newdream.net> <alpine.DEB.2.00.1301181031130.8622@cobra.newdream.net> <50F99C30.7030205@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48809 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172Ab3ARTgi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Jan 2013 14:36:38 -0500
In-Reply-To: <50F99C30.7030205@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

On Fri, 18 Jan 2013, Stefan Priebe wrote:
> Hi,
> 
> what's bobtail-next then? bobtail itself also contains already updates since
> 056.1?

Just a few backported things I wanted a few eyeballs on before I put it in 
bobtail.

Generally speaking, the bobtail and argonaut branches are safe to run 
directly.  The caveat is they haven't been hammered in their final form by 
the nightly qa runs yet.

sage


> 
> Stefan
> 
> Am 18.01.2013 19:32, schrieb Sage Weil:
> > I went ahead and made this change last week.
> > 
> > Just a remind, the new world order is:
> > 
> > > master
> > >   - active development
> > > next
> > >   - frozen for next release
> > >   - bug fixes only
> > >   - regularly merged back into master
> > > last
> > >   - last release (instead of 'testing')
> > >   - packages at /debian-testing and /debian-last, /rpm-testing, /rpm-last
> > > bobtail
> > >   - bobtail backport series 0.56.x
> > >   - packages at /debian-bobtail (and /debian, until cuttlefish),
> > >     /rpm-bobtail, /rpm
> > > argonaut
> > >   - argonaut backport series 0.48.x
> > >   - packages at /debian-argonaut
> > 
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
