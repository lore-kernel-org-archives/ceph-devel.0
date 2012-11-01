From: Sage Weil <sage@inktank.com>
Subject: Re: bobtail timing
Date: Wed, 31 Oct 2012 20:17:49 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210312014510.8302@cobra.newdream.net>
References: <alpine.DEB.2.00.1210311341580.20646@cobra.newdream.net> <CAPrxi59Mcsm4zeJLL=WXQy9qyiBQ=JC6htOi9KN4Wmx7T8RnBQ@mail.gmail.com> <alpine.DEB.2.00.1210311436230.20646@cobra.newdream.net> <20121101031246.fcc80a63e2506af3fcaa9dda@ist.utl.pt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36321 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757186Ab2KADRu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 23:17:50 -0400
In-Reply-To: <20121101031246.fcc80a63e2506af3fcaa9dda@ist.utl.pt>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?Cl=E1udio_Martins?= <ctpm@ist.utl.pt>
Cc: ceph-devel@vger.kernel.org

On Thu, 1 Nov 2012, Cl?udio Martins wrote:
> On Wed, 31 Oct 2012 14:38:28 -0700 (PDT) Sage Weil <sage@inktank.com> wrote:
> > On Wed, 31 Oct 2012, Noah Watkins wrote:
> > > Which branch is the freeze taken against? master?
> > 
> > Right.  Basically, every 3-4 weeks:
> > 
> >  - next is tagged as v0.XX
> >    - and is merged back into master
> >  - next branch is reset to current master
> >  - testing branch is reset to just-tagged v0.XX
> > 
> 
>  Hmm, interesting. But doesn't that mean that when the real v0.XX is
> later officially _released_, its top commit might not be the commit
> that was tagged as v0.XX? Assuming that issues are found after the
> testing branch is reset to v0.XX, fixes would go on top of v0.XX, right?
> 
>  Am I missing something, or people checking out a v0.XX with git might
> not be getting the real v0.XX that was released as tarballs?

The releases and tarballs contain *exactly* the content that is tagged 
v0.X.  The branches may accumulate additional fixes after that, which 
will later be tagged with a v0.X.Y point release.  Since we've started 
maintaing a stable release, we haven't done point releases for 
the development 'testing' releases, although if there are important bugs 
we may need to do so in the future.

The 'stable' branch tracks the last stable release (currently argonaut) 
and is where bug fixes accumulate until the next release.  For example, 
stable current contains v0.48.2 and several additional commits (mostly 
backports of proviioning scripts to support the ceph-deploy tool that 
we're working on).

sage

