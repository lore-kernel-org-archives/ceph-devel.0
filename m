From: Sage Weil <sage@inktank.com>
Subject: Re: [GIT PULL] Ceph updates for 3.8
Date: Fri, 21 Dec 2012 10:59:55 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212211057000.28021@cobra.newdream.net>
References: <alpine.DEB.2.00.1212201319500.16508@cobra.newdream.net> <20121221185501.GA28092@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36653 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab2LUS74 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Dec 2012 13:59:56 -0500
In-Reply-To: <20121221185501.GA28092@fieldses.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: torvalds@linux-foundation.org, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 21 Dec 2012, J. Bruce Fields wrote:
> On Thu, Dec 20, 2012 at 01:29:49PM -0800, Sage Weil wrote:
> > Hi Linus,
> > 
> > Please pull the following Ceph updates for 3.8 from
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus
> > 
> > There's a trivial conflict in net/ceph/osd_client.c dealing with rbtree 
> > node initialization; the resolution is to keep the RB_CLEAR_NODE() call 
> > (see 4c199a93 for the conflicting commit).
> > 
> > There are a few different groups of commits here.  The largest is Alex's 
> > ongoing work to enable the coming RBD features (cloning, striping).  
> > There is some cleanup in libceph that goes along with it.  Cyril and David 
> > have fixed some problems with NFS reexport (leaking dentries and page 
> > locks),
> 
> Just out of curiosity--what's the state of NFS exports now?
> 
> I seem to recall initially it was sort-of supported by filehandle
> lookups didn't really work reliably?

That hasn't changed yet... if you miss both the client and MDS caches you 
get ESTALE.  The MDS cache is big, so this works okay for casual use, but 
it's not great.  This should be fixed on the server side of things for the 
next major release (cuttlefish).  The client code shouldn't need to 
change.

sage
