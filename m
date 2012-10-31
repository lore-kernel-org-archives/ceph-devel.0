From: Sage Weil <sage@inktank.com>
Subject: Re: bobtail timing
Date: Wed, 31 Oct 2012 14:38:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210311436230.20646@cobra.newdream.net>
References: <alpine.DEB.2.00.1210311341580.20646@cobra.newdream.net> <CAPrxi59Mcsm4zeJLL=WXQy9qyiBQ=JC6htOi9KN4Wmx7T8RnBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33837 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756386Ab2JaVi3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 17:38:29 -0400
In-Reply-To: <CAPrxi59Mcsm4zeJLL=WXQy9qyiBQ=JC6htOi9KN4Wmx7T8RnBQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

On Wed, 31 Oct 2012, Noah Watkins wrote:
> Which branch is the freeze taken against? master?

Right.  Basically, every 3-4 weeks:

 - next is tagged as v0.XX
   - and is merged back into master
 - next branch is reset to current master
 - testing branch is reset to just-tagged v0.XX

sage


> 
> On Wed, Oct 31, 2012 at 1:46 PM, Sage Weil <sage@inktank.com> wrote:
> > I would like to freeze v0.55, the "bobtail" stable release, at the end of
> > next week.  If there is any functionality you are working on that should
> > be included, we need to get it into master (preferably well) before that.
> > There will be several weeks of testing in the 'next' branch after that
> > (probaly 3 weeks) before it is released.
> >
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
