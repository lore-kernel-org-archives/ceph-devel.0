From: Sage Weil <sage@inktank.com>
Subject: Re: coverity scan - a plea for help!
Date: Fri, 1 Nov 2013 09:14:10 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1311010908160.23435@cobra.newdream.net>
References: <alpine.DEB.2.00.1305090922300.4023@cobra.newdream.net> <alpine.DEB.2.00.1310311627020.5407@cobra.newdream.net> <52730AD6.3030607@cs.utah.edu> <alpine.DEB.2.00.1311010847570.23435@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43634 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777Ab3KAQOL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Nov 2013 12:14:11 -0400
In-Reply-To: <alpine.DEB.2.00.1311010847570.23435@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xing Lin <xinglin@cs.utah.edu>, Li Wang <liwang@ubuntukylin.com>
Cc: ceph-devel@vger.kernel.org

A few notes:

I would prioritize things by severity, since that will make it easiest to 
see new high impact issues sooner.

There are lots of defects relating to the test code.  These are less 
important, but it would be nice to get them cleaned up eventually as well.

We've been setting the status to "Fix Submitted" once a patch is prepared 
and sent (via github pull request).

We've also been noting the coverity warning in the commit message.  
(Someday it might be useful to cross-reference these).  For example:

 CID 1100697 (#1 of 1): Uncaught exception (UNCAUGHT_EXCEPT)
 root_function: In function "main" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.

Thanks, everyone!
sage


On Fri, 1 Nov 2013, Sage Weil wrote:

> Awesome!  You just need to create a user at
> 
> https://scan.coverity.com/users/sign_up
> 
> Once you log in, click 'add yourself to an open source project' on the 
> right to request access.
> 
> Thanks!
> sage
> 
> 
> On Thu, 31 Oct 2013, Xing Lin wrote:
> 
> > Hi Sage,
> > 
> > I would like to help here as well.
> > 
> > Thanks,
> > Xing
> > 
> > On 10/31/2013 5:30 PM, Sage Weil wrote:
> > > Hi everyone,
> > > 
> > > When I send this out several months ago, Danny Al-Gaaf stepped up and
> > > submitted an amazing number of patches cleaning up the most concerning
> > > issues that Coverity had picked up.  His attention has been directed
> > > elsewhere more recently, but there are still a number of outstanding
> > > issues in Coverity's tracker that are reasonably quick and easy to resolve
> > > and will make our ability to identify newly introduced defects much
> > > simpler.
> > > 
> > > Coverity Scan makes it really easy to participate: just create an account
> > > and I can grant you access to the Ceph project.  If you're interested in
> > > contributing here (and it's an easy way to quickly start working with the
> > > Ceph code), let me know!
> > > 
> > > Thanks-
> > > sage
> > > 
> > > 
> > > On Thu, 9 May 2013, Sage Weil wrote:
> > > 
> > > > We were added to coverity's awesome scan program a while back, which gives
> > > > free access to their static analysis tool to open source projects.
> > > > 
> > > > Currently it identifies 421 issues.  We've already taken care of the ones
> > > > that are highest impact, but the usefulness of periodic scans is limited
> > > > until we can eliminate the noise from the remaining issues and easily see
> > > > when new problems come up.
> > > > 
> > > > If anybody is interested in helping out in the cleanup effort, let me know
> > > > and I'll share the login info.  This would provide significant value to
> > > > our overall quality efforts and is a pretty easy way to make a meaningful
> > > > contribution to the project without a huge investment in understanding the
> > > > code and architecture!
> > > > 
> > > > sage
> > > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
