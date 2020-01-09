From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 6/6] ceph: perform asynchronous unlink if we have
 sufficient caps
Date: Thu, 09 Jan 2020 16:30:06 -0500
Message-ID: <9ec865ed1431455a6f272ab2c06a129624363902.camel@kernel.org>
References: <20200106153520.307523-1-jlayton@kernel.org>
         <20200106153520.307523-7-jlayton@kernel.org>
         <8f5e345a-2743-5868-3d89-017db6ae3d8c@redhat.com>
         <9cd39feb0b8d92f29af69a787355b89359c797a8.camel@kernel.org>
         <CA+2bHPaML5kSYaZrNPsDHYTv-7_scEPWZ2xkD0fxp2Pg5G1cCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgAIVaI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 9 Jan 2020 16:30:08 -0500
In-Reply-To: <CA+2bHPaML5kSYaZrNPsDHYTv-7_scEPWZ2xkD0fxp2Pg5G1cCA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>

On Thu, 2020-01-09 at 09:53 -0800, Patrick Donnelly wrote:
> On Thu, Jan 9, 2020 at 3:34 AM Jeff Layton <jlayton@kernel.org> wrote:
> > On Thu, 2020-01-09 at 17:18 +0800, Yan, Zheng wrote:
> > > > +bool enable_async_dirops;
> > > > +module_param(enable_async_dirops, bool, 0644);
> > > > +MODULE_PARM_DESC(enable_async_dirops, "Asynchronous directory operations enabled");
> > > > +
> > > 
> > > why not use mount option
> > > 
> > 
> > I'm open to suggestions here.
> > 
> > I mostly put this in originally to help facilitate performance testing.
> > A module option makes it easy to change this at runtime (without having
> > to remount or anything).
> > 
> > That said, we probably _do_ want to have a way for users to enable or
> > disable this feature. We'll probably want this disabled by default
> > initially, but I can forsee that changing once get more confidence.
> > 
> > Mount options are a bit of a pain to deal with over time. If the
> > defaults change, we need to document that in the manpages and online
> > documentation. If you put a mount option in the fstab, then you have to
> > deal with breakage if you boot to an earlier kernel that doesn't support
> > that option.
> > 
> > My thinking is that we should just use a module option initially (for
> > the really early adopters) and only convert that to a mount option as
> > the need for it becomes clear.
> 
> Module option makes sense.
> 
> A mount option to disable async ops would also make sense. I do not
> think the default behavior should be off-by-default.
> 
> (Someday perhaps the kernel will be smart enough to also digest the
> ceph configs delivered through the monitors...)
> 

I do think it should be off for now until we have some early adopters
play with it, and make sure it doesn't fall down in unexpected ways.

Once we've had it in place for a while (a couple of kernel releases?),
and some success with it, I'd be open to flipping the default to on
though.
-- 
Jeff Layton <jlayton@kernel.org>
