From: Sage Weil <sage@inktank.com>
Subject: Re: 0.55 init script Issue?
Date: Thu, 6 Dec 2012 05:28:28 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212060527470.13653@cobra.newdream.net>
References: <50BF7314.2020809@gammacode.com> <50BFA354.7040308@inktank.com> <50BFABE5.1020904@ubuntu.com> <CAPYLRzjme=UxScsKDXdKPAWJyfxB1hNQGRJWT7QyJk+ET3dFHQ@mail.gmail.com> <alpine.DEB.2.00.1212051610560.16078@cobra.newdream.net>
 <20121206013449.GH6375@blade.matthewvia.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49171 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754993Ab2LFN22 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Dec 2012 08:28:28 -0500
In-Reply-To: <20121206013449.GH6375@blade.matthewvia.info>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matthew Via <via@matthewvia.info>
Cc: ceph-devel@vger.kernel.org

On Wed, 5 Dec 2012, Matthew Via wrote:
> On the subject of init script problems, for the 0.55 Ceph release on EL6, 
> the init script has what looks like a typo on line 280, and in 
> /sbin/mkcephfs on line 328:
>   fs_type = "btrfs"
> 
> As far as I know, shell variable assignments must have not have a space
> between variable and the = -- the init script and mkcephfs will not run
> as is.  It'd be nice to have this fixed in .55.1 if released.

Definitely, thanks!  This is pushed to the testing branch.  We should be 
able to build a 0.55.1 tomorrow.

Thanks!
sage



> 
> Thanks, Matthew
> 
> On 16:11 Wed 05 Dec     , Sage Weil wrote:
> > On Wed, 5 Dec 2012, Gregory Farnum wrote:
> > > On Wed, Dec 5, 2012 at 12:17 PM, James Page <james.page@ubuntu.com> wrote:
> > > > -----BEGIN PGP SIGNED MESSAGE-----
> > > > Hash: SHA256
> > > >
> > > > On 05/12/12 19:41, Dan Mick wrote:
> > > >> The story as best I know it is that we're trying to transition to
> > > >> and use upstart where possible, but that the upstart config does
> > > >> not (yet?) try to do what the init.d config did.  That is, it
> > > >> doesn't support options to the one script, but rather separates
> > > >> daemons into separate services, and does not reach out to remote
> > > >> machines to start daemons, etc.
> > > >>
> > > >> The intent is that init.d/ceph is left for non-Upstart distros,
> > > >> AFAICT.
> > > >>
> > > >> Tv had some design notes here:
> > > >>
> > > >> http://www.mail-archive.com/ceph-devel@vger.kernel.org/msg09314.html
> > > >>
> > > >>  We need better documentation/rationale here at least.
> > > >
> > > > Maybe it might be better if the ceph init script and the ceph upstart
> > > > configuration did not namespace clash; how about shifting the name of
> > > > the ceph upstart configuration to ceph-all?
> > > 
> > > Yeah, this or something very similar is definitely the correct
> > > solution. Sage recently added the "ceph" upstart job, and we didn't
> > > put it through sufficient verification prior to release in order to
> > > notice this issue. Users who aren't using upstart (I expect that's all
> > > of them) should just delete the job after running the package install.
> > > We'll certainly sort this out prior to the next release; I'm not sure
> > > if we want to roll a v0.55.1 right away or not.
> > 
> > Let's push it to the testing branch, but make sure any other fixes are 
> > there before rolling a .1.. maybe tomorrow?
> > 
> > Thanks!
> > sage
> > 
> > 
> > > -Greg
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
