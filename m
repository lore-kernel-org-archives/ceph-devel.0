From: Jon Mason <jon.mason@intel.com>
Subject: Re: [PATCH] README: Add missing "install"
Date: Fri, 21 Mar 2014 11:05:17 -0700
Message-ID: <20140321180517.GB12437@jonmason-lab>
References: <1395422784-13443-1-git-send-email-jon.mason@intel.com>
 <alpine.DEB.2.00.1403211047310.5823@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9203 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738AbaCUSKt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 21 Mar 2014 14:10:49 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1403211047310.5823@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Mar 21, 2014 at 10:49:26AM -0700, Sage Weil wrote:
> This appears to have already been fixed recently in 
> 	a4b3b786ff6d176c7aa62f7af2056d00c0bc57de

My apologies.  I did not see it in v0.77, and assumed it would be
given how trivial it is.  Sorry for the noise.

Thanks,
Jon

> 
> Thanks!
> sage
> 
> 
> On Fri, 21 Mar 2014, Jon Mason wrote:
> 
> > In the section describing how to build packages for Debian, the command
> > given to install dpkg-dev is incomplete.  "install" is needed for the
> > command to execute as desired.
> > 
> > Signed-off-by: Jon Mason <jon.mason@intel.com>
> > ---
> >  README | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/README b/README
> > index 197a7bf..825e932 100644
> > --- a/README
> > +++ b/README
> > @@ -58,7 +58,7 @@ Building packages
> >  You can build packages for Debian or Debian-derived (e.g., Ubuntu)
> >  systems with
> >  
> > -$ sudo apt-get dpkg-dev
> > +$ sudo apt-get install dpkg-dev
> >  $ dpkg-checkbuilddeps        # make sure we have all dependencies
> >  $ dpkg-buildpackage
> >  
> > -- 
> > 1.8.3.2
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
