From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] net: ceph: ceph_strings.c: Remove unused function
Date: Mon, 22 Dec 2014 06:35:54 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412220635430.11070@cobra.newdream.net>
References: <1419078894-31656-1-git-send-email-rickard_strandqvist@spectrumdigital.se> <CALFYKtD7wTNiTzekkWKZqBEb_7egij31Fhe=7J2Ey+arT3M_vA@mail.gmail.com> <CALFYKtCxOeoef0TXWUiymuA5-B0wodLuC2Rp_ib4B1m7DjfBcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54740 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754789AbaLVOfz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Dec 2014 09:35:55 -0500
In-Reply-To: <CALFYKtCxOeoef0TXWUiymuA5-B0wodLuC2Rp_ib4B1m7DjfBcQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>

On Mon, 22 Dec 2014, Ilya Dryomov wrote:
> On Sun, Dec 21, 2014 at 2:24 PM, Ilya Dryomov <ilya.dryomov@inktank.com> wrote:
> > On Sat, Dec 20, 2014 at 3:34 PM, Rickard Strandqvist
> > <rickard_strandqvist@spectrumdigital.se> wrote:
> >> Remove the function ceph_pool_op_name() that is not used anywhere.
> >>
> >> This was partially found by using a static code analysis program called cppcheck.
> >
> > It's part of pool op infrastructure and I'd rather we use it in
> > monc_show() than remove it.  I'll make a patch.
> 
> Actually, pool op stuff has been unused for over two years - looks like
> it was added for rbd create_snap and that got ripped out in 2012.  It's
> unlikely we'd ever need to manage pools or snaps from the kernel client
> so I think it makes sense to nuke it.  Sage?

Yep!

sage
