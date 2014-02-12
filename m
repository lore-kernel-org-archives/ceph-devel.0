From: Sage Weil <sage@inktank.com>
Subject: Re: ACL tests
Date: Tue, 11 Feb 2014 21:07:40 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402112106390.17892@cobra.newdream.net>
References: <alpine.DEB.2.00.1401301616370.11959@cobra.newdream.net> <20140212040352.GA5659@x230>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41830 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743AbaBLFHl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Feb 2014 00:07:41 -0500
In-Reply-To: <20140212040352.GA5659@x230>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guangliang Zhao <lucienchao@gmail.com>
Cc: li.wang@ubuntukylin.com, zheng.z.yan@intel.com, ceph-devel@vger.kernel.org

On Wed, 12 Feb 2014, Guangliang Zhao wrote:
> On Thu, Jan 30, 2014 at 04:20:46PM -0800, Sage Weil wrote:
> 
> Hi Sage,
> 
> Sorry for the late reply, I just returned from a long vacation :-)

No problem. Welcome back!

> I have found some issues which maybe relate the bugs you mentioned, and
> the patches are coming soon. 

Zheng has just posted several patches to the list today that address some 
of the problems; I would look at those as well.

Thanks!
sage

> 
> > Hi Guangliang,
> > 
> > There were a few hiccups getting the ACL support into Linus's tree, but 
> > it's in now, and it appears to work.  However, I tried out the tuxera 
> > posix test suite at
> > 
> >  http://www.tuxera.com/community/posix-test-suite/
> >  http://tuxera.com/sw/qa/pjd-fstest-20090130-RC.tgz
> > 
> > which has a set of acl tests, and several of them fail.  I would like to 
> > get the tests to all pass and get them added to the night QA so that we 
> > won't be chasing down (as many) strange user reports of permission errors 
> > down the line.  Are you able to take a look?
> 
> OK, I would investigate it ASAP.
> 
> > 
> > Thanks!
> > sage
> 
> -- 
> Best regards,
> Guangliang
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

