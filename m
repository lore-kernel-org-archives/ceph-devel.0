From: Mike Ryan <mike.ryan@inktank.com>
Subject: Re: bobtail timing
Date: Wed, 31 Oct 2012 20:17:28 -0700
Message-ID: <20121101031728.GF19642@splice>
References: <alpine.DEB.2.00.1210311341580.20646@cobra.newdream.net>
 <CAPrxi59Mcsm4zeJLL=WXQy9qyiBQ=JC6htOi9KN4Wmx7T8RnBQ@mail.gmail.com>
 <alpine.DEB.2.00.1210311436230.20646@cobra.newdream.net>
 <20121101031246.fcc80a63e2506af3fcaa9dda@ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:41951 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757186Ab2KADRc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 23:17:32 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1413157pad.19
        for <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 20:17:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121101031246.fcc80a63e2506af3fcaa9dda@ist.utl.pt>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Cl??udio Martins <ctpm@ist.utl.pt>
Cc: ceph-devel@vger.kernel.org

On Thu, Nov 01, 2012 at 03:12:46AM +0000, Cl??udio Martins wrote:
> 
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

The tarball is released as soon as it's tagged. The tag never changes
once it's tagged. Therefore tag v0.XX == tarball v0.XX.
